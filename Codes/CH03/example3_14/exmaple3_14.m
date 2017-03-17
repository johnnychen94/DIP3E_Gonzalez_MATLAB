source_data = im2double(imread('ckt_board.tif'));
mask_size = 3;
fun = @(x) median(x(:));


tic
output_data = nlfilter(source_data,[mask_size,mask_size],fun); 
% nlfilter applies fun to every pixel of source_data
toc


imshow(source_data);
figure;
imshow(output_data);