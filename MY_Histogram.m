I = imread('low_contrast.jpg', 'JPG');
x = rgb2gray(I);
colormap gray;
r = size(x,1);
c = size(x,2);

count = zeros(1,256);
% count number of different value from 0 to 255
for i = 1:r
     for j = 1:c
         p = x(i,j);
         count(p+1) = count(p+1) + 1;
     end
end

cdf(1) = count(1);
for j = 2:255
    cdf(j) = cdf(j-1) + count(j);
end
   
 for i = 1:r
     for j = 1:c
         x2(i,j) = round((cdf(x(i,j)) - cdf(1))/(r*c - cdf(1)) * 255);
     end
 end
 
% subplot(1,2,1);
% plot(imhist(x));
% subplot(1,2,2);
imshow(I);







