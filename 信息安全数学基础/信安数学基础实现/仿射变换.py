from builtins import int
"""扩展的欧几里得函数，用于求逆"""
def OGLD_pro(a,b):
    if (b==0):
        return {'d':a,'x':1,'y':0}
    else:
        t=OGLD_pro(b,a%b)
        temp=t['x']
        t['x']=t['y']
        t['y']=temp-(a//b)*t['y']
        return t
"""把单词转换为小写，再转化为数字"""
def transToNum(secret):
    secret.lower()
    words="abcdefghijklmnopqrstuvwxyz"
    trans={}
    for i in range(len(words)):
        trans[words[i]]=i
    a=[]
    for i in secret:
        a.append(trans[i])
    return a
"""把数字转化为小写单词"""
def transToWord(a):
    words="abcdefghijklmnopqrstuvwxyz"
    b=a[:]
    for i in range(len(a)):
        b[i]=words[a[i]]
    return b
"""加密算法"""
def encrypt(m,a,b,n):
    for i in range(len(m)):
        m[i]=(m[i]*a+b)%n
    return m
"""解密算法"""
def outEncrypt(m,a,b,n):
    t=OGLD_pro(a,n)
    k=t['x']
    for i in range(len(m)):
        m[i]=(k*(m[i]-b))%n
    return m
#加密过程，输入明文输出密文
def encryptProcess(clearText,a,b,n):
    return(transToWord(encrypt(transToNum(clearText),a,b,n)))
#解密过程，输入密文，输出明文
def outEncryptProcess(secretText,a,b,n):
    return(transToWord(outEncrypt(transToNum(secretText),a,b,n)))

t=encryptProcess("gzyyf",19,23,26)
print(transToNum(t))
print(outEncryptProcess("nptjchyb",11,23,26))
