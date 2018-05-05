import scipy.io as sio
import numpy as np
import json
import cv2
import lmdb
import sys, os

# change your caffe path here
sys.path.insert(0, os.path.join('/home/yuexi/Documents/Realtime_Multi-Person_Pose_Estimation/caffe_train/', 'python/'))
import caffe
GPU_ID = 0 # Switch between 0 and 1 depending on the GPU you want to use.
caffe.set_mode_gpu()
caffe.set_device(GPU_ID)
import os.path
import struct
import matplotlib.pyplot as plt


def writeLMDB(datasets, lmdb_path, validation):
    env = lmdb.open(lmdb_path, map_size=int(1e12))
    txn = env.begin(write=True)
    data = []
    numSample = 0

    for d in range(len(datasets)):
        #if (datasets[d] == "MPI"):
          #  print datasets[d]
         #   with open('MPI.json') as data_file:
          #      data_this = json.load(data_file)
           #     data_this = data_this['root']
            #    data = data + data_this
           # numSample = len(data)
            # print data
           # print numSample
        if (datasets[d] == "clasp"):
            print datasets[d]
            with open('./Clasp/json/Clasp_5A_9A_exp4.json') as data_file:
                data_this = json.load(data_file)
                data_this = data_this['root']
                data = data + data_this
            numSample = len(data)
            # print data
            print numSample

    random_order = np.random.permutation(numSample).tolist()

    isValidationArray = [data[i]['isValidation'] for i in range(numSample)];
    if (validation == 1):
        totalWriteCount = isValidationArray.count(0.0);
    else:
        totalWriteCount = len(data)
    print totalWriteCount;
    writeCount = 0

    # for count in range(numSample):
    for count in range(numSample):
        idx = random_order[count]
        #idx = 530
        print idx
        if (data[idx]['isValidation'] != 0 and validation == 1):
            print '%d/%d skipped' % (count, idx)
            continue

        #if "MPI" in data[idx]['dataset']:
        #    path_header = 'dataset/MPI/images/'
        #if "Clasp" in data[idx]['dataset']:
        path_header = '/home/yuexi/Documents/CLASP/'
        if idx<=377:
            print os.path.join(path_header, data[idx]['img_paths'])
            img = cv2.imread(os.path.join(path_header, data[idx]['img_paths']))
        elif 378<=idx<=450:
            print os.path.join(path_header + 'frames/', data[idx]['img_paths'])
            img = cv2.imread(os.path.join(path_header + 'frames/', data[idx]['img_paths']))
        else:
            print os.path.join(path_header + data[idx]['img_paths'])
            img = cv2.imread(os.path.join(path_header, data[idx]['img_paths']))

        print data[idx]['img_paths']
        img_idx_name = data[idx]['img_paths'][-8:-3]
        #img_idx = data[idx]['img_paths'][-8:-3]
        print img_idx_name
        if "clasp" in data[idx]['dataset']:
            # mask_all = cv2.imread(path_header + 'frames/09272017_5A/mask_c11/mask_all_09_5AC11_Frame' + img_idx_name + 'png', 0)
            # mask_miss = cv2.imread(path_header + 'frames/09272017_5A/mask_c11/mask_miss_09_5AC11_Frame' + img_idx_name + 'png', 0)
            # print path_header + 'frames/09272017_5A/mask_c11/mask_all_09_5AC11_Frame' + img_idx_name + 'png'
            # print path_header + 'frames/09272017_5A/mask_c11/mask_miss_09_5AC11_Frame' + img_idx_name + 'png'

        #for camera 9 & 11 together
            if idx<145:
                mask_all = cv2.imread(path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_all_09_5AC9_Frame' + img_idx_name + 'png', 0)
                mask_miss = cv2.imread(path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_miss_09_5AC9_Frame' + img_idx_name + 'png', 0)
                print path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_all_09_5AC9_Frame' + img_idx_name + 'png'
                print path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_miss_09_5AC9_Frame' + img_idx_name + 'png'
            elif 145<=idx<378:
                mask_all = cv2.imread(path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_all_09_5AC11_Frame' + img_idx_name + 'png', 0)
                mask_miss = cv2.imread(path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_miss_09_5AC11_Frame' + img_idx_name + 'png', 0)
                print path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_all_09_5AC11_Frame' + img_idx_name + 'png'
                print path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_miss_09_5AC11_Frame' + img_idx_name + 'png'
            elif 378<=idx<451:
                mask_all = cv2.imread(path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_all_09_9AC11_Frame' + img_idx_name + 'png', 0)
                mask_miss = cv2.imread(path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_miss_09_9AC11_Frame' + img_idx_name + 'png', 0)
                print path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_all_09_9AC11_Frame' + img_idx_name + 'png'
                print path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_miss_09_9AC11_Frame' + img_idx_name + 'png'
            else:
                mask_all = cv2.imread(path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_all_ex4_C11_Frame' + img_idx_name + 'png', 0)
                mask_miss = cv2.imread(path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_miss_ex4_C11_Frame' + img_idx_name + 'png', 0)
                print path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_all_ex4_C11_Frame' + img_idx_name + 'png'
                print path_header + 'frames/09272017_5A/mask_5A_9A_exp4/mask_miss_ex4_C11_Frame' + img_idx_name + 'png'



        # original dataset
        # elif "COCO" in data[idx]['dataset']:
        #     mask_all = cv2.imread(path_header + 'mask2014/train2014_mask_all_' + img_idx + 'png', 0)
        #     mask_miss = cv2.imread(path_header + 'mask2014/train2014_mask_miss_' + img_idx + 'png', 0)
        #     print path_header + 'mask2014/train2014_mask_miss_' + img_idx + 'png'
        # elif "MPI" in data[idx]['dataset']:
        #     img_idx = data[idx]['img_paths'][-13:-3];
        #     # print img_idx
        #     mask_miss = cv2.imread('dataset/MPI/masks/mask_' + img_idx + 'jpg', 0)
        #mask_all = mask_miss

        height = img.shape[0]
        width = img.shape[1]
        if (width < 64):
            img = cv2.copyMakeBorder(img, 0, 0, 0, 64 - width, cv2.BORDER_CONSTANT, value=(128, 128, 128))
            print 'saving padded image!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
            cv2.imwrite('padded_img.jpg', img)
            width = 64
        # no modify on width, because we want to keep information
        meta_data = np.zeros(shape=(height, width, 1), dtype=np.uint8)
        print type(img), img.shape
        print type(meta_data), meta_data.shape
        clidx = 0  # current line index
        # dataset name (string)
        for i in range(len(data[idx]['dataset'])):
            meta_data[clidx][i] = ord(data[idx]['dataset'][i])
        clidx = clidx + 1
        # image height, image width
        height_binary = float2bytes(data[idx]['img_height'])
        for i in range(len(height_binary)):
            meta_data[clidx][i] = ord(height_binary[i])
        width_binary = float2bytes(data[idx]['img_width'])
        for i in range(len(width_binary)):
            meta_data[clidx][4 + i] = ord(width_binary[i])
        clidx = clidx + 1
        # (a) isValidation(uint8), numOtherPeople (uint8), people_index (uint8), annolist_index (float), writeCount(float), totalWriteCount(float)
        meta_data[clidx][0] = data[idx]['isValidation']
        meta_data[clidx][1] = data[idx]['numOtherPeople']
        meta_data[clidx][2] = data[idx]['people_index']
        annolist_index_binary = float2bytes(data[idx]['annolist_index'])
        for i in range(len(annolist_index_binary)):  # 3,4,5,6
            meta_data[clidx][3 + i] = ord(annolist_index_binary[i])
        count_binary = float2bytes(float(writeCount))  # note it's writecount instead of count!
        for i in range(len(count_binary)):
            meta_data[clidx][7 + i] = ord(count_binary[i])
        totalWriteCount_binary = float2bytes(float(totalWriteCount))
        for i in range(len(totalWriteCount_binary)):
            meta_data[clidx][11 + i] = ord(totalWriteCount_binary[i])
        nop = int(data[idx]['numOtherPeople'])
        clidx = clidx + 1
        # (b) objpos_x (float), objpos_y (float)
        objpos_binary = float2bytes(data[idx]['objpos'])
        for i in range(len(objpos_binary)):
            meta_data[clidx][i] = ord(objpos_binary[i])
        clidx = clidx + 1
        # (c) scale_provided (float)
        scale_provided_binary = float2bytes(data[idx]['scale_provided'])
        for i in range(len(scale_provided_binary)):
            meta_data[clidx][i] = ord(scale_provided_binary[i])
        clidx = clidx + 1
        # (d) joint_self (3*16) (float) (3 line)
        joints = np.asarray(data[idx]['joint_self']).T.tolist()  # transpose to 3*16
        for i in range(len(joints)):
            row_binary = float2bytes(joints[i])
            for j in range(len(row_binary)):
                meta_data[clidx][j] = ord(row_binary[j])
            clidx = clidx + 1
        # (e) check nop, prepare arrays
        if (nop != 0):
            if (nop == 1):
                joint_other = [data[idx]['joint_others']]
                objpos_other = [data[idx]['objpos_other']]
                scale_provided_other = [data[idx]['scale_provided_other']]
            else:
                joint_other = data[idx]['joint_others']
                objpos_other = data[idx]['objpos_other']
                scale_provided_other = data[idx]['scale_provided_other']
            # (f) objpos_other_x (float), objpos_other_y (float) (nop lines)
            for i in range(nop):
                objpos_binary = float2bytes(objpos_other[i])
                for j in range(len(objpos_binary)):
                    meta_data[clidx][j] = ord(objpos_binary[j])
                clidx = clidx + 1
            # (g) scale_provided_other (nop floats in 1 line)
            scale_provided_other_binary = float2bytes(scale_provided_other)
            for j in range(len(scale_provided_other_binary)):
                meta_data[clidx][j] = ord(scale_provided_other_binary[j])
            clidx = clidx + 1
            # (h) joint_others (3*16) (float) (nop*3 lines)
            for n in range(nop):
                joints = np.asarray(joint_other[n]).T.tolist()  # transpose to 3*16
                for i in range(len(joints)):
                    row_binary = float2bytes(joints[i])
                    for j in range(len(row_binary)):
                        meta_data[clidx][j] = ord(row_binary[j])
                    clidx = clidx + 1

        print meta_data[0:12,0:48]
        # total 7+4*nop lines
        if "clasp" in data[idx]['dataset']:
            img4ch = np.concatenate((img, meta_data, mask_miss[..., None], mask_all[..., None]), axis=2)
        # img4ch = np.concatenate((img, meta_data, mask_miss[...,None]), axis=2)
        # elif "MPI" in data[idx]['dataset']:
        #     img4ch = np.concatenate((img, meta_data, mask_miss[..., None]), axis=2)

        img4ch = np.transpose(img4ch, (2, 0, 1))
        print img4ch.shape

        datum = caffe.io.array_to_datum(img4ch, label=0)
        key = '%07d' % writeCount
        txn.put(key, datum.SerializeToString())
        if (writeCount % 1000 == 0):
            txn.commit()
            txn = env.begin(write=True)
        print '%d/%d/%d/%d' % (count, writeCount, idx, numSample)
        writeCount = writeCount + 1

    txn.commit()
    env.close()


def float2bytes(floats):
    if type(floats) is float:
        floats = [floats]
    return struct.pack('%sf' % len(floats), *floats)


if __name__ == "__main__":
    # writeLMDB(['MPI'], '/home/zhecao/MPI_pose/lmdb', 1)
    writeLMDB(['clasp'], '/home/yuexi/Documents/Realtime_Multi-Person_Pose_Estimation/training/CLASP/Clasp/lmdb_5A_9A_exp4', 0)
    print 'done'