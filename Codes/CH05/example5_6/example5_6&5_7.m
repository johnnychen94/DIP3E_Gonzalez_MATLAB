% Gonzalez (3rd ed) example 5.6, including figure 5.16
%                   example 5.7, including figure 5.17

% This example use butterworth bandreject filter to remove the periodic
% noise. 
% Note: Since the noise is combined of noises of different periods, 
% this method does not do as expected on this SPECIFIC image. 
% nevertheless, it is reasonable.

src_image = im2double(imread('Fig0516(a)(applo17_boulder_noisy).tif'));
SRC_IMAGE = fftshift(fft2(src_image));

BBRF = butterworth_bandreject_filter(size(SRC_IMAGE),10,175,2);
%BBRF = im2double(imread('Fig0516(c)(BW_banreject_order4).tif'));

dest_image = abs(ifft2(BBRF.*SRC_IMAGE));

% plot figure 5.16
figure,
subplot(2,2,1),imshow(src_image,[]),title('Original image');
subplot(2,2,2),imshow(log(1+abs(SRC_IMAGE)),[]),title('Fourier spectrum');
subplot(2,2,3),imshow(BBRF,[]),title('butterworth bandreject filter');
subplot(2,2,4),imshow(dest_image,[]),title('result of BBRF');

% plot figure 5.17
figure, imshow(abs(ifft2((1-BBRF).*SRC_IMAGE)),[]),title('Noise pattern');


function BBRF = butterworth_bandreject_filter(mask_size,band_width,distance,order)
% Butterworth Bandreject filter, based on Table 4.6, p316.
    W = band_width;
    D0 = distance;
    n = order;
    center = round((mask_size+1)/2);
    BBRF = zeros(mask_size);
    for i = 1:mask_size(1)
        for j = 1:mask_size(2)
            D = sqrt((i-center(1))^2+(j-center(2))^2);
            BBRF(i,j) = 1/(1+(D*W/(D^2-D0^2))^(2*n));
        end
    end
           
end