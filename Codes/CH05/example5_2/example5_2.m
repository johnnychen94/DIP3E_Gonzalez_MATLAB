% Gonzalez (3rd ed) example 5.2, including figure 5.7, 5.8 and 5.9

% On geometric mean filter:
%  A more efficient way for implementing geometric mean filter is: 
%   1. log(image);
%   2. denoised_image = conv(arith_mask,image);
%   3. exp(denoised_image);

% On Harmonic mean filter and Contraharmonic mean filter:
%  At present I haven't figured out a linear(convolution) method to apply
%  these two filters. So an iteration method using double for-loop would be
%  used in this example, as we might see, the processing time is quite long.

% Indeed, both Harmonic mean and Contraharmonic mean are special case of
% Lehmer mean, which is defined as lehmermean(x,p) = sum(x^p)/sum(x^(p-1)).
% It is Harmonic mean when p=0, while Contraharmoic mean when p=2. Hence
% the definition of contraharmonic mean in Gonzalez is somehow inappropriate.

mask_size =3;

orig_cktb = im2double(imread('Fig0507(a)(ckt-board-orig).tif'));
gauss_cktb = im2double(imread('Fig0507(b)(ckt-board-gauss-var-400).tif'));
pepper_cktb = im2double(imread('Fig0508(a)(circuit-board-pepper-prob-pt1).tif'));
salt_cktb = im2double(imread('Fig0508(b)(circuit-board-salt-prob-pt1).tif'));


% denosing with arithmetic mean filter, for figure 5.7
arith_mask = ones(mask_size)/mask_size^2;
arith_denoised_cktb = conv2(gauss_cktb,arith_mask,'same');

% denoising with geomatric mean filter, for figure 5.7
geo_mask = arith_mask;
geo_denoised_cktb = exp(conv2(log(1+gauss_cktb),geo_mask,'same'))-1;
    % constant 1 is used to regularize the image

% design the lehmer mean filter (nonlinear)
lehmer_mean = @(x,p) sum((0.01+x).^p)/sum((0.01+x).^(p-1));
    % constant 0.01 is for regularization
P = 1.5; % a parameter for generating concrete masks.
contra_mask = @(x) lehmer_mean(x,1+P); 
harm_mask = @(x) lehmer_mean(x,1-P);

% denoising with lehmer mean filter for figure 5.8
contra_pepper_cktb = ...
    nlfilter(pepper_cktb,[mask_size,mask_size],contra_mask);
harm_salt_cktb = ...
    nlfilter(salt_cktb,[mask_size,mask_size],harm_mask);

% denoising with lehmer mean filter for figure 5.9
harm_pepper_cktb = ...
    nlfilter(pepper_cktb,[mask_size,mask_size],harm_mask);
contra_salt_cktb = ...
    nlfilter(salt_cktb,[mask_size,mask_size],contra_mask);
    


% calculating the PSNRs
arith_psnr = psnr(arith_denoised_cktb,orig_cktb)
geo_psnr = psnr(geo_denoised_cktb,orig_cktb)
contraharm_psnr = psnr(contra_pepper_cktb,orig_cktb)
harm_psnr = psnr(harm_salt_cktb,orig_cktb)


% plot figure 5.7
figure;
subplot(2,2,1),imshow(orig_cktb),title('Original image');
subplot(2,2,2),imshow(gauss_cktb),title('Gaussion noise');
subplot(2,2,3),imshow(arith_denoised_cktb),title('Arithmetic mean filter');
subplot(2,2,4),imshow(geo_denoised_cktb),title('Geometric mean filter');

% plot figure 5.8
figure;
subplot(2,2,1),imshow(pepper_cktb),title('Pepper noise');
subplot(2,2,2),imshow(salt_cktb),title('Salt noise');
subplot(2,2,3),imshow(contra_pepper_cktb),title('Contraharmonic mean filter');
subplot(2,2,4),imshow(harm_salt_cktb),title('Harmonic mean filter');

% plot figure 5.9
figure;
subplot(2,2,1),imshow(harm_pepper_cktb),
title('Denoising Pepper noise with Harmonic mean filter');

subplot(2,2,2),imshow(contra_salt_cktb),
title('Denoising Salt noise with Contraharmonic mean filter');
