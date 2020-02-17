import base64
import logging
import os
from random import SystemRandom

from cryptography.exceptions import AlreadyFinalized
from cryptography.exceptions import InvalidTag
from cryptography.exceptions import UnsupportedAlgorithm
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC

# set up logger
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# 功能：利用PBE创建私钥
# 参数：password是用户口令
# 返回值：返回创建的私钥
def create_key(password):
    try:
        # GENERATE password (not needed if you have a password already)
        if not password:
            alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            password = "".join(SystemRandom().choice(alphabet) for _ in range(40))
        password_bytes = password.encode('utf-8')
        # GENERATE random salt (needed for PBKDF2HMAC)
        # Return a string of n random bytes suitable for cryptographic use
        salt = os.urandom(64)
        # DERIVE key (from password and salt)
        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA512(),
            length=32,
            salt=salt,
            iterations=10000,
            backend=default_backend()
        )
        key = kdf.derive(password_bytes)
        return key
    except (UnsupportedAlgorithm, AlreadyFinalized, InvalidTag):
        logger.exception("Symmetric encryption failed")


# 功能：加密消息
# 参数：key为密钥 plain_text是需要被加密的文本
# 返回值：加密后的base64码，AesGcm加密使用的once值
def encryption_mesg(key,plain_text):
    try:
        # GENERATE random nonce (number used once)
        nonce = os.urandom(12)
        # ENCRYPTION
        aesgcm = AESGCM(key)
        cipher_text_bytes = aesgcm.encrypt(
            nonce=nonce,
            data=plain_text.encode('utf-8'),
            associated_data=None
        )
        # CONVERSION of raw bytes to BASE64 representation
        cipher_text = base64.urlsafe_b64encode(cipher_text_bytes)
        return cipher_text,nonce
    except (UnsupportedAlgorithm, AlreadyFinalized, InvalidTag):
        logger.exception("Symmetric encryption failed")


# 功能: 解密消息
# 参数: cipher_text是加密后的64base码
# 返回值：返回解密后的文本
def decryption_mesg(cipher_text,nonce,key):
    try:
        aesgcm = AESGCM(key)
        # DECRYPTION
        decrypted_cipher_text_bytes = aesgcm.decrypt(
            nonce=nonce,
            data=base64.urlsafe_b64decode(cipher_text),
            associated_data=None
        )
        decrypted_cipher_text = decrypted_cipher_text_bytes.decode('utf-8')
        return decrypted_cipher_text
    except (UnsupportedAlgorithm, AlreadyFinalized, InvalidTag):
        logger.exception("Symmetric encryption failed")
# 功能：打开文件，获得文本信息
# 参数： filename为要打开的文件名 可以使用相对路径
# 返回值：返回字符串
def openFile(filename):
    try:
        fp = open(filename,"r",encoding='utf8')
        return "".join(fp.readlines())
    except ():
        print("Something wrong")
# 功能：向文件中写入指定内容
# 参数：filename写入文件的名字，content写入的内容
# 返回值: true/false
def writeFile(filename,content):
    try:
        # print(content)
        fp = open(filename, "w", encoding='utf8')
        return fp.write(str(content)) > 0
    except ():
        print("写入文件出错")
        return False
# 主函数模拟加解密文件过程
def PBE_total_process():
    password = "081849xx@zzq" #定义口令
    key = create_key(password) #获得密钥
    plain_text = openFile('source.txt') # 获得文本
    print("明文：",plain_text)
    cipher_text,nonce = encryption_mesg(key,plain_text) # 进行加密
    print("密文：",cipher_text)
    if (writeFile('ciphertext.txt',cipher_text)):
        print("提示：成功加密并写入密文到ciphertext.txt文件中")
    else:
        print("提示：加密过程出现错误")
    decryption_key = key # 简单模拟密钥传递
    decrypted_cipher_text = decryption_mesg(cipher_text,nonce,decryption_key)
    print("解密之后的明文：",decrypted_cipher_text)
    if (writeFile('after_decrypt.txt',decrypted_cipher_text)):
        print("提示：成功解密并写入明文到after_decrypt.txt文件中")
    else:
        print("提示：解密过程出现错误")

if __name__ == '__main__':
    # demonstrate method
    PBE_total_process()
