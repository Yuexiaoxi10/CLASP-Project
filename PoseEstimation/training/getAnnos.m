function my_data = getAnnos(imroot,label)
my_data(1:length(label)) = struct('image_id',[],'annorect',[],'filepath',[]);
segm{1,1} = [];
for i = 1 : length(my_data)
    name = split(label(i).path,'Frame');
    name1 = name{2,1};
    name2 = split(name1,'.jpg');
    
    my_data(i).image_id = str2num(name2{1,1});
    img = imread([imroot,cell2mat(label(i).path)]);
    for ii = 1 : length(label(i).person)
        my_data(i).annorect(ii).bbox = [label(i).person{1,ii}.personBB.x, label(i).person{1,ii}.personBB.y,...,
                                         label(i).person{1,ii}.personBB.height, label(i).person{1,ii}.personBB.width];
        my_data(i).annorect(ii).segmentation = segm;
        my_data(i).annorect(ii).area = 0;
        my_data(i).annorect(ii).id = 0;
        my_data(i).annorect(ii).iscrowd = 0;
        my_data(i).annorect(ii).keypoints = [label(i).person{1,ii}.personJoints,zeros(1,30)];
        my_data(i).annorect(ii).num_keypoints = 7 - length(find(~(label(i).person{1,ii}.personJoints)))/3;
        my_data(i).annorect(ii).img_width = size(img,2);
        my_data(i).annorect(ii).img_height = size(img,1);
   
    end
    
    
    my_data(i).filepath = label(i).path;
    
    
end

