% Gonzalez (3rd ed) Example 4.13 including figure 4.24, 4.25 and 4.26
image1 = imread('Fig0424(a)(rectangle).tif');
IMAGE1 = fft2(image1);
spectrum1 = abs(IMAGE1);
centered_spectrum1 = fftshift(spectrum1);
phase1 = atan2(imag(IMAGE1),real(IMAGE1));

image2 = imread('Fig0425(a)(translated_rectangle).tif');
IMAGE2 = fft2(image2);
spectrum2 = abs(IMAGE2);
centered_spectrum2 = fftshift(spectrum2);
phase2 = atan2(imag(IMAGE2),real(IMAGE2));

image3 = imrotate(image1,-45);
IMAGE3 = fft2(image3);
spectrum3 = abs(IMAGE3);
centered_spectrum3 = fftshift(spectrum3);
phase3 = atan2(imag(IMAGE3),real(IMAGE3));


% figure 4.24
figure
subplot(2,2,1),imshow(image1,[]);
subplot(2,2,2),imshow(spectrum1,[]);
subplot(2,2,3),imshow(centered_spectrum1,[]);
subplot(2,2,4),imshow(log(1+centered_spectrum1),[]);

% figure 4.25
figure
subplot(2,2,1),imshow(image2,[]);
subplot(2,2,2),imshow(log(1+centered_spectrum2),[]);
subplot(2,2,3),imshow(image3,[]);
subplot(2,2,4),imshow(log(1+centered_spectrum3),[]);

% figure 4.26
figure
subplot(1,3,1),imshow(phase1,[]);
subplot(1,3,2),imshow(phase2,[]);
subplot(1,3,3),imshow(phase3,[]);
