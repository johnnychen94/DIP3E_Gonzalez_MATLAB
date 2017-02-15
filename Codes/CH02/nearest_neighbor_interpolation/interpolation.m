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
%DPI = 72;
DPI = 150;
INPUTFILENAME = strcat('dpi_',int2str(DPI),'_original.png');
ORIGINAL_DATA = double(imread(INPUTFILENAME))./255;% format the gray level to double [0,1]
OUTPUTSIZE = [3692,2812];


% % Nearest neighbor interpolation
 dpi_72_NNI_data = nearest_neighbor_interpolation(ORIGINAL_DATA,OUTPUTSIZE);
 subplot(1,2,1),imshow(dpi_72_NNI_data);
 imwrite(dpi_72_NNI_data,strcat('dpi_',int2str(DPI),'_NNI.png'));


% % Bilinear interpolation
dpi_72_BI_data = bilinear_interpolation(ORIGINAL_DATA,OUTPUTSIZE);
subplot(1,2,2),imshow(dpi_72_BI_data);
imwrite(dpi_72_BI_data,strcat('dpi_',int2str(DPI),'_BI.png'));








