function visual(Result)
close all
%run visual_clasp first
%writerObj = VideoWriter('9AC11_person_bin.avi');
%writerObj.FrameRate = 5;
%open(writerObj);
%Result = Result1;
%Result = Result_09C11;
%secsPerImg = 5;
for i = 104 %: 375 %length(Result)
    Img = imread(Result(i).imPath);
    Indx = find(Result(i).imId == Id);
    
    limbSeq =  [2 3; 2 6; 3 4; 4 5; 6 7; 7 8; 2 9; 9 10; 10 11; 2 12; 12 13; 13 14; 2 1; 1 15; 15 16; 15 18; 17 6; 6 3; 6 18];
    colors = hsv(length(limbSeq));
    facealpha = 0.8;
    stickwidth = 4;
    joint_color1 = [255, 0, 0;  0, 255, 0]; 
    joint_color2 = [0, 255, 255;  0, 170, 255;  0, 85, 255;  0, 0, 255;   85, 0, 255;  170, 0, 255;  255, 0, 255;  255, 0, 170;  255, 0, 85;255, 85, 0;  255, 170, 0;  255, 255, 0;  170, 255, 0;   85, 255, 0; 0, 255, 85;  0, 255, 170;  ];
    candidates = Result(i).candi; 
    subset = Result(i).sub;
    ind = candidates(:,4);
    for ii = 1 : length(ind)
        index = ind(ii);
        if index == 3
            X = candidates(ii,1);
            Y = candidates(ii,2);
            Img = insertShape(Img, 'FilledCircle', [X Y 8], 'Color', joint_color1(1,:)); 
            %imshow(Img),hold on
        
        elseif index == 18
            X = candidates(ii,1);
            Y = candidates(ii,2);
            Img = insertShape(Img, 'FilledCircle', [X Y 8], 'Color', joint_color1(2,:)); 
            %imshow(Img),hold on
        
        
        elseif index == 0
               continue;
        elseif index == 2
            continue;
            
        elseif index == 6
            X = candidates(ii,1);
            Y = candidates(ii,2);
            Img = insertShape(Img, 'FilledCircle', [X Y 8], 'Color', joint_color2(ii,:)); 
        elseif index == 15
            X = candidates(ii,1);
            Y = candidates(ii,2);
            Img = insertShape(Img, 'FilledCircle', [X Y 8], 'Color', joint_color2(ii,:)); 
            %}
        end
        
    end
    imshow(Img),hold on
    for idx = 1 : length(Indx)
        
        rectangle('Position',Bin(Indx(idx)).bbx,'EdgeColor','b','LineWidth',3);
        
        %pause(0.1);
    end
    % finding joints for each person
    %{
    for num = 1:size(subset,1)
        %imshow(image);
        for ii = 1:18
            index = subset(num,ii);
            if index == 0 
                continue;
            end
            if index == 2
                continue;
            end
            X = candidates(index,1);
            Y = candidates(index,2);
            Img = insertShape(Img, 'FilledCircle', [X Y 8], 'Color', joint_color(ii,:)); 
        end
    end
    imshow(Img),hold on
    %}
    % plot for each part
    
        for k = 15:18 
            
            for num = 1:size(subset,1)      
                index = subset(num,limbSeq(k,1:2));
                if sum(index==0)>0
                    continue;
                end
                X = candidates(index,1);
                Y = candidates(index,2);

                if(~sum(isnan(X)))
                    mX = mean(X);
                    mY = mean(Y);
                    [~,~,V] = svd(cov([X-mX Y-mY]));
                    v = V(2,:);

                    pts = [X Y];
                    pts = [pts; pts + stickwidth*repmat(v,2,1); pts - stickwidth*repmat(v,2,1)];
                    A = cov([pts(:,1)-mX pts(:,2)-mY]);
                    if any(X)
                        he(i) = filledellipse(A,[mX mY],colors(k,:),facealpha);
                    end
                end
            end
        
        %export_fig(['video/connect_' num2str(i) '.png']);
        end
    %}
   %pause(0.1); 
   pause;
   frame = getframe(gcf);
   
    %writeVideo(writerObj, frame);
    
    %{
    for ii = 1 : length(candidate)
        
        plot(candidate(ii,1),candidate(ii,2),'r*');
     
        1;
      
    end
    %}
    
    
end
%close(writerObj);
