# -*- coding: utf-8 -*-
"""
Created on Fri Oct 12 16:27:55 2018

@author: 鑫鑫玉川
"""

def OGLD(a,p):
    if (p==0):
        return a
    else:
        return OGLD(p,a%p)


def double_left1(a,p):
    res=1
    for i in range(int((p-1)/2)):
        res=(res*a)%p
    if (res==1):
        return 1
    elif(res==p-1):
        return 2
    else:
        return 3
    
    
def is_prime(p):#默认为正数
    if (p <=2):
        return False
    i=2
    while(i*i<p):
        if (p%2==0):
            return False
        i=i+1
    return True

def GaoShi(a,p):#求勒让德符号,p为奇素数
    if (a%p==0):
        print("{0}整除{1},故p({0}/{1})=0".format(a,p))
        return 0
    elif (a%p==1):
        print("{0}%{1}=1,故p({0}/{1})=p(1/{1})1".format(a,p))
    elif(a%p==2):
        print("{0}%{1}=2,故p({0}/{1})=p(2/{1})={2:}".format(a,p,(-1)**(int((p**2-1)/8))))
    elif(OGLD(a,2*p)==1):
        T=0
        for i in range(1,int(p/2)+1):
            T+=int((i*a)/p)
        res=-1
        if (T%2==0):
            res=1
        print("因为gcd({},{})==1,T={},所以p({}/{})={}".format(a,2*p,T,a,p,res))
    else:
        sum=0
        temp=0
        for i in range(1,int(p/2)+1):
            temp=a*i%p
            print(temp,end=',')
            if (temp > p/2):
                sum+=1
        print("\n故结果中大于{:.2f}的个数是{}个".format(p/2,sum))
        res=(-1)**sum
        print("p({}/{})={}".format(a,p,res))

a,b=3,5

GaoShi(a,b)
print(double_left1(a,b))
        