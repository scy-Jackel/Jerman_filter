clear
clc

%% Enhancement of the 3D cerebral vasculature

% load input image
fname= 'Please enter your file path';
info = imfinfo(fname);
num_images = numel(info);
for i=1:num_images
     a= imread(fname,i);
     I(:,:,i)=a;
end

%rotate volume for visualization
I = permute(I,[3,1,2]);
I = I(end:-1:1,:,:);

%normalize input a little bit
I = I - min(I(:));
I = I / prctile(I(I(:) > 0.5 * max(I(:))),90);
I(I>1) = 1;

% compute enhancement for two different tau values
V = vesselness3D(I, 1:4, [1;1;1], 0.5, true);

% display result
figure; 
subplot(1,2,1)
% maximum intensity projection
imshow(max(I,[],3))
title('MIP of the input image')
axis image

subplot(1,2,2)
% maximum intensity projection
imshow(max(V,[],3))
title('MIP of the filter enhancement (tau=0.75)')
axis image

img_name = 'E:\pycharmProjects\NueronProject\outJerman\';
num_images = size(V);
for i=1:num_images(3)
     J = V(:,:,i);
     imwrite(uint8(J),[img_name,num2str(i),'.tif'],'WriteMode','append');
end