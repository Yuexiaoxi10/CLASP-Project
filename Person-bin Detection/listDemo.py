import cv2
import numpy as np
from faster_rcnn import network
from faster_rcnn.faster_rcnn import FasterRCNN
from faster_rcnn.utils.timer import Timer
import imageio
import scipy.io as sio
import glob
from PIL import Image

def test():
    import os
    # im_file = 'demo/004545.jpg'
    # im_file = 'data/VOCdevkit2007/VOC2007/JPEGImages/009036.jpg'
    # im_file = '/media/longc/Data/data/2DMOT2015/test/ETH-Crossing/img1/000100.jpg'

    matName = 'exp5bC9.mat'
    model_file = '/home/dong/PycharmProjects/fasterRCNN/faster_rcnn_pytorch-master/model/CLASP_m_rotation_withNoRot_More/faster_rcnn_20000.h5'
    # model_file = '/media/longc/Data/models/faster_rcnn_pytorch3/faster_rcnn_100000.h5'
    # model_file = '/media/longc/Data/models/faster_rcnn_pytorch2/faster_rcnn_2000.h5'
    #CLASP_class = np.asarray(['__background__',  # always index 0
    #                          'person', 'bin'])
    UCF_class = np.asarray(['__background__', 'person', 'bin'])
    label = UCF_class[1:] #CLASP_class[1:]
    detector = FasterRCNN(UCF_class) #CLASP_class
    network.load_net(model_file, detector)
    detector.cuda()
    detector.eval()
    print('load model successfully!')

    #filename = "/home/dong/PycharmProjects/fasterRCNN/faster_rcnn_pytorch-master/CLASP/video/07212017_EXPERIMENT_9A_Aug7/mp4s/Camera_9.mp4"
    #vid = imageio.get_reader(filename, 'ffmpeg')
    imgPath = "/home/dong/PycharmProjects/fasterRCNN/faster_rcnn_pytorch-master/CLASP/exp5bC9/exp5bC9/" #"/home/dong/PycharmProjects/fasterRCNN/faster_rcnn_pytorch-master/CLASP/C11_50_selected/"
    imgType = '*.jpg'
    image_list = []
    for filename in glob.glob(imgPath+imgType):  # assuming jpg
        #im = Image.open(filename)
        image_list.append(filename)
        #im.close()


    spliter = 'Frame'#'Frame'
    result = {x: np.zeros([1,5] )for x in label}

    for i,name in enumerate(image_list):
        ele = Image.open(name)
        image = np.asarray(ele)
        str = ele.filename
        str = str.split(spliter)[1].split('.')[0]
        ind = int(str)
        t = Timer()
        t.tic()
        dets, scores, classes = detector.detect(image, 0.7)
        runtime = t.toc()
        for j, label in enumerate(classes):
            tmp = np.empty([1,5])
            tmp[0][0:4] = dets[j]
            tmp[0][4] = ind
            if result[label].max() == 0:
                 result[label][0] = tmp
            else:
                result[label] = np.append(result[label],tmp,axis=0)

        print('Progress: {a:8.2f}%'.format(a=i*100.0/image_list.__len__()))
        print('total spend: {}s'.format(runtime))
        ele.close()

    sio.savemat(matName, result) #result_9AC11_selected.mat
    #for im in enumerate(vid):
        #image = np.asarray(im)

    # network.save_net(r'/media/longc/Data/models/VGGnet_fast_rcnn_iter_70000.h5', detector)
    # print('save model succ')


    # image = np.zeros(shape=[600, 800, 3], dtype=np.uint8) + 255
    '''
    dets, scores, classes = detector.detect(image, 0.7)
    runtime = t.toc()
    print('total spend: {}s'.format(runtime))

    im2show = np.copy(image)
    for i, det in enumerate(dets):
        det = tuple(int(x) for x in det)
        cv2.rectangle(im2show, det[0:2], det[2:4], (255, 205, 51), 2)
        cv2.putText(im2show, '%s: %.3f' % (classes[i], scores[i]), (det[0], det[1] + 15), cv2.FONT_HERSHEY_PLAIN,
                    1.0, (0, 0, 255), thickness=1)
    cv2.imwrite(os.path.join('demo', 'out.jpg'), im2show)
    cv2.imshow('demo', im2show)
    cv2.waitKey(0)
    '''

if __name__ == '__main__':
    test()
