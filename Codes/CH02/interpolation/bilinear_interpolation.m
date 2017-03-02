function [ output_image_data ] = bilinear_interpolation(image_data,des_size)
% % % Nearest neighbor interpolation assign the value of the 'nearest' pixel to new pixels.
% % % It is simple but might produce undesirable artifacts, such as severe distortion of straight edges.


original_image_size = size(image_data);
padded_data = [image_data,image_data(:,end);
                image_data(end,:),image_data(end,end)];

% calculate the X and Y coordinates of pixels
X_des_pixel = 1:des_size(1);
b_x = double(original_image_size(1)-des_size(1))/double(original_image_size(1)-1);
k_x = double(des_size(1)-1)/double(original_image_size(1)-1);
X_inverse_pixel_double = (X_des_pixel-b_x)/k_x;
X_inverse_pixel_int = floor(X_inverse_pixel_double);
X_offset = X_inverse_pixel_double - X_inverse_pixel_int;
X_offset = repmat(X_offset,[des_size(2),1]);

Y_des_pixel = 1:des_size(2);
b_y = double(original_image_size(2)-des_size(2))/double(original_image_size(2)-1);
k_y = double(des_size(2)-1)/double(original_image_size(2)-1);
Y_inverse_pixel_double = (Y_des_pixel-b_y)/k_y;
Y_inverse_pixel_int = floor(Y_inverse_pixel_double);
Y_offset = Y_inverse_pixel_double - Y_inverse_pixel_int;
Y_offset = repmat(Y_offset,[des_size(1),1]);

% calculate the four neighbor pixels of (x,y)
TL = double(padded_data(X_inverse_pixel_int,Y_inverse_pixel_int));
BL = double(padded_data(X_inverse_pixel_int+1,Y_inverse_pixel_int));
BR = double(padded_data(X_inverse_pixel_int+1,Y_inverse_pixel_int+1));
TR = double(padded_data(X_inverse_pixel_int,Y_inverse_pixel_int+1));

% calculate the top and botton 'pixel' of (x,y) 
%   using linear interpolation method

TC = Y_offset.*(TR-TL)+TL;
BC = Y_offset.*(BR-BL)+BL;
CC = X_offset' .*(BC-TC)+TC;

output_image_data = CC;








