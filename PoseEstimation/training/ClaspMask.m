addpath('../dataset/COCO/coco/MatlabAPI/');
addpath('../../testing/util');
%imroot = '/Users/yuexizhang/Documents/CLASP/training/frames/';
imroot = '/Users/yuexizhang/Documents/CLASP/training/';
mkdir('/Users/yuexizhang/Documents/CLASP/training/frames/12_A04/mask_c11');
%load('./datafile/CLASP_data.mat');
%my_data = CLASP_data(2).data;
my_data = my_data4;
vis = 0;
%%
for mode = 1 %0:1
   
     %if mode == 1 
        %load('my_data.mat');
        
%     else
%         load('dataset/COCO/mat/coco_val.mat');
%         my_data = coco_val;
%     end
    
    L = length(my_data);
    
    %%
    
    for i = 1:L
        if mode == 1
            img_paths = fullfile([imroot,cell2mat(my_data(i).filepath)]);
            %if i <= 97
                %img_name1 = sprintf([imroot,'frames/09272017_5A/mask_c11/mask_all_09_5AC9_Frame%04d.png'], my_data(i).image_id);
                %img_name2 = sprintf([imroot,'frames/09272017_5A/mask_c11/mask_miss_09_5AC9_Frame%04d.png'], my_data(i).image_id);
       
            %else
                %img_name1 = sprintf([imroot,'frames/09272017_5A/mask_c11/mask_all_09_5AC11_Frame%04d.png'], my_data(i).image_id);
                %img_name2 = sprintf([imroot,'frames/09272017_5A/mask_c11/mask_miss_09_5AC11_Frame%04d.png'], my_data(i).image_id);
%                 img_name1 = sprintf([imroot,'07212017_EXPERIMENT_9A/mask_c11/mask_all_09_9AC11_Frame%04d.png'], my_data(i).image_id);
%                 img_name2 = sprintf([imroot,'07212017_EXPERIMENT_9A/mask_c11/mask_miss_09_9AC11_Frame%04d.png'], my_data(i).image_id);
                 img_name1 = sprintf([imroot,'frames/12_A04/mask_c11/mask_all_ex4_C11_Frame%04d.png'], my_data(i).image_id);
                 img_name2 = sprintf([imroot,'frames/12_A04/mask_c11/mask_miss_ex4_C11_Frame%04d.png'], my_data(i).image_id);
                 
            
            %end
        end
        
        try
            display([num2str(i) '/ ' num2str(L)]);
            imread(img_name1);
            imread(img_name2);
            continue;
        catch
            display([num2str(i) '/ ' num2str(L)]);
            %joint_all(count).img_paths = RELEASE(i).image_id;
            [h,w,~] = size(imread (img_paths));
            mask_all = false(h,w);
            mask_miss = false(h,w);
            flag = 0;
            for p = 1:length(my_data(i).annorect)
                %if this person is annotated
                try
                    seg = my_data(i).annorect(p).segmentation{1};
                catch
                    %display([num2str(i) ' ' num2str(p)]);
                    mask_crowd = logical(MaskApi.decode( my_data(i).annorect(p).segmentation ));
                    temp = and(mask_all, mask_crowd);
                    mask_crowd = mask_crowd - temp;
                    flag = flag + 1;
                    my_data(i).mask_crowd = mask_crowd;
                    continue;
                end
                
                [X,Y] = meshgrid( 1:w, 1:h );
                mask = inpolygon( X, Y, seg(1:2:end), seg(2:2:end));
                mask_all = or(mask, mask_all);
                
                if my_data(i).annorect(p).num_keypoints <= 0
                    mask_miss = or(mask, mask_miss);
                end
            end
            if flag == 1
                mask_miss = not(or(mask_miss,mask_crowd));
                mask_all = or(mask_all, mask_crowd);
            else
                mask_miss = not(mask_miss);
            end
            
            my_data(i).mask_all = mask_all;
            my_data(i).mask_miss = mask_miss;
            
            if mode == 1
                %{
                if i <= 97
                    img_name = sprintf([imroot,'frames/09272017_5A/mask_c11/mask_all_09_5AC9_Frame%04d.png'], my_data(i).image_id);
                    imwrite(mask_all,img_name);
                    img_name = sprintf([imroot,'frames/09272017_5A/mask_c11/mask_miss_09_5AC9_Frame%04d.png'], my_data(i).image_id);
                    imwrite(mask_miss,img_name);
               
                else
                
                    img_name = sprintf([imroot,'frames/09272017_5A/mask_c11/mask_all_09_5AC11_Frame%04d.png'], my_data(i).image_id);
                    imwrite(mask_all,img_name);
                    img_name = sprintf([imroot,'frames/09272017_5A/mask_c11/mask_miss_09_5AC11_Frame%04d.png'], my_data(i).image_id);
                    imwrite(mask_miss,img_name);
                %end
                
                    img_name = sprintf([imroot,'07212017_EXPERIMENT_9A/mask_c11/mask_all_09_9AC11_Frame%04d.png'], my_data(i).image_id);
                    imwrite(mask_all,img_name);
                    img_name = sprintf([imroot,'07212017_EXPERIMENT_9A/mask_c11/mask_miss_09_9AC11_Frame%04d.png'], my_data(i).image_id);
                    imwrite(mask_miss,img_name);
                %}
                img_name = sprintf([imroot,'/frames/12_A04/mask_c11/mask_all_ex4_C11_Frame%04d.png'], my_data(i).image_id);
                imwrite(mask_all,img_name);
                img_name = sprintf([imroot,'/frames/12_A04/mask_c11/mask_miss_ex4_C11_Frame%04d.png'], my_data(i).image_id);
                imwrite(mask_miss,img_name);
                
            end
            
            if flag == 1 && vis == 1
                im = imread(img_paths);
                mapIm = mat2im(mask_all, jet(100), [0 1]);
                mapIm = mapIm*0.5 + (single(im)/255)*0.5;
                figure(1),imshow(mapIm);
                mapIm = mat2im(mask_miss, jet(100), [0 1]);
                mapIm = mapIm*0.5 + (single(im)/255)*0.5;
                figure(2),imshow(mapIm);
                mapIm = mat2im(mask_crowd, jet(100), [0 1]);
                mapIm = mapIm*0.5 + (single(im)/255)*0.5;
                figure(3),imshow(mapIm);
                pause;
                close all;
            elseif flag > 1
                display([num2str(i) ' ' num2str(p)]);
            end
        end
    end
    
    if mode == 1 
        %save('my_data_mask.mat', 'my_data', '-v7.3');
        %{
    else
        coco_val = my_data;
        save('coco_val_mask.mat', 'coco_val', '-v7.3');
        %}
    end
    
end
