function  readGasonIntoXML(g_string,xml_saveDir)
p.StructItem = false;
p.CellItem = false;

for idx = 1:length(g_string)
    img_path = g_string(idx).filename;
    C = strsplit(img_path,'/');
    img_name = C{end};
    img_ind = strsplit(img_name,'.');
    img_ind = img_ind{1};
    ann = g_string(idx).annotations;
    
    objNum = 0;
    if ~iscell(ann)
        temp = {};
        for i = 1:length(ann)
            temp{i} = ann(i);
        end
        ann = temp;
    end
    if isempty(ann)
        continue;
    end
    for i = 1:length(ann)
        disp([num2str(idx),' ',num2str(i)]);
        c = ann{i}.class;
        if strcmp(c,'Person') || strcmp(c,'BinFULL') || strcmp(c,'BinEMPTY')
            objNum = objNum + 1;
            if strcmp(c,'Person')
                obj(objNum).name = 'person';
            else
                if strcmp(c,'BinFULL')
                    obj(objNum).name = 'bin';
                else
                    if strcmp(c,'BinEMPTY')
                        obj(objNum).name = 'bin';
                    end
                end
            end
            xmin = ann{i}.x;
            ymin = ann{i}.y;
            xmax = ann{i}.x + ann{i}.width;
            ymax = ann{i}.y + ann{i}.height;
            obj(objNum).bndbox = struct(...
                'xmin', max(floor(xmin),1), ...
                'ymin', max(floor(ymin),1), ...
                'xmax', floor(xmax), ...
                'ymax', floor(ymax));
        end
    end
    annotation.filename = img_name;
    annotation.folder = 'CLASP';
    annotation.object = obj;
    xml_write(strcat(xml_saveDir,'/',img_ind, '.xml'), annotation,[],p);
end