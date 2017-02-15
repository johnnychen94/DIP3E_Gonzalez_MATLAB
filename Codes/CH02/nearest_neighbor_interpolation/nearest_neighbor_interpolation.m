function [ output_image_data ] = nearest_neighbor_interpolation(image_data,des_size)
% % % Nearest neighbor interpolation assign the value of the 'nearest' pixel to new pixels.
% % % It is simple but might produce undesirable artifacts, such as severe distortion of straight edges.

original_image_size = size(image_data);

% calculate the X and Y coordinates of pixels
X_des_pixel = 1:des_size(1);
X_inverse_pixel_int = floor(X_des_pixel*original_image_size(1)/des_size(1));
Y_des_pixel = 1:des_size(2);
Y_inverse_pixel_int = floor(Y_des_pixel*original_image_size(2)/des_size(2));
% deal with border situation
X_inverse_pixel_int(X_inverse_pixel_int==0) = 1;
Y_inverse_pixel_int(Y_inverse_pixel_int==0) = 1;

% assign values
output_image_data = image_data(X_inverse_pixel_int,Y_inverse_pixel_int);


end

