function [ output_image_data ] = bilinear_interpolation(image_data,des_size)
% % % Nearest neighbor interpolation assign the value of the 'nearest' pixel to new pixels.
% % % It is simple but might produce undesirable artifacts, such as severe distortion of straight edges.


src_size = size(image_data);

% calculate the X and Y coordinates of pixels
X_des_pixel = 1:des_size(1);
X_inverse_pixel_double = X_des_pixel*src_size(1)/des_size(1);
X_inverse_pixel_int = floor(X_inverse_pixel_double);
X_offset = X_inverse_pixel_double - X_inverse_pixel_int;

Y_des_pixel = 1:des_size(2);
Y_inverse_pixel_double = Y_des_pixel*src_size(2)/des_size(2);
Y_inverse_pixel_int = floor(Y_inverse_pixel_double);
Y_offset = Y_inverse_pixel_double - Y_inverse_pixel_int;

% deal with border situation
X_inverse_pixel_int(X_inverse_pixel_int==0) = 1;
Y_inverse_pixel_int(Y_inverse_pixel_int==0) = 1;

% claculate coefficients and values
[temp_x,temp_y] = meshgrid(Y_offset,X_offset);
co(:,:,1) = (1-temp_x).*(1-temp_y);
co(:,:,2) = (1-temp_x).*temp_y;
co(:,:,3) = temp_x.*(1-temp_y);
co(:,:,4) = temp_x.*temp_y;

va(:,:,1) = double(image_data(X_inverse_pixel_int,Y_inverse_pixel_int));
va(:,:,2) = va(:,:,1);
va(:,1:end-1,2) = va(:,2:end,1);
va(:,:,3) = va(:,:,1);
va(1:end-1,:,3) = va(2:end,:,1);
va(:,:,4) = va(:,:,1);
va(1:end-1,1:end-1,4) = va(2:end,2:end,1);

% assign values
output_image_data = sum(co.*va,3);



