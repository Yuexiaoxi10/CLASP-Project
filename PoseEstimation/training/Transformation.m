impath1 ='/Users/yuexizhang/Documents/CLASP/training/frames/09272017_5A/Camera11/';
imlist1 = dir(fullfile(impath1,'*.jpg'));

impath2 = '/Users/yuexizhang/Documents/CLASP/training_orig/09272017_5A/Camera11/';
imlist2 = dir(fullfile(impath2,'*.jpg'));

%%
w = 1920;
h = 1080;
privit = [230,150];%c11
%privit = [660,336];%c9
scale = 0.5;
angle = pi/2;
%angle = (102/180)*pi;
for k = 1 : length(label_5A_C11)
    label_5A_C11_new(k).path = label_5A_C11(k).path;

%for i = 145
    %img1 = imread([imlist1(i).folder,'/',imlist1(i).name]);
    
    Anno = label_5A_C11(k).person;
    
    for kk = 1 : length(Anno)
        personJoints = Anno{1,kk}.personJoints;
        joint = zeros(1,length(personJoints));
        for i = 1 : 7%length(personJoints)
            ind = (length(personJoints)/7)*i;
            point1 = personJoints(1,ind-2:ind-1);
            point2 = transformedPoint(privit,point1,scale,angle,origImg);
            joint(1,ind-2:ind) = [point2',personJoints(1,ind)];
        end
        %personJoints_new = Anno_new{1,kk}.personJoints;
        label_5A_C11_new(k).person{1,kk}.personJoints = joint;
        
    end
    
    
    
    
    
%end


% original image

%     origImg = imread([imlist2(i).folder,'/',imlist2(i).name]);
    %point2 = [1237,752];
   
%     imshow(origImg),hold on
%     plot(point2(1,1),point2(2,1),'r*');
    
    
    
    
end












