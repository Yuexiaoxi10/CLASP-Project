% This script is to detect wheather there is an change of a bin;
% It is detected by finding the pixel difference of path extracted from the same
% in two consecutive frames




close;

%for k = 1 : length(Result)
    
 for ind = 1 : length(Result)/2
    %candidates = Result(ind).candi;
    Img1 = imread(Result(ind).imPath);
    Img2 = imread(Result(ind+1).imPath);
    Indx1 = find(Result(ind).imId == Id_bin); % current frame
    Indx2 = find(Result(ind+1).imId == Id_bin); % next frame
    for numBx1 = 1 : length(Indx1)
        if Bin(Indx1(numBx1)).act == 1
            bx1 = Bin(Indx1(numBx1)).bbx; % box 
            patch1 = Img1(bx1(2):bx1(2)+bx1(4),bx1(1):bx1(1)+bx(3),:);
            for numBx2 = 1 : length(Indx2)
                if Bin(Indx2(numBx2)).act == 1
                    bx2 = Bin(Indx2(numBx2)).bbx;
                    patch2 = Img2(bx2(2):bx2(2)+bx2(4),bx2(1):bx2(1)+bx2(3),:);
                    
                    Diff = abs(mean(patch1(:)) - mean(patch2(:)));
                    
                    if Diff > 0.5
                        Bin(Indx2(numBx2)).change = 1;
                      
                    end
                end
            end
        end
    
    end
    
    %pause;
    
 end

 %%
 for fr = 1 : length(Result)
     fr 
     Img = imread(Result(fr).imPath);
     Indx = find(Result(fr).imId == Id_bin);
     imshow(Img)
     for numBx = 1 : length(Indx)
         bx = Bin(Indx(numBx)).bbx;
         if Bin(Indx(numBx)).act == 1
            bx1 = Bin(Indx(numBx)).bbx; % box 
            
            rectangle('Position',[bx1(1,1),bx1(1,2),250,100],'EdgeColor','y','LineWidth',3);
            hold on
            %pause(0.1);
         else
            rectangle('Position',bx,'EdgeColor','r','LineWidth',3);

            
         end
     end
     pause;
  
 end