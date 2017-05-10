% Gonzalez (3rd ed) example 4.18, including figure 4.48

orig_image = im2double(imread('Fig0441(a)(characters_test_pattern).tif'));
ORIG_IMAGE = fftshift(fft2(orig_image));

% plot figure 4.48
diameter = [10,30,60,160,460];
radius = round(diameter/2);
ILPF = zeros([size(ORIG_IMAGE),length(diameter)]);
GLPF_result = zeros([size(ORIG_IMAGE),length(diameter)]);

figure 
subplot(ceil(length(diameter)/2),2,1),
imshow(orig_image),
title('Original Image');

for i = 1:length(diameter)
    temp = 1:size(orig_image,1)/2;
    GLPF_1 = exp(-(temp.^2)/(2*radius(i)^2)); % 1-d GLPF 
    GLPF_2 = filter_generate(GLPF_1); % 2-d GLPF
    GLPF_result(:,:,i) = abs(ifft2(GLPF_2.*ORIG_IMAGE));
    subplot(ceil(length(diameter)/2),2,i+1),
    imshow(GLPF_result(:,:,i)),
    title(strcat('GLPF of diameter =',string(diameter(i))));
end



function filter2 = filter_generate(filter1)
    % this function generates a 2-d filter(2n*2n) by rotating the 1-d  
    % filter(1*n) for 360 degrees. The precedure is shown as follows:
    % 1) generate the bottom-right part of filter BR;
    % 2) flip this filter to TL,TR and BL;
    % 3) combine these four parts.
    
    radius = length(filter1);
    
    X = 1:radius;
    Y = X;
    [X,Y] = meshgrid(X,Y);
    K = floor(sqrt(X.^2+Y.^2));
    filter1 = [filter1,zeros(1,floor(0.5*radius))]; % zero padding
    BR = filter1(K);

    BL = fliplr(BR);
    TR = flipud(BR);
    TL = fliplr(TR);
    
    filter2 = [TL,TR;BL,BR];
end