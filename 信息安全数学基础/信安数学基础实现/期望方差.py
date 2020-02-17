# -*- coding: utf-8 -*-
"""
Created on Thu Dec  6 19:30:37 2018

@author: 鑫鑫玉川
"""
import math
lst=[]
lst = list(map(float,input("Input the number(sample):").split()))
print(lst)
sum=0
count=0
for i in range(len(lst)):
    sum+=lst[i]
    count+=1
print(count,sum)
sum=sum/(count*1.0)
variance=0
for i in range(len(lst)):
    variance+=(lst[i]-sum)*(lst[i]-sum)
print(variance)
variance=variance/(count-1)
print("均值：",sum,"方差：",variance)
print("标准差:",math.sqrt(variance))