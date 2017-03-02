function [ output_image_data ] = nearest_neighbor_interpolation(image_data,des_size)
% % % Nearest neighbor interpolation assign the value of the 'nearest' pixel to new pixels.
% % % It is simple but might produce undesirable artifacts, such as severe distortion of straight edges.

original_image_size = size(image_data);

% calculate the X and Y coordinates of pixels
%   using the inverse equation of the linear equation X_des = k_x*X_inverse + b_x;
X_des_pixel = 1:des_size(1);
b_x = double(original_image_size(1)-des_size(1))/double(original_image_size(1)-1);
k_x = double(des_size(1)-1)/double(original_image_size(1)-1);
X_inverse_pixel_int = round((X_des_pixel-b_x)/k_x);
Y_des_pixel = 1:des_size(2);
b_y = double(original_image_size(2)-des_size(2))/double(original_image_size(2)-1);
k_y = double(des_size(2)-1)/double(original_image_size(2)-1);
Y_inverse_pixel_int = round((Y_des_pixel-b_y)/k_y);


% assign values 
output_image_data = image_data(X_inverse_pixel_int,Y_inverse_pixel_int);


end

