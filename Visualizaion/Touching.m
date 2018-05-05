
close all
% run visual_clasp, visual
%  writerObj = VideoWriter('10AC11_touching_act_sample.avi');
%  writerObj.FrameRate = 8;
%  open(writerObj);
for ind = 500 : 1000 %1 : 1150
    ind
    candidates = Result(ind).candi;
    Img = imread(Result(ind).imPath);
    Indx = find(Result(ind).imId == Id_bin);
    
    
    %bxx1 = [bx(1,1)+bx(1,3),bx(1,2);bx(1,1)+bx(1,3), bx(1,2)+bx(1,4)];%[up,low]
    %bxx2 = [bx(1,1), bx(1,2);bx(1,1), bx(1,2)+bx(1,4)];
    idx = candidates(:,4);
%%
    if ~isempty(Indx)
        for numBx = 1 : length(Indx)
        
            bx = Bin(Indx(numBx)).bbx; % box 
            Img = insertShape(Img,'Rectangle',[bx(:,1:2), bx(1,4) bx(1,3)],'Color','blue','LineWidth',3);
            center_bx = [bx(1,1)+0.5*bx(1,4), bx(1,2)+0.5*bx(1,3)];
            w_bx = 170;
            h_bx = 190;
            center_bx_region = [center_bx(1,1)-0.5*w_bx, center_bx(1,2)-0.5*h_bx, w_bx,h_bx];
        %Img = insertShape(Img,'Rectangle',center_bx_region,'Color','green','LineWidth',2);
            rightHand = candidates(find(idx==3),1:2);
            leftHand = candidates(find(idx==18),1:2);
            if ~isempty(rightHand)% make sure there are hand detection
                for jt = 1 : size(rightHand,1)
  
                    center = rightHand(jt,:);
                    w = 80;
                    h = 90;
                    handAeara = [center(1,1)-0.5*w, center(1,2)-0.5*h, w,h];
                    %center_bx_region = [center_bx(1,1)-0.5*80, center_bx(1,2)-0.5*80, 80,80];
                    overlapRatio = bboxOverlapRatio(bx,handAeara);
                    overlapRatio_act  = bboxOverlapRatio(center_bx_region,handAeara);
                    if overlapRatio > 0.01
                        %imshow(Img)
                        %Img1 = insertShape(Img,'Rectangle',bx,'Color','blue','LineWidth',3);
                        Bin(Indx(numBx)).act = 1;
                        Img = insertShape(Img,'FilledRectangle',handAeara,'Color','yellow');
                        if overlapRatio_act > 0.05
                            Img = insertShape(Img,'FilledRectangle',[bx(:,1:2),450,400],'Color','red','LineWidth',3);
                        end
                        %imshow(OverlapImg);
                    end
                
                end
         
            end
        
            if ~isempty(leftHand)
                for jt = 1 : size(leftHand,1)
  
                    center = leftHand(jt,:);
                    w = 60;
                    h = 60;
                    handAeara = [center(1,1)-0.5*w, center(1,2)-0.5*h, w,h];
                    overlapRatio = bboxOverlapRatio(bx,handAeara);
                    overlapRatio_act  = bboxOverlapRatio(center_bx_region,handAeara);
                    if overlapRatio > 0.01
                        Bin(Indx(numBx)).act = 1;
                        %imshow(Img)
                        %Img1 = insertShape(Img,'Rectangle',bx,'Color','blue','LineWidth',3);
                        Img = insertShape(Img,'FilledRectangle',handAeara,'Color','yellow');
                        if overlapRatio_act > 0.05
                            Img = insertShape(Img,'FilledRectangle',[bx(:,1:2),450,400],'Color','red','LineWidth',3);
                        end
                        %imshow(OverlapImg);
                    end
                
                end
        
        
        
            end
     imshow(Img)
     %rectangle('Position',bx,'EdgeColor','b','LineWidth',3);
     %hold on
        end
    else
        imshow(Img);
    end
    
    
        
    pause(0.01);
%     frame = getframe(gcf);
%     writeVideo(writerObj, frame);
    
    
%      thresh1 =  50; % closer edge
%      thresh2 = sqrt((bx(1,3))^2+(bx(1,4))^2); % weidth of bin, far edge
       %thresh = 0.5 * sqrt((bx(1,3))^2+(bx(1,4))^2);
    
%      for numBx = 1 : length(Indx)
%         bx = Bin(Indx(numBx)).bbx; % box 
%         
%         
%         rectangle('Position',bx,'EdgeColor','b','LineWidth',3);
%         
% 
%      end
    
end
% close(writerObj);


%%
%Dist = zeros(2,2);
   %{
    for ii = 1 : length(idx)
        pt = idx(ii);
        if pt == 3 % right hand
            jt1 = candidates(ii,1:2);
            %d1 = sqrt((candidates(ii,1)-bxx(1,1))^2 + (candidates(ii,2)-bxx(1,2))^2);
        elseif pt == 18 % left hand
                jt2 = candidates(ii,1:2);
        %d2 = sqrt((candidates(ii,1)-bxx(1,3))^2 + (candidates(ii,2)-bxx(1,4))^2);
        elseif ~isequal(pt,3)
            jt1 = [0 0];
        elseif ~isequal(pt,18)
            jt2 = [0 0];
        
        end
        jts = [jt1;jt2];
    
    end
%}
%{
 Dist1 = zeros(1,2); %edge1:[R_up, R_low;L_up, L_low];
        Dist2 = zeros(1,2); %edge2:[R_up,R_low;L_up,L_low]
%          
%         for k = 1 : size(bxx1,2)
%             Dist1(:,k) = sqrt(sum((jts-bxx1(k,:)).^2,2));
%             Dist2(:,k) = sqrt(sum((jts-bxx2(k,:)).^2,2));
%  
%         end
        
        for jt = 1 : size(jts,1)
            if isequal(jts(jt,:),zeros(1,2))
                continue;
            else
                
                for k = 1 : size(bxx1,2)
                    Dist1(1,k) = sqrt(sum((jts(jt,:)-bxx1(k,:)).^2,2));
                    Dist2(1,k) = sqrt(sum((jts(jt,:)-bxx2(k,:)).^2,2));
                    
                end
                
                if Dist1<= thresh1 || Dist2<= thresh2
                    %if ~isempty(d)
                    imshow(Img);
                        %if r == 1 % right hand
                    center = jts(edg,:);
                    pos = [center(1,1)-25, center(1,2)-25, 50, 50];
                    rectangle('Position',pos,'EdgeColor','r','LineWidth',3);
    
                %end   
    
                end  
                
            
            end
         end
        
    end
%}