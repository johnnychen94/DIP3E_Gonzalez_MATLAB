% % % Image Interpolation in Section 2.4.4, including:
% % %       Nearest neighbor interpolation,
% % %       Bilinear interpolation,
% % %       Bicubic interpolation.
% % %
% % % Nearest neighbor interpolation assign the value of the 'nearest' pixel to new pixels.
% % % It is simple but might produce undesirable artifacts, such as severe distortion of straight edges.
% % % 
% % % Bilinear interpolation (TODO: more description)
% % %
% % %
% % % Bicubic interpolation (TODO: more description)


% % global variables
INPUTFILENAME = 'dpi_72_original.png';
ORIGINAL_DATA = double(imread(INPUTFILENAME))./255;

OUTPUTSIZE = [3692,2812];   % when this script becomes function, these should be input parameters.
INPUTSIZE = size(ORIGINAL_DATA);



% % create output array
dpi_72_NNI_data = zeros(OUTPUTSIZE);



% % Nearest neighbor interpolation
% TODO: check if this nested loop can be replaced for better performance
for i = 1:OUTPUTSIZE(1)
    for j = 1:OUTPUTSIZE(2)
        
        % get the nearest pixel of (i,j) in the input image
        [x0,y0] = nearest_pixel([i,j],OUTPUTSIZE,INPUTSIZE); % noting the output image are corresponding input parameters in nearest_pixel.
    
        % deal with border situation
        % TODO: use logical operation to shorten this if-end-if loop
        if x0==0 
            x0=x0+1;
        end
        if y0==0
            y0=y0+1;
        end     
        if x0>OUTPUTSIZE(1)
            x0 = x0-1;
        end
        if y0>OUTPUTSIZE(2)
            y0 = y0-1;
        end
        
        % assign values
        dpi_72_NNI_data(i,j) = ...
            ORIGINAL_DATA(x0,y0);
    end
end



% % Bilinear interpolation
% TODO: check if this nested loop can be replaced for better performance
%for i = 1:OUTPUTSIZE(1)
%    for j = 1:OUTPUTSIZE(2)
%        % TODO: 
%    end
%end



% % show image
imshow(dpi_72_NNI_data);

% % save image
imwrite(dpi_72_NNI_data,'dpi_72_NNI.png');





