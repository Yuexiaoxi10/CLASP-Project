imroot = '/home/yuexi/Documents/CLASP/frames/10A_C11/';
actClip = 'actClip1';
impath = [imroot,actClip,'/'];
imlist = dir(fullfile(impath,'*.png'));
%%
mkdir actClip1
for fr = 1 : length(imlist)-1
    img1 = imread([imlist(fr).folder,'/',imlist(fr).name]);
    img2 = imread([imlist(fr+1).folder,'/',imlist(fr+1).name]);
    flow_img = compute_flow(img1, img2);
    imshow(flow_img);
    Image = getframe(gcf);
    filename = sprintf('%05d.jpg',fr);
    imwrite(Image.cdata,['./actClip1/', filename],'jpg');
    
    
end
%%
%{
for fr =  1 : length(imlist)
    img = imread([imlist(fr).folder,'/',imlist(fr).name]);
    imshow(img);
    Image = getframe(gcf);
    filename = sprintf('%05d.png',fr);
    imwrite(Image.cdata,['./actClip1/', filename],'png');
    
    
end
%}




%%
writerObj = VideoWriter('CLASP_testing_picking');
writerObj.FrameRate = 8;
open(writerObj);
%impath = '/home/yuexi/Documents/caffe-act-detector/data/UCFSports/Frames/062/';
impath = '/home/yuexi/Documents/CLASP/frames/10A_C11/actClip1/';
imlist = dir(fullfile(impath,'*.png'));
detections = alldets(alldets(:,3)==8,:);
id = detections(:,2);

for i = 1 : length(imlist)
    %bx_gt = [gt(i,1:2) gt(i,3)-gt(i,1) gt(i,4)-gt(i,2)];
    ind = find(i==id);
    img = imread([imlist(i).folder,'/',imlist(i).name]);
    imshow(img),hold on
    %rectangle('Position',bx_gt,'EdgeColor','r','LineWidth',3);
    for k = 1 : length(ind)
        idx = ind(k);
        bx_det = [detections(idx,5:6) detections(idx,7)-detections(idx,5),...
                detections(idx,8)-detections(idx,6)];
    
    
     
         rectangle('Position',bx_det,'EdgeColor','g','LineWidth',3),hold on
    end
     
     pause(0.1);
     frame = getframe(gcf);
     writeVideo(writerObj,frame);
    
    
end

 close(writerObj);













