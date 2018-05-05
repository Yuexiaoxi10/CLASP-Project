 %load('CLASP_A9C11.mat');
 clear all
 load('./datafile/exp5a_c11_noRotate_20000.mat');% bins/person
 load('./datafile/Result_exp5a_C11_noRotate.mat');% joint
% bin=person, person=bin 
%impath = '/Users/zhangyuexi/Documents/LabLife/Reaserch/PhD/CLASP7910/frames';
%impath = '/Users/zhangyuexi/Documents/LabLife/Reaserch/PhD/CLASP7910/07212017_EXPERIMENT_10A_Aug21/Camera11/frames';
%impath = '/Users/yuexizhang/Documents/CLASP/04112018/exp5a_c11_noRotate/';
impath = '/Users/yuexizhang/Documents/CLASP/alert-data/04_11_2018/exp5aC9';
imlist = dir(fullfile(impath,'*.jpg'));
 [~,I1] = sort(bin(:,5));
 bin = bin(I1,:);
 Id_bin = zeros(length(bin),1);
 
 [~,I2] = sort(person(:,5));
 person = person(I2,:);
 Id_person = zeros(length(person),1);
 
Result1 = Result;
%%

for i = 1 : length(person)
    %id = num2str(bin(i,5),'%04d');
    id = person(i,5);
    
    %Bin(i).bbx = [bin(i,1:2) bin(i,3)-bin(i,1) bin(i,4)-bin(i,2)];
     Person(i).bbx = [person(i,1:2) person(i,4)-person(i,2) person(i,3)-person(i,1)];
     Person(i).imId = id;
     
    Id_person(i,1) = person(i,5);
end

for i = 1 : length(bin)
    %id = num2str(bin(i,5),'%04d');
    id = bin(i,5);
    
    %Bin(i).bbx = [bin(i,1:2) bin(i,3)-bin(i,1) bin(i,4)-bin(i,2)];
    Bin(i).bbx = [bin(i,1:2) bin(i,4)-bin(i,2) bin(i,3)-bin(i,1)];
    Bin(i).imId = id;
    Bin(i).act = 0;
    Bin(i).change = 0;
    Id_bin(i,1) = bin(i,5);
end




%%
clear Result
for i = 1 : length(Result1)-1000
    k = i + 1000;
    name1 = strsplit(Result1(k).imPath,'Frame');
    name2 = strsplit(name1{1,2},'.jpg');
    Result(i).imId = str2num(name2{1,1});
    Result(i).candi = Result1(k).candi;
    Result(i).sub = Result1(k).sub;
    Result(i).imPath =[imlist(k).folder,'/',imlist(k).name];
  
end

%%

for fr = 1000 : length(Result)
    Img = imread(Result(fr).imPath);
    ind = find(Result(fr).imId == Id_bin);
    figure(1)
    imshow(Img)
    for idx = 1 : length(ind)
        bx = Bin(ind(idx)).bbx;
        rectangle('Position',[bx(:,1:2), bx(1,4) bx(1,3)],'EdgeColor','b','LineWidth',3);
        hold on
        pause(0.05);
        %pause;
    end
  
end
