#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include "sql.h"
#include "sqltypes.h"
#include "sqlext.h"
#include"sqlucode.h"
#include"odbcinst.h" 
#include<iostream>
#include<string>
using namespace std;
RETCODE retcode;//结果返回集
SQLHDBC hdbc;//定义链接句柄
void SQL(string);//执行 SQL 语句子程序
int main()
{
    string str;
    SQLHANDLE henv; //定义环境句柄
    unsigned char db[] = "PostgreSQL35W";//ODBC 数据源名称
    unsigned char user[] = "postgres";//用户名
    unsigned char password[] = "081849";//密码 
    retcode = SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &henv);
    if (retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO)   
        retcode = SQLSetEnvAttr(henv, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0);//声明环境
    if (retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO)
        retcode = SQLAllocHandle(SQL_HANDLE_DBC, henv, &hdbc); //分配连接句柄
    if (retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO)
        retcode = SQLConnect(hdbc, db, SQL_NTS, user, SQL_NTS, password, SQL_NTS);//链接到数据库
    if (retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO) //成功连接到数据库
    {
        cout << "成功连接数据库！"<<endl;
    }
    SQLFreeConnect(hdbc); ////释放链接句柄
    SQLFreeEnv(henv); // 释放 ODBC 环境句柄
    system("pause");
    return 0;
}

void SQL(string str)
{
    char L1[50] = { '\0' }; char L2[50] = { '\0' }; char L3[50] = { '\0' }; char L4[50] = { '\0' }; char L5[50] = { '\0' }; char L6[50] = { '\0' };
    SQLLEN lenOut1, lenOut2, lenOut3, lenOut4, lenOut5, lenOut6;
    SQLHSTMT hstmt;//定义语句句柄
    retcode = SQLAllocHandle(SQL_HANDLE_STMT, hdbc, &hstmt); //分配语义句柄
    if (retcode == SQL_SUCCESS)
    {
        retcode = SQLExecDirect(hstmt, (SQLCHAR *)(str.c_str()), SQL_NTS); // 把SQL语句送到数据库服务器，请求执行由SQL语句定义的数据库访问
        if (retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO)
        {
            cout << "语句执行成功！" << endl;
            //将结果集中的属性列一一绑定至变量
            retcode = SQLBindCol(hstmt, 1, SQL_C_CHAR, L1, sizeof(L1), &lenOut1);
            retcode = SQLBindCol(hstmt, 2, SQL_C_CHAR, L2, sizeof(L2), &lenOut2);
            retcode = SQLBindCol(hstmt, 3, SQL_C_CHAR, L3, sizeof(L3), &lenOut3);
            retcode = SQLBindCol(hstmt, 4, SQL_C_CHAR, L4, sizeof(L4), &lenOut4);
            retcode = SQLBindCol(hstmt, 5, SQL_C_CHAR, L5, sizeof(L5), &lenOut5);
            retcode = SQLBindCol(hstmt, 6, SQL_C_CHAR, L6, sizeof(L6), &lenOut6);         //把所有捆绑过的数据字段的数据拷贝到相应的缓冲区
            retcode = SQLFetch(hstmt); //将游标移动到到查询结果集的第一行
            while (retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO)
            {
                if (L2[0] == '\0')
                    cout << (string)L1 << endl;
                else if (L3[0] == '\0')
                    cout << (string)L1 << "\t" << (string)L2 << endl;
                else if (L4[0] == '\0')
                    cout << (string)L1 << " " << (string)L2 << " " << (string)L3 << endl;
                else if (L5[0] == '\0')
                    cout << (string)L1 << " " << (string)L2 << " " << (string)L3 << " " << (string)L4 << endl;
                else if (L6[0] == '\0')
                    cout << (string)L1 << " " << (string)L2 << " " << (string)L4 << " " << (string)L4 << " " << (string)L5 << endl;
                else
                    cout << (string)L1 << " " << (string)L2 << " " << (string)L4 << " " << (string)L4 << " " << (string)L5 << " " << (string)L6 << endl;
                retcode = SQLFetch(hstmt); //将游标移动到到查询结果集的下一行
            }
        }
    }
    SQLFreeStmt(hstmt, SQL_DROP); //释放语句句柄
}