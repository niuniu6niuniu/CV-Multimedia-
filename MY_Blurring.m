J = imread('11d.jpg', 'JPG');
J1 = J;
J2 = J;

% High-Pass Filter
H = [0,-1,0;-1,5,-1;0,-1,0];
% Convolution
J1(:,:,1) = conv2(J1(:,:,1), H, 'same')
J1(:,:,2) = conv2(J1(:,:,2), H, 'same')
J1(:,:,3) = conv2(J1(:,:,3), H, 'same')
% Low-Pass Filter
L = [1/9,1/9,1/9;1/9,1/9,1/9;1/9,1/9,1/9];
% Convolution
J2(:,:,1) = conv2(J2(:,:,1), L, 'same')
J2(:,:,2) = conv2(J2(:,:,2), L, 'same')
J2(:,:,3) = conv2(J2(:,:,3), L, 'same')

% imshow(J);
% imshow(J1);
imshow(J2);

