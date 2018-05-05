# CLASP-Project
This repo is to provide software that we used for doing this project
The aim of this project is to detect if there is an abnormal behaviors at security checking spot in airport, such as stealing things from bins of other people;
The pipline that we designed: 
1) Person and bin detections from Faster-RCNN (repo:https://github.com/longcw/faster_rcnn_pytorch)
2) Multi-person pose estimitions from Realtime_Multi-Person_Pose_Estimation (repo:https://github.com/ZheC/Realtime_Multi-Person_Pose_Estimation)
3) Action Recognition from ACT detector (repo: https://github.com/vkalogeiton/caffe/tree/act-detector/act-detector-scripts)
Note: Please Cite their work if using in a publication

To start:
1. Please clone each repos from above 4 links, then read their instructions to setup;
2. We revised some files by following our dataset, so,
(1) For pose estimation : After you setup all things as instructions; a)replace scripts in 'training' with scripts in our 'training' folder; b) adding our files from 'testing' into the original 'testing' folder; 
(2) For 'Action Recogintion' and 'Person-bin Detection', add files from our folders into the folder you cloned from above links
3. We provided the labeling tool with custimized configuration, you can follow the README.txt inside
