function CLASP_extractFrames( video_dir,frames_dir,rate,type )
%   video_dir: direction of video
%   frames_dir: direction of saving imgs
%   rate: extract one for every %rate frames
v = VideoReader(video_dir);
if ~exist(frames_dir)
    mkdir(frames_dir);
end
i = 0;
while hasFrame(v)
    img = readFrame(v);
    disp(v.CurrentTime/v.Duration)
    if i < 10
        str = ['000',num2str(i)];
    end
    if i >= 10 && i < 100
       str = ['00',num2str(i)]; 
    end
    if i >= 100 && i < 1000
        str = ['0',num2str(i)];
    end
    if i >= 1000
        str = num2str(i);
    end
    if mod(i,rate) == 0
        imwrite(img,[frames_dir,'/',type,'_Frame',str,'.jpg']);
    end
    i = i+1;
end
v.CurrentTime = 0;

