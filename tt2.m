I = imread('low_contrast.jpg', 'JPG');
x = rgb2gray(I);
colormap gray;
% row and column size
r = size(x,1);
c = size(x,2);
% Empty column vector, 0 in 1, 255 in 256
A = zeros(1,256);

% count number of different value from 0 to 255
for i = 1:r
     for j = 1:c
         p = x(i,j);
         A(p+1) = A(p+1) + 1;
     end
end

% compute the occurences of these value
for m = 1:256
    pi(m) = (A(m)/(r*c));
end
% compute CDF
cdf(1) = pi(1);
for n = 2:256
    cdf(n) = cdf(n-1) + pi(n);
end

for s=1:256
    T(s) = cdf(s) * 256;
end

for m = 1:r
    for n = 1:c
        x2(m,n) = T(x(m,n));
    end
end

imshow(x2);

 