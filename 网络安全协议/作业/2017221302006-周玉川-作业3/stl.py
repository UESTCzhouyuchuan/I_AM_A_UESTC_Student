import socket
import ssl
import pprint

hostname = 'www.yulovexin.xyz'
context = ssl.create_default_context()

with socket.create_connection((hostname, 443)) as sock:
    with context.wrap_socket(sock, server_hostname=hostname) as ssock:
        print("TLS的版本: ",end='')
        pprint.pprint(ssock.version())
        print("密码套件：", end='')
        pprint.pprint(ssock.cipher())
        print("证书信息:")
        pprint.pprint(ssock.getpeercert())