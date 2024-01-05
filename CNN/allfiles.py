import os, os.path
import transint
import numpy as np

trainPath = 'E:/CNNInput/Train/'                     ##特征
testPath = 'E:/CNNInput/Test/' 
trainlabelPath = 'E:/CNNInput/Trainlabel/'             ##标签（1或0）
testlabelPath = 'E:/CNNInput/Testlabel/'

rownum=550
txtType = 'txt'
txtLists = os.listdir(trainPath)  # 列出文件夹下所有的目录与文件
txtLists.sort()
trainrow=np.loadtxt('E:/CNNInput/Trainrow/trainrow.txt')       ##数据集大小
testrow=np.loadtxt('E:/CNNInput/Testrow/testrow.txt')
 

def printall(path,row,judge):
    index = 0
    txtLists = os.listdir(path)
    txtLists.sort()
    allint=[1,2,3,4,5,6,7,8,9,10]
    for filename in txtLists:
        f = open(path + filename)
        a = transint.trans(f,row[index], judge)
        allint[index]=a
        index=index+1
    return(allint)


trainall=printall(trainPath,trainrow,rownum)
testall=printall(testPath,testrow,rownum)

trlabelall=printall(trainlabelPath,trainrow,1)
telabelall=printall(testlabelPath,testrow,1)
