This folder provides several scripts to visualize the result of person, bin, and pose detections
'runTest.m': visualize the person/bin detections directly, you may need to change the path of images and .mat files
'visual.m': visualize human poses as well as bins together; joint id: 3-right hand; 18-left hand; 6-right elbow; 15-left elbow; the input 'Result' for this function is from script 'visual_clasp';
'visual_clasp.m': 1) script provides another way of visualizing bins and person, you can visualize bin and person seperately using the last 'for' loop in the bottom by using 'bx = Bin(ind(idx)).bbx' or 'bx = Person(ind(idx)).bbx'; 
2)one of outputs from the script 'Result' is used to be as the input for 'visual.m' and also for 'Touching.m';
3) format of 'Result': Result.candi:[x y score joint_id], (x,y) is the position for this joint; Result.imId: number of images which contains this person; Result.imPath: path of images; 
'Touching.m': this scripts is to detect wheather a person is going to touch stuffs in bin.

