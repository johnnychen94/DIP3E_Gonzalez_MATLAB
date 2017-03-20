% Gonzalez (3rd ed) example 5.4, including figure 5.13

mask_size =7;
gauss_cktb = im2double(imread('Fig0513(a)(ckt_gaussian_var_1000_mean_0).tif'));

arith_mask = ones(mask_size)/mask_size^2;
arith_cktb = conv2(gauss_cktb,arith_mask,'same');

geo_mask = ones(mask_size)/mask_size^2;
geo_cktb = exp(conv2(log(1+gauss_cktb),geo_mask,'same'))-1;
    % constant 1 is used to regularize the image

global_varience = var(gauss_cktb(:));
adap_filter = @(mask) variance_adaptive_filter(mask,global_varience,mask_size);
adap_cktb = nlfilter(gauss_cktb,[mask_size,mask_size],adap_filter);


figure
subplot(2,2,1),imshow(gauss_cktb,[]),
title('gaussian noise');
subplot(2,2,2),imshow(arith_cktb,[]),
title('arithmetic filter on gaussian noise');
subplot(2,2,3),imshow(geo_cktb,[]),
title('geometric filter on gaussian noise');
subplot(2,2,4),imshow(adap_cktb,[]),
title('varience-adaptive filter on gaussian noise');
    

function dest_intensity = variance_adaptive_filter(mask, global_variance, mask_size)
% the kernel function of variance adaptive filter
    center_pixel = [floor(mask_size/2)+1,floor(mask_size/2)+1];
    local_variance = var(mask(:))+0.01;
    local_mean = mean(mask(:));
    center_intensity = mask(center_pixel(1),center_pixel(2));
    dest_intensity = center_intensity - ...
        (center_intensity-local_mean)*global_variance/local_variance;
end

