% Gonzalez (3rd ed) example 5.3, including figure 5.10, 5.11 and 5.12



% plot figure 5.10
mask_size = 3;
sp_cktb = imread('Fig0510(a)(ckt-board-saltpep-prob.pt05).tif');
med_filter = @(mask)median(mask(:));
med_0 = sp_cktb;
med_1 = nlfilter(med_0,[mask_size,mask_size],med_filter);
med_2 = nlfilter(med_1,[mask_size,mask_size],med_filter);
med_3 = nlfilter(med_2,[mask_size,mask_size],med_filter);

figure
subplot(2,2,1),imshow(med_0,[]),title('salt&pepper noise');
subplot(2,2,2),imshow(med_1,[]),title('median filter for one time');
subplot(2,2,3),imshow(med_2,[]),title('median filter for two times');
subplot(2,2,4),imshow(med_3,[]),title('median filter for three times');



%plot figure 5.11
mask_size = 3;
p_cktb = imread('Fig0508(a)(circuit-board-pepper-prob-pt1).tif');
s_cktb = imread('Fig0508(b)(circuit-board-salt-prob-pt1).tif');
max_filter = @(mask)max(mask(:));
min_filter = @(mask)min(mask(:));
max_cktb = nlfilter(p_cktb,[mask_size,mask_size],max_filter);
min_cktb = nlfilter(s_cktb,[mask_size,mask_size],min_filter);

figure
subplot(1,2,1),imshow(max_cktb,[]),
title('denoising pepper noise with max filter');
subplot(1,2,2),imshow(min_cktb,[]),
title('denoising salt noise with min filter');



% plot figure 5.12
mask_size = 5;
u_cktb = imread('Fig0512(a)(ckt-uniform-var-800).tif');
sp_cktb = im2double(...
    imread('Fig0512(b)(ckt-uniform-plus-saltpepr-prob-pt1).tif'));

arith_mask = ones(mask_size)/mask_size^2;
arith_cktb = conv2(sp_cktb,arith_mask,'same');

geo_mask = arith_mask;
geo_cktb = exp(conv2(log(1+sp_cktb),geo_mask,'same'))-1;
    % constant 1 is used to regularize the image

%med_filter = @(mask) median(mask(:));
med_cktb = nlfilter(sp_cktb,[mask_size,mask_size],med_filter);

d=5; 
% NOTE: when d=5 in 5*5 mask (20% removed), the alpha-trimmed mean
%       filter is inferior to the median filter;
%       when d=15 in 5%5 mask(60% removed), the alpha-trimmed mean 
%       filter is superior to the median filter;
% TODO: the perfermances of alpha-trimmed filter and median filter are
% remained to be examined more carefully.
alpha_filter = @(x) alpha_mean(x,d); 
    % floor(d/2) lowest and highest intensity values are cut off respectively.
alpha_cktb = nlfilter(sp_cktb,[mask_size,mask_size],alpha_filter);
    
    
figure
subplot(3,2,1),imshow(u_cktb,[]),title('uniform noise');
subplot(3,2,2),imshow(u_cktb,[]),title('salt&pepper noise');
subplot(3,2,3),imshow(arith_cktb,[]),
title('arithmetic filter on salt&pepper noise');
subplot(3,2,4),imshow(geo_cktb,[]),
title('geometric filter on salt&pepper noise');
subplot(3,2,5),imshow(med_cktb,[]),
title('median filter on salt&pepper noise');
subplot(3,2,6),imshow(alpha_cktb,[]),
title('alpha-trimmed filter on salt&pepper noise');


function dest_intensity = alpha_mean(mask,d)
    d = floor(d/2);
    sorted_intensities = sort(mask(:));
    dest_intensity = mean(sorted_intensities(d+1:end-d));
end

