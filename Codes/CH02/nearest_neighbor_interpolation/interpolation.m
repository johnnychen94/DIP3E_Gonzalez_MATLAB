% % % Image Interpolation in Section 2.4.4, including:
% % %       Nearest neighbor interpolation,
% % %       Bilinear interpolation,
% % %       Bicubic interpolation.
% % %
% % % Nearest neighbor interpolation assign the value of the 'nearest' pixel to new pixels.
% % % It is simple but might produce undesirable artifacts, such as severe distortion of straight edges.
% % % 
% % % Bilinear interpolation
% % %
% % %
% % % Bicubic interpolation




% % read image, size of 3692*2812, dpi of 1250.
filename = 'original_image.tif';
original_data = imread(filename);
[Xsize,Ysize] = size(original_data);

% % reduce image to 72dpi and 150dpi
% % using built-in imresize()
dpi_72_original_data = imresize(original_data,72/1250);
dpi_150_original_data = imresize(original_data,150/1250);

% % apply nearest neighbor interpolation to 72dpi and 150dpi
dpi_72_NNI_data = zeros([Xsize,Ysize]);
dpi_150_NNI_data = zeros([Xsize,Ysize]);



% % Nearest neighbor interpolation
% FIXME: check if this nested loop can be replaced for better performance
% TODO: This loop doesn't work as expected!
for i = 1:Xsize
    for j = 1:Ysize
        
        %[h,k] = nearest_element([i,j],size(dpi_72_original_data),size(dpi_72_NNI_data)); % using eculid distance to get the literally nearest pixel.
        h = round(i*72/1250);
        k = round(j*72/1250);
        
        % deal with border situations
        if h==0 
            h=h+1;
        end
        if k==0
            k=k+1;
        end     
        if h>Xsize
            h = h-1;
        end
        if k>Ysize
            k = k-1;
        end
        % assign values
        dpi_72_NNI_data(i,j) = ...
            dpi_72_original_data(h,k);
    end
end



% % Bilinear interpolation

for i = 1:Xsize
    for j = 1:Ysize
        % TODO: 
    end
end





% % show image
% subplot(2,4,1),imshow(dpi_72_original_data,'DisplayRange',[0,255]);
% subplot(2,4,2),imshow(dpi_72_NNI_data,'DisplayRange',[0,255]);
% subplot(2,4,5),imshow(dpi_150_NNI_data,'DisplayRange',[0,255]);






