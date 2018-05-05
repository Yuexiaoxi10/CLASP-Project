clear all
dbstop if error
%% setup
addpath('src'); 
addpath('util');
addpath('util/ojwoodford-export_fig-5735e6d/');
% load('/home/yuexi/Documents/CLASP/labels/joints_C11_2145to3795.mat');
imRoot = '/home/yuexi/Documents/CLASP/';
frameDir = '/04112018/exp5a/exp5bC11/';
imPath = [imRoot,frameDir,'/'];
imlist = dir(fullfile(imPath,'*.jpg'));

mode = 1;
param = config(mode);
model = param.model(param.modelID);
%%
net = caffe.Net(model.deployFile, model.caffemodel, 'test');

clear Result
for i = 1 : length(imlist) %length(label_set)
    
    fprintf('Image:%d/%d \n', i, length(imlist));
    %Img = imread([imRoot,cell2mat(label_set(i).path)]);
    Img = imread([imlist(i).folder,'/',imlist(i).name]);
    scale0 = 368/size(Img, 1);
    twoLevel = 1;
    tic;
    [final_score, ~] = applyModel(Img, param, net, scale0, 1, 1, 0, twoLevel);
    toc;
    vis = 0;
    [candidates, subset] = connect56LineVec(Img, final_score, param, vis);
    Result(i).imPath = fullfile(imlist(i).folder,'/',imlist(i).name);
    Result(i).candi = candidates;
    Result(i).sub = subset;
    clear final_score;
    %save('./Clasp/Result_09C11','Result_09C11');
   
end

save('Result_exp5b_C11','Result');
caffe.reset_all();

%% visualize
























