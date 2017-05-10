% Gonzalez (3rd ed) example 5.8, including figure 5.19

% Image read
src_image = im2double(imread('Fig0519(a)(florida_satellite_original).tif'));
[m,n] =size(src_image);

% Add noise
A = 0.1;u0=134.4;v0=0;
noised_image = src_image + sin_noise(A,u0,v0,m,n);
NOISED_IMAGE = fftshift(fft2(noised_image));

% Make notch filter, the parameters are get by observing the spectrum image
notch_filter = ones(m,n);
r = 1;
notch_filter(:,-r+n/2:r+n/2) = 0;
notch_filter(-r+m/2:r+m/2,-r+n/2:r+n/2) = 1;

% Denoise
dest_image = abs(ifft2(notch_filter.*NOISED_IMAGE));

% Plot
figure,
subplot(2,2,1),imshow(noised_image,[]),title('noised image');
subplot(2,2,2),imshow(dest_image,[]),title('denoised image');
subplot(2,2,3),imshow(log(1+abs(NOISED_IMAGE)),[]),title('spectrum of noised image');
subplot(2,2,4),imshow(notch_filter,[]),title('notch filter');


function noise = sin_noise(A,u0,v0,m,n)
  noise = zeros(m,n);
  for i = 1:m
  for j= 1:n
    noise(i,j) = A*sin(2*pi*(u0*i+v0*j));
  end
  end
end








