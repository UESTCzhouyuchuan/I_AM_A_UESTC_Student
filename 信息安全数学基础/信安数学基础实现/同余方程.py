# -*- coding: utf-8 -*-
"""
Created on Fri Oct 12 12:41:02 2018

@author: 鑫鑫玉川
"""

#同余方程


def OGLD(a,p):
    if (p==0):
        return a
    else:
        return OGLD(p,a%p)

def OGLD_pro(a,b):
    if (b==0):
        return {'d':a,'x':1,'y':0}
    else:
        t=OGLD_pro(b,a%b)
        temp=t['x']
        t['x']=t['y']
        t['y']=temp-int(a/b)*t['y']
        return t

def find_same_left(a,b,m):
    
    gcd=OGLD(a,m)
    if (b%gcd!=0):
        print ("No rsult")
        return
    a1=int(a/gcd)
    b1=int(b/gcd)
    m1=int(m/gcd)
    print("gcd({3},{4})={5},a1={0},b1={1},m1={2}\n考虑同余方程{0}x=1(mod {2})的解".format(a1,b1,m1,a,m,gcd))
    t=OGLD_pro(a1,m1)
    x=t['x']
    print("因为{}模{}的逆元为{},所以该方程的解x0={}".format(a1,m1,x,x))
    print("x={}+k*{}, k=".format(x*b1,m1),end=' ')
    for i in range(gcd):
        print(i,end=',')
    print("\n所以同余方程{}x={}(mod {})的全部解为:".format(a,b,m),end=' ')
    for i in range(gcd):
        print((x*b1+i*m1)%m,end=',')
    return 
  
"""a,b,m = map(int,input("ax=b(mod m)) :").split())"""
find_same_left(1,3,5)