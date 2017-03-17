% Gonzalez (3rd ed) example 4.14, including figure 4.27

woman = imread('Fig0427(a)(woman).tif');
rect = imread('Fig0424(a)(rectangle).tif');

WOMAN = fft2(woman);
phase_woman = atan2(imag(WOMAN),real(WOMAN));
spec_woman = abs(WOMAN);

RECT = fft2(rect);
phase_rect = atan2(imag(RECT),real(RECT));
spec_rect = abs(RECT);

% reconstruct image only by phase angle, with all spectrum defined as 1
image_phase_only = 1*cos(phase_woman)+1i*sin(phase_woman);
image_phase_only = real(ifft2(image_phase_only));

% reconstruct image only by spectrum, with all phase angle defined as pi/4
% FIXME: This reconstruction is dissimilar to the textbook, the reason for which
% remains to be figured out.
image_spec_only = spec_woman.*(1*cos(pi/4)+1i*sin(pi/4));  
image_spec_only = real(ifft2(image_spec_only));

% reconstruct image by woman's phase angle and rectangle's spectrum.
image_wp_rs = spec_rect.*(1*cos(phase_woman)+1i*sin(phase_woman));
image_wp_rs = real(ifft2(image_wp_rs));

% reconstruct image by rectangle's phase angle and woman's spectrum.
image_ws_rp = spec_woman.*(1*cos(phase_rect)+1i*sin(phase_rect));
image_ws_rp = real(ifft2(image_ws_rp));


% plot figure 4.27
figure;
subplot(2,3,1),imshow(woman,[]);
subplot(2,3,2),imshow(phase_woman,[]);
subplot(2,3,3),imshow(image_phase_only,[]);
subplot(2,3,4),imshow(image_spec_only,[]);
subplot(2,3,5),imshow(image_wp_rs,[]);
subplot(2,3,6),imshow(image_ws_rp,[]);
