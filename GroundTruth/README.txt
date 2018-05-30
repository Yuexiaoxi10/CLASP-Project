This folder provide several scripts to process ground truth;
1. 'CLASP_extractFrames.m': path of videos; path of output frames; frame rate; type(camera number, such as 9,11);
  Extracting frames from target video in given frame rate
  Parameters:
  video_dir: direction of video
  frames_dir: direction of saving imgs
  rate: extract one for every %rate frames
  s: string to distinguish video series
      example: for video from camera 9 in experiment 6A then s could be 	'6A_C9'
  deg: degree of counterclock rotation, just set it 0

2. 'readGason.m':label_set = readGason(gason_path,str_path,demo_savePath,PathHead)
   Read gt in .json file into .mat for pose estimation, including person, bins, action and person joints
  You must need geason.m and geasonMex.cp/geasonMex.mex in your path of Matlab
  Parameters:
  gason_path: path for .json file
  str_path: string to storage image path for pose estimation
	example: for camera 9 in experiment 6A then str_path could be ‘6A/C9’
  demo_savePath: path for saving images with annotation, not necessary
  PahtHead: path used for saving images with annotation, not necessary

3. 'parseCLASP.m'/ 'script_visual.m' : providing scripts for extracting ground truth from provided 'log' file from ALEAT

4. Toolbox of reading .json file can be found at https://github.com/cocodataset/cocoapi , they provided several API's so you can choose one of them. 

