clc
clear 
%% Visualization for the GT from CLASP
% parsing
[gt_loc, gt_xfr] = parseCLASP('master-sikka-exp5a-logfile.txt');
cam_visual = 11; % camera to show

frame_path = fullfile('frames',num2str(cam_visual)); % path of the frames

camID = [gt_loc.camera]';
frame = [gt_loc.frame]';
idx_show = find(camID==cam_visual);
frame_show = unique(frame);
for f = 1:numel(frame_show)
    frame_tmp = frame_show(f);
    im = imread(fullfile(frame_path,sprintf('Frame%04d.jpg',frame_tmp)));    
    idx_show = find(camID==cam_visual & frame==frame_tmp);
    if isempty(idx_show)
        continue;
    end
    imshow(im), hold on
    text(1,20,sprintf('Frame:%04d',frame_tmp));
    for i = 1:numel(idx_show)
        gt_tmp = gt_loc(idx_show(i));
        figure(1);
        
        rectangle('Position',[gt_tmp.bbox(1:2)',gt_tmp.bbox(3:4)'-gt_tmp.bbox(1:2)'],...
                    'EdgeColor','red','LineWidth',2);
        text(gt_tmp.bbox(1),gt_tmp.bbox(2),sprintf('%s---ID:%d, paxID:%d, FU: %d\n%s',...
            gt_tmp.type,gt_tmp.id, gt_tmp.paxID, gt_tmp.firstUsed, gt_tmp.desc),...
            'Color','green','FontSize',12);        
    end
    drawnow
    pause()        
    hold off
end
    
    