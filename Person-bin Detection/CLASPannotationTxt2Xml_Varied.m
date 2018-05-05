function CLASPannotationTxt2Xml_Varied(txtDir,saveDir,ctrl_s,img_size)
%     if ~exist(removeImgDir)
%         mkdir(removeImgDir);
%     end
    cd(txtDir);
    txtList = dir('*.txt');
    p.StructItem = false;
    p.CellItem = false;
    for i = 1:size(txtList,1)
        txtName = txtList(i).name;
        fileID = fopen(txtName,'r');
        txt = textscan(fileID,'%s %d %d %d %d %d','headerlines', 0);
        strs = strsplit(txtList(i).name,'.');
        img_name_one = strcat(ctrl_s,'_',strs{1},'.jpg');
        objNum = size(txt{1},1);
%         if objNum == 0
%             cd(imgDir);
%             movefile(img_name_one, removeImgDir);  
%             cd(txtDir);
%             fclose(fileID);
%             continue;
%         end
        
        img_name(i).filename = img_name_one;
        img_name(i).folder = 'CLASP';

        for j = 1:objNum
            xmin = max(double(txt{2}(j)),1);
            ymin = max(double(txt{3}(j)),1);
            xmax = min(double(txt{2}(j) + txt{4}(j)),img_size(1));
            ymax = min(double(txt{3}(j) + txt{5}(j)),img_size(2));
            img_name(i).object(j).name = txt{1}(j);
            img_name(i).object(j).bndbox = struct(...
        'xmin', xmin, ...
        'ymin', ymin, ...
        'xmax', xmax, ...
        'ymax', ymax);
        end
        char = img_name(i).filename;
        char = strsplit(char, '.');
        annotation = img_name(i);

        xml_write(strcat(saveDir,'/',char{1}, '.xml'), annotation,[],p);
        fclose(fileID);
    end
end