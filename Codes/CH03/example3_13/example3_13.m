source_data = im2double(imread('blurtest.tif'));
mask_size = 5; 
% the size of mask shall be odd, so that the center of the mask is of certainty.
mask = ones(mask_size)/(mask_size^2); 
% box filter, see figure 3.32 in Gonzalez(3rd ed)


tic
output_data = conv2(source_data,mask,'same');
% by adding 'same' parameter, conv2 automaticlly get the result of size of size(source_data) without padding and cropping.
%output_data = imfilter (source_data, mask,'conv'); % matlab built-in filtering
toc


imshow(source_data);
figure;
imshow(output_data);

