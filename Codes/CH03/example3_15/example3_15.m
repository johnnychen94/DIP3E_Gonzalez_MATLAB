% Gonzalez (3rd ed) example 3.15, including figure 3.38
src_image = im2double(imread('moon.jpg'));
dest_image = src_image - laplace_filter(src_image);
dest_image = intensitytransform(dest_image,1);


figure,
subplot(1,2,1),imshow(src_image,[]);
subplot(1,2,2),imshow(dest_image,[]);
figure,
imshow(dest_image-src_image);

function dest_image = laplace_filter(src_image)
  laplace = [1,1,1;1,-8,1;1,1,1];
  [size_m,size_n] = size(src_image);
  dest_image = src_image;
  src_image = padarray(src_image,[1,1],'symmetric');
  for dest_m = 1:size_m
  for dest_n = 1:size_n
    % shifting
    src_m = dest_m+1;
    src_n = dest_n+1;

    window = src_image(src_m-1:src_m+1,...
      src_n-1:src_n+1);
    
    dest_image(dest_m,dest_n) = sum(laplace(:).*window(:));
  end
  end
end

function dest_image = intensitytransform(src_image,n)
  dest_image = 1-1./(1+(src_image./0.5).^(2*n));
  fmax = 4^n/(1+4^n);
  dest_image = dest_image/fmax;
end