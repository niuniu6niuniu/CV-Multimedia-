I = imread('11d.jpg', 'JPG');
r = size(x,1);
c = size(x,2);

% one row r*c columns zero matrix
x1r = zeros(1,r*c);
 for i = 1:r
     for j = 1:c
         p = x(i,j);
         x1r((i-1)*r + j) = p;
     end
 end
 
 m = zeros(1,r*c);
 for i = 1:r*c-2
     m(i) = median(x1r(i:i+2));
 end
 
 for j = r*c-1:r*c
     m(j) = median(x1r(j-2:j));
 end

 xm = x;
for i = 1:r
    for j = 1:c
        xm(i,j) = m((i-1)*r + j);
    end
end

imshow(x);

    
     

