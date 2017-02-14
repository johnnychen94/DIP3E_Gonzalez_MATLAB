function [Xout,Yout] = nearest_pixel(inputpixel,input_size,output_size)
% % % Nearest_element may find out the nearest pixel (Xoutput,Youtput) of the original image, given the pixel (Xinput,Yinput) of destination image, and the sizes of both image.


x = inputpixel(1)*output_size(1)/input_size(1);
y = inputpixel(2)*output_size(2)/input_size(2);

x0 = x-floor(x);
y0 = y-floor(y);
% using block distance to give the nearest pixel
if x0<=0.5
    if y0<=0.5
        outputpixel = [floor(x),floor(y)];
    else
        outputpixel = [floor(x),ceil(y)];
    end
else
    if y0<=0.5
        outputpixel = [ceil(x),floor(y)];
    else
        outputpixel = [ceil(x),ceil(y)];
    end
end

Xout = outputpixel(1);
Yout = outputpixel(2);
end

