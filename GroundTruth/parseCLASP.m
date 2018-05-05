function [gt_loc, gt_xfr] = parseCLASP(file)
 
fid = fopen(file);
if fid < 0
    error('Cannot open the file!')
end

cnt_loc = 1;
cnt_xfr = 1;
tline = fgetl(fid);
while 1
    tline = fgetl(fid);
    if tline == -1
        break;
    end
    if isempty(tline)
        continue;
    end
    switch tline(1:3)
        case 'loc' % object
            strcell = strsplit(tline);
            gt_loc(cnt_loc).type = strcell{3};
            gt_loc(cnt_loc).camera = str2double(strcell(5));
            gt_loc(cnt_loc).frame = str2double(strcell(7));
            gt_loc(cnt_loc).time = str2double(strcell(9));
            gt_loc(cnt_loc).id =  str2double(strcell(16));
            gt_loc(cnt_loc).bbox = str2double(strcell(11:14))';
            switch strcell{18}
                case 'na'
                    gt_loc(cnt_loc).paxID = -1; % na
                otherwise
                    gt_loc(cnt_loc).paxID = str2double(strcell(18));
            end
            switch strcell{20}
                case 'true'
                    gt_loc(cnt_loc).firstUsed = 1;
                case 'false'
                    gt_loc(cnt_loc).firstUsed = 0;
            end            
            loc_desc = strfind(tline,'description:');
            gt_loc(cnt_loc).desc = tline(loc_desc + 14:end-1);
            cnt_loc = cnt_loc + 1;
        case 'xfr' % action
            strcell = strsplit(tline);
            gt_xfr(cnt_xfr).type = strcell{3};
            gt_xfr(cnt_xfr).camera = str2double(strcell(5));
            gt_xfr(cnt_xfr).frame = str2double(strcell(7));
            gt_xfr(cnt_xfr).time = str2double(strcell(9));
            gt_xfr(cnt_xfr).ownerID = str2double(strcell(11));
            gt_xfr(cnt_xfr).dviID = str2double(strcell(13));
            switch strcell{15}
                case 'true'
                    gt_xfr(cnt_xfr).theft = 1;
                case 'false'
                    gt_xfr(cnt_xfr).theft = 0;
            end
            loc_desc = strfind(tline,'description:');
            gt_xfr(cnt_xfr).desc = tline(loc_desc + 14:end-1);
            cnt_xfr = cnt_xfr + 1;
        otherwise
            disp(tline);
            continue
    end
end
fclose(fid);
    
    