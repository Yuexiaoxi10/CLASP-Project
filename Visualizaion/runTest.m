
% writerObj = VideoWriter('bins_colorEdge.avi');
% writerObj.FrameRate = 10;
% open(writerObj);
load('./datafile/exp5bC11.mat');
% you might need to edit this path depending on where you put your data, this is rotated version
impath = '/Users/yuexizhang/Documents/CLASP/alert-data/04_11_2018/exp5bC11';
imlist = dir(fullfile(impath,'*.jpg'));
 [~,I1] = sort(bin(:,5));
 bin = bin(I1,:);
 Id_bin = zeros(length(bin),1);
 
 [~,I2] = sort(person(:,5));
 person = person(I2,:);
 Id_person = zeros(length(person),1);
 %%
 for i = 1 : length(bin)
    id = bin(i,5);
    Bin(i).bbx = [bin(i,1:2) bin(i,4)-bin(i,2) bin(i,3)-bin(i,1)]; % formatting to : [x,y,w,h]
    Bin(i).imId = id;
    Id_bin(i,1) = bin(i,5);
 end

 for i = 1 : length(person)  
    id = person(i,5);
     Person(i).bbx = [person(i,1:2) person(i,4)-person(i,2) person(i,3)-person(i,1)];
     Person(i).imId = id;
     
    Id_person(i,1) = person(i,5);
end

 
 
for k = 1 : length(imlist)
 name1 = strsplit(imlist(k).name,'Frame');
 name2 = strsplit(name1{1,2},'.jpg');
 ImgIds(k).imId = str2num(name2{1,1});
end
%%
% visulization
for fr = 1000 : 2000%%1 : length(imlist) % bins will come out from the x-ray starting from 1307th frame 
    Img = imread([imlist(fr).folder,'/',imlist(fr).name]);
    ind = find(ImgIds(fr).imId == Id_bin); % finding bins which belongs to the same frame
    ind2 = find(ImgIds(fr).imId == Id_person);
    for idx = 1 : length(ind)
        bx = Bin(ind(idx)).bbx;
%         center_bx = [bx(1,1)+0.5*bx(1,4), bx(1,2)+0.5*bx(1,3)];
%             w_bx = 170;
%             h_bx = 190;
%         center_bx_region = [center_bx(1,1)-0.5*w_bx, center_bx(1,2)-0.5*h_bx, w_bx,h_bx];
        %rectangle('Position',[bx(:,1:2), bx(1,4) bx(1,3)],'EdgeColor','b','LineWidth',3);
        Img = insertShape(Img,'Rectangle',[bx(:,1:2), bx(1,4) bx(1,3)],'Color','blue','LineWidth',6);
        %Img = insertShape(Img,'Rectangle',center_bx_region,'Color','green','LineWidth',2);
        
%         hold on
%         pause(0.05);
        %pause;
    end
    
    for idx = 1 : length(ind2)
        
        bx_per = Person(ind2(idx)).bbx;
        Img = insertShape(Img,'Rectangle',[bx_per(:,1:2),bx_per(1,4),bx_per(1,3)],'Color','red','LineWidth',6);
        
        
        
    end
    %figure(1)
    imshow(Img)
%   frame = getframe(gcf);
%   writeVideo(writerObj, frame);
    hold on
    pause(0.03);
 
end
%  close(writerObj);

 
 
 