pathVid ='/Users/yuexizhang/Documents/CLASP/alert-data/04_11_2018/Testing Data/exp5b/cam11exp5b.mp4';
%mkdir('/Users/yuexizhang/Documents/CLASP/training_orig/07212017_EXPERIMENT_9A/Camera11/frames');
% mkdir('/Users/yuexizhang/Documents/CLASP_Labeling/07212017_EXPERIMENT_7A/Frams_Cam9_anno');
pathFra = '/Users/yuexizhang/Documents/CLASP/alert-data/04_11_2018/exp5bC11';
% pathFra_anno = '/Users/yuexizhang/Documents/CLASP_Labeling/07212017_EXPERIMENT_7A/Fram_Cam9_anno';
type = 'C11';
 CLASP_extractFrames( pathVid,pathFra,1,type);
 
%bbLabeler( [{'perron','bin'}], [pathFra], [pathFra_anno]);


