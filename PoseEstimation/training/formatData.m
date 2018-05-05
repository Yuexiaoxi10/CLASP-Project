%% get data from two cameras
%combining two sets for Camera11
imroot = '/Users/yuexizhang/Documents/CLASP/training/';

load('./datafile/joints_C11_2145to3795.mat');
label_set1 = label_set;
n1 = length(label_set1);
load('./datafile/joints_C11_4620to6225.mat');
label_set2 = label_set;
n2 = length(label_set2);
%label_C11(1:n1+n2) = struct;
%combine 2 sets of camera11
for i = 1 : n1+n2
    if i <= n1
        label_5A_C11(i).path = label_set1(i).path;
        label_5A_C11(i).person = label_set1(i).person;
    else
        label_5A_C11(i).path = label_set2(i-n1).path;
        label_5A_C11(i).person = label_set2(i-n1).person;
    end
 
end


load('./datafile/joints_C9_1290to2895.mat');
label_5A_C9 = label_set; % experiment 5A 

load('./datafile/GT.mat');
label_9A_C11 = label_set;

load('./datafile/ex4C11_PersonBinJointsActGT.mat');
label_ex4_C11 = label_set;


my_data1 = getAnnos(imroot,label_5A_C9);
my_data2 = getAnnos(imroot,label_5A_C11);
my_data3 = getAnnos([imroot,'/frames/'],label_9A_C11);
my_data4 = getAnnos(imroot,label_ex4_C11);
%%
N = length(my_data1) + length(my_data2) + length(my_data3) + length(my_data4);
CLASP_data(1:N) = struct('image_id',[],'annorect',[],'filepath',[]);
for n = 1 : N
    if n <= length(my_data1)
        CLASP_data(n).image_id = my_data1(n).image_id;
        CLASP_data(n).annorect = my_data1(n).annorect;
        CLASP_data(n).filepath = my_data1(n).filepath;
        
    elseif n>length(my_data1) & n<=(length(my_data2)+length(my_data1))
        CLASP_data(n).image_id = my_data2(n-length(my_data1)).image_id;
        CLASP_data(n).annorect = my_data2(n-length(my_data1)).annorect;
        CLASP_data(n).filepath = my_data2(n-length(my_data1)).filepath;
    elseif n>(length(my_data2)+length(my_data1)) &n<=(length(my_data1)+length(my_data2)+length(my_data3))
        CLASP_data(n).image_id = my_data3(n-(length(my_data1)+length(my_data2))).image_id;
        CLASP_data(n).annorect = my_data3(n-(length(my_data1)+length(my_data2))).annorect;
        CLASP_data(n).filepath = my_data3(n-(length(my_data1)+length(my_data2))).filepath;
    else
        CLASP_data(n).image_id = my_data4(n-(length(my_data1)+length(my_data2)+length(my_data3))).image_id;
        CLASP_data(n).annorect = my_data4(n-(length(my_data1)+length(my_data2)+length(my_data3))).annorect;
        CLASP_data(n).filepath = my_data4(n-(length(my_data1)+length(my_data2)+length(my_data3))).filepath;

    end
    
end

%% generate masks for Clasp data
%ClaspMask.m;



%% generate json file for Clasp data

joint_all = genJSON_clasp('CLASP',CLASP_data);


%% Generate GT .mat
gason_path = '/Users/yuexizhang/Documents/Realtime/Realtime_Multi-Person_Pose_Estimation-master/training/CLASP/Clasp/json/9A_test_seq.json';
camera = 'Camera11';
label_set= readGason(gason_path,camera);
























    