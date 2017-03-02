a = magic(2);
scale = 50; 
outsize = [scale*size(a,1) scale*size(a,2)];
r_nearest = imresize(a,50,'nearest');
r_bilinear = imresize(a,50,'bilinear');
r_bicubic = imresize(a,50,'bicubic');
r_chen_nearest = nearest_neighbor_interpolation(a,outsize);
r_chen_bilinear = bilinear_interpolation(a,outsize);
figure,subplot(231);imagesc(r_nearest);title 'matlab nearest'
subplot(232);imagesc(r_bilinear);title 'matlab bilinear'
subplot(233);imagesc(r_bicubic);title 'matlab bicubic'
subplot(234);imagesc(r_chen_nearest);title 'chen nearest'
subplot(235);imagesc(r_chen_bilinear);title 'chen bilinear'