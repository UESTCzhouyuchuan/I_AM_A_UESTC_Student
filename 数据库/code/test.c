#include "stdafx.h"
#include <stdio.h>  
#include <stdlib.h>  
#include <libpq-fe.h>  
 
void do_exit(PGconn *conn) {  
 
    PQfinish(conn);  
    exit(1);  
}  
 
int main() {  
 
    PGconn *conn = PQconnectdb("user=postgres password=123 dbname=postgres");  
 
    if (PQstatus(conn) == CONNECTION_BAD) {  
 
        fprintf(stderr, "Connection to database failed: %s\n",  
            PQerrorMessage(conn));  
        do_exit(conn);  
    }  
 
    char *user = PQuser(conn);  
    char *db_name = PQdb(conn);  
    char *pswd = PQpass(conn);  
 
    printf("User: %s\n", user);  
    printf("Database name: %s\n", db_name);  
    printf("Password: %s\n", pswd);  
 
    PQfinish(conn);  
 
    return 0;  
} 
--------------------- 
作者：Ethan的博客 
来源：CSDN 
原文：https://blog.csdn.net/zsc201825/article/details/83379100 
版权声明：本文为博主原创文章，转载请附上博文链接！
