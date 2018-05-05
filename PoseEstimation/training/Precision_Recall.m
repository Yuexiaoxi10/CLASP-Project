load = './datafile/GT.mat';
%gt = label_set;
imroot = '/Users/yuexizhang/Documents/CLASP/alert-data-2/';
gt = getAnnos(imroot,label_set);
%% %% Pick R_wrist & L_wrist
% gt:index = 7 & 4; det: 3 & 18
% load detections to get Result1
for i = 1 : length(Result1)
    name = split(Result1(i).imPath,'Frame');
    name1 = name{2,1};
    name2 = split(name1,'.jpg');
    keypoint_det(i).imgId = str2num(name2{1,1});
    point = Result1(i).candi;
    if ~isempty(point)
        ind1 = find(point(:,4)==3); % Rw
            if ~isempty(ind1)
                jt1 = zeros(length(ind1),2);
                for k = 1 : length(ind1)
                    jt1(k,:) = point(ind1(k),1:2);
 
                end
            else
                jt1 = [];
            end
            ind2 = find(point(:,4)==18);% Lw
            if ~isempty(ind2)
                jt2 = zeros(length(ind2),2);
                for k = 1 : length(ind2)
                    jt2(k,:) = point(ind2(k),1:2);
    
                end
            else
                jt2 = [];

            end
    
        keypoint_det(i).Rw = jt1;
        keypoint_det(i).Lw = jt2;
    
    else
        keypoint_det(i).Rw = [];
        keypoint_det(i).Lw = [];
    end
    
    
end


%keypoint_gt = cell(1,length(gt));
%% Get gt
for i = 1 : length(gt)
    keypoint_gt(i).imId = gt(i).image_id;
    anno = gt(i).annorect;
    %jts = zeros(length(anno),4);
    for ii = 1 : length(anno)
        point = anno(ii).keypoints;
        jt3 = point(1,19:20);
%         if jt3 == 0
%             jt3 = [];
%         end
%         
         jt4 = point(1,10:11);
%         if jt4 == 0
%             jt4 = [];
%         end
        jts(ii,:) = [jt3 jt4]; % r_w l_w
   
    end
    keypoint_gt(i).Rw = jts(:,1:2) ;
    keypoint_gt(i).Lw = jts(:,3:end);
    
 
end
for i = 1 : length(gt)
    
    jt_rw = keypoint_gt(i).Rw;
    [a,~] = find(jt_rw==0);
    jt_rw(a,:) = [];
    keypoint_gt(i).Rw = jt_rw;
        
    jt_lw = keypoint_gt(i).Lw;
    [b,~] = find(jt_lw==0);
    jt_lw(b,:) = [];
    keypoint_gt(i).Lw = jt_lw;
        
    
    
    
end
    
  
%%
cnt_rw_tp = 0;cnt_rw_fp = 0; cnt_rw_fn=0; nCorrect_rw = 0;nTotal_rw = 0;
cnt_lw_tp = 0;cnt_lw_fp = 0; cnt_lw_fn=0; nCorrect_lw = 0;nTotal_lw = 0; 
thresh = 25;
for i = 1 : length(keypoint_gt)
    k = 237+i;%keypoint_gt(i).imgId;
    rw_gt = keypoint_gt(i).Rw;
    lw_gt = keypoint_gt(i).Lw;
    rw_det = keypoint_det(k).Rw;
    lw_det = keypoint_det(k).Lw;
    dist_rw = zeros(size(rw_det,1),size(rw_gt,1));
    dist_lw = zeros(size(lw_det,1),size(lw_gt,1));
    nTotal_rw = nTotal_rw + size(rw_gt,1);
    nTotal_lw = nTotal_lw + size(lw_gt,1);
    
    for n = 1 : size(rw_det,1) % count how many gt rws
        for m = 1: size(rw_gt,1)
            
            dist_rw(n,m) = sqrt((rw_gt(m,1)-rw_det(n,1))^2 + (rw_gt(m,2)-rw_det(n,2))^2);
  
        end
 
    end
    [n,~] = find(dist_rw <= thresh);
     tp_rw = length(n); fn_rw = size(rw_gt,1) - tp_rw; fp_rw = size(rw_det,1) - tp_rw;
     cnt_rw_tp = cnt_rw_tp + tp_rw;
     cnt_rw_fn = cnt_rw_fn + fn_rw;
     cnt_rw_fp = cnt_rw_fp + fp_rw;
     
    % lw   
    for p = 1 : size(lw_det,1) % count how many gt lws
        for q = 1: size(lw_gt,1)
            
            dist_lw(p,q) = sqrt((lw_gt(q,1)-lw_det(p,1))^2 + (lw_gt(q,2)-lw_det(p,2))^2);
  
        end
 
    end
    [p,q] = find(dist_lw <= thresh);
     tp_lw = length(p); fn_lw = size(lw_gt,1) - tp_lw; fp_lw = size(lw_det,1) - tp_lw;
     cnt_lw_tp = cnt_lw_tp + tp_lw;
     cnt_lw_fn = cnt_lw_fn + fn_lw;
     cnt_lw_fp = cnt_lw_fp + fp_lw;
                
     
end
    


Precision_rw = cnt_rw_tp/(cnt_rw_fp+cnt_rw_tp);
Recall_rw = cnt_rw_tp/(cnt_rw_tp+cnt_rw_fn);


Precision_lw = cnt_lw_tp/(cnt_lw_fp+cnt_lw_tp);
Recall_lw = cnt_lw_tp/(cnt_lw_tp+cnt_lw_fn);







