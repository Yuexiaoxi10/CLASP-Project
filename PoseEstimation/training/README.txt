1. First to read: 'formatData.m'- main script to pre-process the training from the ground truth
1) traing data: experiment 5A: camera 9&11; experiment 9A: camera 11; exp4: camera 11
2) getAnnos.m: orgnized data into a certain format; 
   parameters : a) .bbox: bounding box for each person; 
                b) .keypoints: joints for each person; originally, there are 17 joints, in this project we only use 7  joints(upper body) ,therefore, we pad zeros for the rest; .keypoints = [x1 y1 2 x2 y2 0....], here, '2' means this joint is visible, '0' means the joint is invisible; 
                c) other parameters are not very necessary
3) 'ClaspMask.m': generate masks for each corresponding frame, it will create a folder which contains the mask image
4) 'genJSON_clasp.m': generate the .json file which is the input for the training network; note that you may need to change the 'opt.FileName' at the bottom accordingly;

2. 'Precision_Recall.m': get precision and recall for pose estimation result

3. 'Transformation.m': We used to rotate the original image with some angles, so that the ground truth we labeled is for the rotated image, to train the model with non-rotated image, please use this script to transform the joint position to the original image view;

