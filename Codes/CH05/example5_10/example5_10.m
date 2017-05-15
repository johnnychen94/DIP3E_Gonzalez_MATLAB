% Gonzalez (3rd ed) example 5.10, including figure 5.26
%   illustrating the blurring of image by uniform linear motion.

% The result of blurring in this example seems to be worse than the result
%   shown in the textbook.

src_img = im2double(imread('Fig0526(a)(original_DIP).tif'));
SRC_IMG = (fft2(src_img));

T = 100; % duration of exposure
steps = [0.1,0.1];
H = filter_generator(size(src_img),T,steps);

DEST_IMG = H.*SRC_IMG;
dest_img = abs(ifft2(DEST_IMG));

figure,imshow(src_img,[]);
figure,imshow(dest_img,[]);


function dest_img = filter_generator(sz,T,steps)
  
  dest_img = zeros(sz);
  for m = 1:sz(1)
    for n = 1:sz(2)
      temp = -2i*pi*(steps(1)*m+steps(2)*n);
      if temp == 0
        dest_img(m,n) = T;
      else
        dest_img(m,n) = T*(exp(temp)-1)/temp;
      end
    end
  end

end