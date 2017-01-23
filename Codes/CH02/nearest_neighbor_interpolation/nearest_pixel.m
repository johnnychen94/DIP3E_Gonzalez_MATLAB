function [Xoutput,Youtput] = nearest_pixel(inputpixel,ori_size,des_size)
% % % Nearest_element may find out the nearest pixel (Xoutput,Youtput) of the original image, given the pixel (Xinput,Yinput) of destination image, and the sizes of both image.
% % % This function mainly used for assign values of original image to destination image, i.e., g(Xinput,Yinput)=f(Xoutput,Youtput)
% % % This function works by comparing the eculid distances.

%%% FIXME:THIS FUNCTION WORKS EXTREMELY SLOWLY NOW!!!

x = inputpixel(1)*ori_size(1)/des_size(1);
y = inputpixel(2)*ori_size(2)/des_size(2);
% get the positions of the neighbor pixels.
TL = [floor(x),floor(y)];
TR = [floor(x),ceil(y)];
BL = [ceil(x),floor(y)];
BR = [ceil(x),ceil(y)];
pixels = [TL;TR;BL;BR];

% calulate the squre of eculid distance.
distance = zeros(1,4);
for i = 1:4
    distance(i) = sum((pixels(i,:)-inputpixel).*(pixels(i,:)-inputpixel));
end

[~,minindex] = min(distance);
Xoutput = pixels(minindex,1);
Youtput = pixels(minindex,2);

end

