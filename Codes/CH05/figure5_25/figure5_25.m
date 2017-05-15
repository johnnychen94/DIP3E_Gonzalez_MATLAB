% Gonzalez (3rd ed) figure 5.25

src_img = im2double(imread('Fig0525(a)(aerial_view_no_turb).tif'));
SRC_IMG = fftshift(fft2(src_img));

S_H = filter_generator(0.0025,size(src_img));
S_DEST_IMG = SRC_IMG.* S_H;
s_dest_img = abs(ifft2(S_DEST_IMG));

M_H = filter_generator(0.001,size(src_img));
M_DEST_IMG = SRC_IMG.* M_H;
m_dest_img = abs(ifft2(M_DEST_IMG));

L_H = filter_generator(0.00025,size(src_img));
L_DEST_IMG = SRC_IMG.* L_H;
l_dest_img = abs(ifft2(L_DEST_IMG));

figure,
subplot(2,2,1),imshow(src_img,[]),title('Original image');
subplot(2,2,2),imshow(s_dest_img,[]),title('Severe turbulence');
subplot(2,2,3),imshow(m_dest_img,[]),title('Mile turbulence');
subplot(2,2,4),imshow(l_dest_img,[]),title('Low turbulence');

%deblur = abs(ifft2(S_DEST_IMG./S_H));
%figure,imshow(deblur,[]);

function out_filter = filter_generator(k,sz)
  
  out_filter = zeros(sz);
  for i = 1:sz(1)
    for j = 1:sz(2)
      m = i - (sz(1)+1)/2;
      n = j - (sz(2)+1)/2;
      out_filter(i,j) = exp(-k*(m^2+n^2)^(5/6));
    end
  end
end
