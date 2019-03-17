I = imread ('11d.JPG');
I1 = rgb2gray(I);
colormap gray;

 % Size of the image
 r = size(I2,1);
 c = size(I2,2);
 count = zeros(1,256);

 % Counting number of pixels 
 for i=1:r
   for j=1:c
       p = I1(i,j);
       count(p+1) = count(p+1) + 1;
   end
 end

 % pi = n/size
   for x=1:256
     pi(x)= ((count(x))/(r*c));
   end

  % calculate CDF
   cdf(1) = pi(1);
   for s = 2:256
        cdf(s) = cdf(s-1)+ pi(s);
   end

   % calculate Transfer function T
    for k=1:256
        T(k)=cdf(k) * 255;
    end

   % Equilization with Transferfunction
    for i=1:r
        for j=1:c
            I2(i,j) =T(I1(i,j));
         end
    end
 
figure(1)
subplot(3,2,1)
imshow(I)
subplot(3,2,2)
plot(imhist(I))

subplot(3,2,3)
imshow(I1)
subplot(3,2,4)
plot(imhist(I1))

subplot(3,2,5)
imshow(I3)
subplot(3,2,6)
plot(imhist(I3))