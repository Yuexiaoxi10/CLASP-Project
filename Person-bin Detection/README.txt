This folder provides the process of getting detections for person and bins, you may add our files into the folder which you cloned as metioned previously.

1. readGasonIntoXML(g_string,xml_saveDir)
  Read gt in .json file into .xml for training fasterRCNN, including bins and person
  You must add xml_io_tools in the path of Matlab: /Users/Dong/Documents/MATLAB/xml_io_tools_2010_11_05
  Also, g_string is read by geason.m, which means you need geason.m and geasonMex.cp/geasonMex.mex in your path of Matlab

  Parameters:
  g_string: with gason_path as path of .json file, you can obtained g_string by:
	gason_raw = fileread(gason_path);
	g_string = gason(gason_raw);
  xml_saveDir: path of saving .xml


2. CLASPannotationTxt2Xml_Varied(txtDir,saveDir,ctrl_s,img_size)
  Read gt in .txt file into .xml for training fasterRCNN, including bins and person
  You must add xml_io_tools in the path of Matlab: /Users/Dong/Documents/MATLAB/xml_io_tools_2010_11_05

  Parameters:
  txtDir: path of gt
  saveDir: path of saving .xml
  ctrl_s: string to distinguish video series
      example: for video from camera 9 in experiment 6A then s could be 	'6A_C9'
  img_size: size of img. For clasp it should be [1920 1088]
  
3. train.py
  Script for training a new fasterRCNN using gt given.
  To train a new fasterRCNN, you must set your gt data properly.
  In my python project, the subfolder CLASP stores varied labeled or test data. And a folder called ‘data’ is the dir for training fasterRCNN. 3 subfolders could be found in ‘data’:
	Images: images for training
	Annotations: ground truth for training images in xml
	ImageSets: should includes a txt file called ‘train.txt’. Each line of this txt file should be the name of training data.
  You can check folder data_allRotation or data_allNoRotation as example.
  In this file the parameter output_dir could be changed in name as you like. Trained model will be saved in folder ‘model’ with the name given.

4. listDemo.py
  Script for testing and get detection in .mat file with trained network.
  Parameter model_file represents which network you are prefer. Hera are the list of networks has been trained:
  	CLASP_m: trained with 10AC9 and 10AC11, detects bins and person, no rotation, no color bins, contains kids. The training data is same with condition in folder ‘data_allNoRotation’. 
	CLASP_m_colorBinsNoRotation: trained with data only contains color bins of video 12_exp2C11 and 11_exp3C9, detects bins, no rotation, contains color bins.
	CLASP_m_rotationOnly: trained with data only get rotated, with 09_5A_C9,11_exp3_C11,ex4C11, detects bins and person, get rotated, contains color bins.
  Rest of them are not recommended.
  Parameter matName is the name of .mat file to be saved.
  Parameter imgPath is the path storing your test images.


Instructions of training a new fasterRCNN:
1. read ground truth from .json or .txt using corresponding Matlab function and save them into .xml
2. get a list of the names of train data and save them in ‘train.txt’. You can use my matlab function CLASPImgList(xmlDir)
3. copy your images and .xml into data/Images and data/Annotations in python project. copy ‘train.txt’ into data/ImageSets
4. set model name in train.py and run it
5. when you wanna test a new dataset and get detections, set saving name of .mat file and path of testing images, then select model and run listDemo.py
