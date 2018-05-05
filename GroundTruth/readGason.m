function label_set = readGason(gason_path,camera)
set = {'Head','Left Shoulder','Left Elbow','Left Hand','Right Shoulder','Right Elbow','Right Hand'};
gason_raw = fileread(gason_path);
g_string = gason(gason_raw);
label_set = [];
num_ann = 0;
for idx = 1:length(g_string)
    img_path = g_string(idx).filename;
    C = strsplit(img_path,'/');
    %label(num_ann + 1).path = strcat('frames/09272017_9A/',camera,'/',C(end));
    label(num_ann + 1).path = strcat('07212017_EXPERIMENT_9A/',camera,'/','frames','/',C(end));
    label(num_ann + 1).person = {};
    ann = g_string(idx).annotations;
    num_person = 0;
    for i = 1:length(ann)
        if strcmp(ann{i}.class,'Person')
            num_person = num_person + 1;
            label(num_ann + 1).person{num_person}.personBB=ann{i};
            label(num_ann + 1).person{num_person}.personJoints = zeros(1,length(set)*3);
        end
    end
    
    
    if num_person == 0
        continue;
    end
    tobeDiscarded = 0;
    for i = 1:length(ann)
        if sum(strcmp(set,ann{i}.class))
            flag_belong = 0;
            for k = 1:num_person
                if Gason_ifBelongPerson(ann{i},label(num_ann + 1).person{k}.personBB)
                    if flag_belong == 0
                        flag_belong = 1;
                        place = find(strcmp(set,ann{i}.class)==1);
                        label(num_ann + 1).person{k}.personJoints(1,[3*place - 2,3 * place - 1, 3* place]) = ...
                            [ann{i}.x,ann{i}.y,2];
                    else
                        tobeDiscarded = 1;
                        break;
                    end
                else
                end
            end
            if tobeDiscarded == 1
                break;
            end
        end
    end
    if tobeDiscarded == 1
        label = label(1:num_ann);
    else
        num_ann = num_ann + 1;
    end
end

label_set = label;
end

