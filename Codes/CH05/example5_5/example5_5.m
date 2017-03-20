% Gonzalez (3rd ed) example 5.5, including figure 5.14

sp_cktb = imread('Fig0514(a)(ckt_saltpep_prob_pt25).tif');

mask_size = 7;
med_filter = @(mask) median(mask(:));
med_cktb = nlfilter(sp_cktb,[mask_size,mask_size],med_filter);

init_mask_size = 3;
max_mask_size = 7;
adap_med_cktb = adap_med_filter(sp_cktb,init_mask_size,max_mask_size);


figure
subplot(1,3,1),imshow(sp_cktb,[]),title('salt&pepper noise');
subplot(1,3,2),imshow(med_cktb,[]),title('median filter');
subplot(1,3,3),imshow(adap_med_cktb,[]),title('adaptive median filter');


function dest_image = adap_med_filter(src_image,init_size,max_size)
    [size_m,size_n] = size(src_image);
    dest_image = src_image;
    src_image = padarray(src_image,[max_size, max_size],'symmetric');
    
    for cur_dest_m = 1:size_m
        for cur_dest_n=1:size_n
            
            cur_src_m = cur_dest_m+max_size;
            cur_src_n = cur_dest_n+max_size;
            cur_size = init_size;
            
            while cur_size <= max_size
            % the while loop finds the appropriate mask_size
                offset = floor(cur_size/2);
                cur_mask = src_image(...
                    cur_src_m-offset:cur_src_m+offset...
                    ,cur_src_n-offset:cur_src_n+offset);
                
                cur_min = min(cur_mask(:));
                cur_max = max(cur_mask(:));
                cur_med = median(cur_mask(:));

                if (cur_min<cur_med) && (cur_med < cur_max)
                    break;
                end
                
                cur_size = cur_size + 2;
            end % end of while loop
                                
            % 'good' pixel remains, while 'bad' pixel is replaced
            % cur_min,cur_max and cur_med keep updated
            if (cur_min<dest_image(cur_dest_m,cur_dest_n)) ...
                    && (dest_image(cur_dest_m,cur_dest_n)<cur_max)
                dest_image(cur_dest_m,cur_dest_n) = ...
                    dest_image(cur_dest_m,cur_dest_n);
            else
                dest_image(cur_dest_m,cur_dest_n) = cur_med; 
            end  
        end
    end % end of for-for loop
end % end of function