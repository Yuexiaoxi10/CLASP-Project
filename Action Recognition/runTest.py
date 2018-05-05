import sys
import os
import cPickle as pickle
import numpy as np
import scipy.io
t = np.zeros([gt.__len__(),4])

for key, value in gt.iteritems():
    t[key[1] - 1,:] = value[0,:]

scipy.io.savemat('gt_062.mat',mdict = {'gt':t})


#mat = scipy.io.loadmat('ex4C11_PersonBinJointsActGT.mat')