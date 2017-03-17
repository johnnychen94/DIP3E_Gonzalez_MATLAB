% Gonzalez(3rd ed) Example 5.1

% image read
original = imread('pattern_original.tif');
gaussian = imread('pattern_gaussian.tif');
rayleigh = imread('pattern_rayleigh.tif');
gamma = imread('pattern_gamma.tif');
exp = imread('pattern_neg_exp.tif');
uniform = imread('pattern_uniform.tif');
salt_pepper = imread('pattern_salt_pepper.tif');

% image plot

figure;
subplot(2,4,1),imshow(original);
subplot(2,4,2),imshow(gaussian);
subplot(2,4,3),imshow(rayleigh);
subplot(2,4,4),imshow(gamma);

subplot(2,4,5),imhist(original),title('Original');
subplot(2,4,6),imhist(gaussian),title('Gaussian');
subplot(2,4,7),imhist(rayleigh),title('Rayleigh');
subplot(2,4,8),imhist(gamma),title('Gamma');


figure;
subplot(2,3,1),imshow(exp);
subplot(2,3,2),imshow(uniform);
subplot(2,3,3),imshow(salt_pepper);

subplot(2,3,4),imhist(exp),title('Exponential');
subplot(2,3,5),imhist(uniform),title('Uniform');
subplot(2,3,6),imhist(salt_pepper),title('Salt & Pepper');
