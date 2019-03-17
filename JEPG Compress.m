close all
clear all
clc
%% ****************************** N=(4,6,8) ******************************
N=8; % size of block
image_org = imread('scenery-06.jpg');
width = size(image_org, 1);
height = size(image_org, 2);
width = width - mod(width,N);
height = height - mod(height,N);
image_org = image_org(1:width,1:height,:);
% Get the number of rows and columns, 
% and, most importantly, the number of color channels.
[rows, columns, numberOfColorChannels] = size(image_org);
if numberOfColorChannels > 1
    % It's a true color RGB image.  We need to convert to gray scale.
    image_gray = rgb2gray(image_org);
else
    % It's already gray scale.  No need to convert.
    image_gray = image_org;
end
% image_gray = rgb2gray(image_org);
image_double = im2double(image_gray);
image_dct = dct2(image_double);
% imwrite(image_org,'org.jpg');
% imwrite(image_gray,'gray.jpg');
% imwrite(image_double,'double.jpg');
% imwrite(image_dct,'dct.jpg');
% ****************************** eta=(0.003,0.01) ******************************
eta = 0.1; % threshold
block = dctmtx(N);
%% same as dctmtx(N)
% block = zeros(N);
% block(1,:) = ones(1,N)/sqrt(N);
% for k = 1:N-1
% block(k+1,:) = sqrt(2)*cos((2*(0:N-1)+1)*k*pi/(2*N))/sqrt(N);
% end
%% only for 8*8
      dct_index = [16 11 10 16 24 40 51 61;
                   12 12 14 19 26 58 60 55;
                   14 13 16 24 40 57 69 56;
                   14 17 22 29 51 87 80 62;
                   18 22 37 56 68 109 103 77;
                   24 35 55 64 81 104 113 92;
                   49 64 78 87 103 121 120 101;
                   72 92 95 98 112 100 103 99 ];
%% dct for 6*6
%    dct_index = [16 11 16 24 51 61;
%                 12 12 19 26 60 55;
%                 14 17 29 51 80 62;
%                 18 22 56 68 103 77;
%                 49 64 87 103 120 101;
%                 72 92 98 112 103 99 ];
%% dct for 4*4
%       dct_index = [16  10  24  51 ;   
%                    14  16  40  69 ; 
%                    18  37  68  103 ;   
%                    49  78  103  120];

%% coding, only for N = 8, o.w. dct_index must be given. eta can be changed
for i = 1:N:width
for j = 1:N:height
current_block = image_double(i:i+N-1, j:j+N-1);
dct_block = block * current_block * block';
image_dct_trans(i:i+N-1, j:j+N-1) = dct_block;
dct_block = dct_block ./ dct_index;
dct_block(abs(dct_block) < eta) = 0;
image_dct_quan(i:i+N-1, j:j+N-1) = dct_block;
end
end
imwrite(image_dct_trans,'dct_trans.jpg');
%% decoding
for i = 1:N:width
for j = 1:N:height
current_block = image_dct_quan(i:i+N-1, j:j+N-1) .* dct_index;
dct_block_inverse = block' * current_block * block;
image_dct_inverse(i:i+N-1, j:j+N-1) = dct_block_inverse;
end
end
imwrite(image_dct_inverse,'dct_inverse.jpg');
%% use of blkproc(), the example is only for N = 8. Mask can be changed
image_blkproc=blkproc(image_double,[N,N],'P1*x*P2',block,block');
% mask for 8*8
       mask = [1 1 1 1 0 0 0 0
               1 1 1 0 0 0 0 0
               1 1 0 0 0 0 0 0
               1 0 0 0 0 0 0 0
               0 0 0 0 0 0 0 0
               0 0 0 0 0 0 0 0
               0 0 0 0 0 0 0 0
               0 0 0 0 0 0 0 0];
 % mask for 6*6
%     mask = [1 1 1 1 0 0 
%             1 1 1 0 0 0 
%             1 1 0 0 0 0 
%             1 0 0 0 0 0 
%             0 0 0 0 0 0 
%             0 0 0 0 0 0];
 % mask for 4*4
%        mask = [1 1 0 0 
%                1 0 0 0 
%                0 0 0 0 
%                0 0 0 0];
 
image_mask = blkproc(image_blkproc,[N N],'P1.*x',mask);

imwrite(image_blkproc, 'blkproc.jpg');
imwrite(image_mask, 'mask.jpg');
image_dct_recover=blkproc(image_mask,[N,N],'P1*x*P2',block',block);
imwrite(image_dct_recover,'dct_recover.jpg');
%% run length code
L = 8; %division parameter, can be changed
distance = 256/L;
image_int = reshape(image_gray,[],1);
for i = 1:1:length(image_int)
image_1d(i) = round((image_int(i))/distance);
end
image_1d = double(image_1d);
j = 1;
repeat = 1;
for i = 1:1:length(image_1d)-1
if image_1d(i+1) == image_1d(i)
repeat = repeat + 1;
else
image_rlc(1,j) = image_1d(i);
image_rlc(2,j) = repeat;
j = j + 1;
repeat = 1;
end
end
image_rlc(1,j) = image_1d(i);
image_rlc(2,j) = repeat;
%% compute size reduction
compress_ratio_rlc = width*height/size(image_rlc,2)/2;
%% decoding of rlc
current = 1;
for i = 1:1:size(image_rlc,2)
for j = 1:1:image_rlc(2,i)
image_rlc_recover(current) = (image_rlc(1,i) + 0.5) * distance;
current = current + 1;
end
end
image_rlc_recover = reshape(image_rlc_recover, width, height)/256;
imwrite(image_rlc_recover, 'rlc_recover.jpg');