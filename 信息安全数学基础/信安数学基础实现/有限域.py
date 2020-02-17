# -*- coding: utf-8 -*-
"""
Created on Thu Dec  6 11:00:28 2018

@author: 鑫鑫玉川
"""



"""
名字：Mod(a,b,n),a,b表示列表，长度都为n
功能：返回a模b的列表
"""
def Mod(a,b,n):
      result=a[:]                   #c拷贝a
      d=b[:]
      a_len=n
      b_len=n
      for i in range(n):
            if(a[i]!=0):
                  break
            a_len-=1
      for i in range(n):
            if (b[i]!=0):
                  break
            b_len-=1
      #print(a_len,b_len)#测试
      if (a_len >= b_len):
            for i in range(b_len,a_len):
                  d.append(0)
            for i in range(a_len-1,b_len-2,-1):
                  #print(n-i-1,a_len, b_len,n,a,b,result)#测试
                  if(result[n-i-1]==1):
                        result=AddSub(result,d[i-b_len+1:n+i-b_len+1],n)
                  #print("Mod",result)#测试代码
      return result


"""
名字：AddSub(a,b,n),a,b为列表，长度为n
功能：返回a减b或者a加b
说明：无论是加运算,还是减运算，在模2运算中算法相同
"""
def AddSub(a,b,n):
    c=[]
    for i in range(n):
        c.append(a[i]^b[i])
    return c


"""
名字：Multiply(a,b,n),a,b为列表，长度为n
功能：返回a乘b的元素
"""
def Multiply(a, b, n, mod):
     c=a[:]
     while (n<len(mod)):
           c.insert(0,0)
           b.insert(0,0)
           n+=1
     result=[0 for i in range(n)]
     for i in range(n-1, -1 , -1):
        if ( b[i]==1 ):
            result = AddSub(result,c,n)
        c.append(0)          
        c.pop(0)                    #相当于左移一位
        c = list(Mod(c, mod, n))#得到c模基准的多项式
        #print("Multi",c)#测试
     return result
"""
名字：Divide(a,b,n),a,b为列表，长度为n
功能：返回a整除b后的多项式
"""
def Divide(a , b , n):
      c=a[:]
      d=b[:]
      result=[0 for i in range(n)]
      a_len=n
      b_len=n
      for i in range(n):
            if(a[i]!=0):
                  break
            a_len-=1
      for i in range(n):
            if (b[i]!=0):
                  break
            b_len-=1
      if (a_len >= b_len):
            for i in range(b_len,a_len):
                  d.append(0)
            for i in range(a_len-1,b_len-2,-1):
                  if(c[n-i-1]==1):
                        result[n-i+b_len-2]=1
                        c=AddSub(c,d[i-b_len+1:n+i-b_len+1],n)
                        #print(c,result),测试代码
      return result
                  
                  
"""
名字：getRes(a,b,n,mod),a,b为列表，长度为n
功能：求多项式a关于b的逆元

原扩展欧几里得算法
def OGLD_pro(a,b):
    if (b==0):
        return {'d':a,'x':1,'y':0}
    else:
        t=OGLD_pro(b,a%b)
        temp=t['x']
        t['x']=t['y']
        t['y']=temp-int(a/b)*t['y']
        return t
"""
def getRes(a,b,n,mod):
     if (max(b)==0):#证明c中，即b中全为0
       x=[0 for i in range(n-1)]
       x.append(1)
       #print("end",x)#测试
       return {'d':a[:],'x':x,'y':[0 for i in range(n)]}
     else:
          t=getRes(b,Mod(a,b,n),n,mod)
          #print(t)#测试
          temp=list(t['x'])
          t['x']=list(t['y'])
          t['y']=AddSub(temp,Multiply(Divide(a,b,n),t['y'],n,mod),n)
          
          return t
"""
名字：ExpOfMod(a,k,myMod,n):列表a,k为指数，myMod为要模的多项式，n为列表长度
功能：模的指数运算，重复平方算法

"""
def ExpOfMod(a,k,mod,n):
      result=[0 for i in range(n-1)]
      result.append(1)
      if ( k!= 0):
            A = a[:]
            if ( k%2 == 1):
                  result = a[:]
            k = k //2    #注意整除
            while (k != 0):
                  A = Multiply(A,A,n,mod)
                  if (k%2==1):
                        result = Multiply(A,result,n,mod)
                  k = k // 2
                  #print(result,k)#用于测试
      return result
"""
名字：transList(lst),lst为列表
功能:用于把列表中二进制数转化为10进制
"""
def transList(lst):
      #n=len(lst)
      result=0
      for i in lst:
            result*=2
            result+=i
            
      return result
#用列表中元素，从低位到高位依次表示二进制数的高位到低位
#列表，可以进行的操作包括索引，切片，加，乘，检查成员。

"""
名字：基准，即要模得多项式，用多项式基表示
功能：作为全局变量
注意：多项式一定不能拆分，即不可约多项式
"""
myMod = [1,0,1,1,0,0,0,1,1]   #基准表示要模的元素，即f(x)=x^8 + x^6 + x^5 + x + 1
testMod =[1,0,0,1,1]          #类似myMod，用于测试,f(x)=x^4 + x + 1


a=[0,0,0,0,0,0,1,1,1]         #f(x)=x^2+x+1
b=[0,1,0,1,0,1,1,0,1]         #f(x)=x^7+x^5+x^3+x^2+1
print("a=",a)
print("b=",b)
print("a+b=a-b=",AddSub(a,b,len(a)))      #输出相加减结果
print("b/a=",Divide(b,a,len(a)))          #输出相除结果
print("a*b=",Multiply(a,b,len(a),myMod))#输出相乘结果
t=getRes(a,myMod,9,myMod)
a_=t['x']                           #a的逆
print("a得逆元为：",a_)              #输出逆元


base = [0,0,0,0,0,0,0,1,0]    #本原元
ExpList=[0 for i in range(256)]#指数表,初始化为0
LogList=[0 for i in range(256)]#对数表，初始化为0
LogList[0]=255
for i in range(255):          #循环得到指数对数表
      index=transList(ExpOfMod(base,i,myMod,len(base)))
      ExpList[i]=index
      LogList[index]=i
print("\n\t\t\t\t\t指数对数表\n\n")
i=0
while(i<256):
      while(True):
            if (i%16==0):
                  print("{:8s}".format("序号"),end=' ')
            print("{:4d}".format(i),end=' ')
            if ((i+1)%16==0):
                  print('\n')
                  i=i-15
                  break;
            i+=1
      while(True):
            if (i%16==0):
                  print("{:9s}".format("(02)^i"),end=' ')
            print("{:4d}".format(ExpList[i]),end=' ')
            if ((i+1)%16==0):
                  print('\n')
                  i=i-15
                  break;
            i+=1
      while(True):
            if (i%16==0):
                  print("{:7s}".format("log(02)^i"),end=' ')
            print("{:4d}".format(LogList[i]),end=' ')
            if ((i+1)%16==0):
                  print('\n\n')
                  i+=1
                  break;
            i+=1
