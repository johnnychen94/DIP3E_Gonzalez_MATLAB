% Gonzalez (3rd ed) example 4.16, including figure 4.41 and 4.42

orig_image = im2double(imread('Fig0441(a)(characters_test_pattern).tif'));

% plot figure 4.41
ORIG_IMAGE = fftshift(fft2(orig_image));
spectrum = abs(ORIG_IMAGE);
figure
subplot(1,2,1),imshow(orig_image,[]);
subplot(1,2,2),imshow(log(1+spectrum),[]);


% plot figure 4.42
diameter = [10,30,60,160,460];
radius = round(diameter/2);
ILPF = zeros([size(ORIG_IMAGE),length(diameter)]);
ILPF_result = zeros([size(ORIG_IMAGE),length(diameter)]);

figure 
subplot(ceil(length(diameter)/2),2,1),
imshow(orig_image),
title('Original Image');

for i = 1:length(diameter)
    ILPF_1 = ones(1,radius(i)); % 1-d ILPF 
    ker = filter_generate(ILPF_1); % 2-d ILPF
    ILPF(:,:,i) = padarray(ker,round(size(ORIG_IMAGE)/2)-radius(i)); % padding
    ILPF_result(:,:,i) = abs(ifft2(ILPF(:,:,i).*ORIG_IMAGE));
    subplot(ceil(length(diameter)/2),2,i+1),
    imshow(ILPF_result(:,:,i)),
    title(strcat('ILPF of diameter =',string(diameter(i))));
end



function filter2 = filter_generate(filter1)
    % this function generates a 2-d filter(2n*2n) by rotating the 1-d  
    % filter(1*n) for 360 degrees. The precedure is shown as follows:
    % 1) generate the bottom-right part of filter BR;
    % 2) flip this filter to TL,TR and BL;
    % 3) combine these four parts.
    
    % two implementations are given:
    %  i) one based on matrix operation
    %  ii)  one based on for-for loop
    % Indeed, both perform similarly.
    
    radius = length(filter1);
    
    % method 1
    X = 1:radius;
    Y = X;
    [X,Y] = meshgrid(X,Y);
    K = floor(sqrt(X.^2+Y.^2));
    filter1 = [filter1,zeros(1,floor(0.5*radius))]; % zero padding
    BR = filter1(K);
    
    % method 2
%     BR = zeros(radius);
%     for i=1:radius
%         for j=1:radius
%             k = floor(sqrt(i^2+j^2));
%             if(k<=radius)
%                 BR(i,j) = filter1(k);
%             end
%         end
%     end
    
    BL = fliplr(BR);
    TR = flipud(BR);
    TL = fliplr(TR);
    
    filter2 = [TL,TR;BL,BR];
end