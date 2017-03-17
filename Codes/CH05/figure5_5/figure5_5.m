% Gonzalez (3rd ed) Figure 5.5
image = imread('Fig0505(a).tif');
spectrum = abs(fft2(image));

figure
subplot(1,2,1),imshow(image,[]);
subplot(1,2,2),imshow(fftshift(log(1+spectrum)),[]);