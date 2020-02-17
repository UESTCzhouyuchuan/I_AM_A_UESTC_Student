#include <iostream>  
#include <windows.h>  
#include "sqlext.h"  

using namespace std;

/*用ODBC API访问数据库:连接数据库*/

int main(){

    SQLHENV henv;  //环境句柄   
    SQLHDBC hdbc;  //连接句柄   
    SQLHSTMT hstmt;  //语句句柄  
     SQLRETURN retcode; //返回值    
    /*分配环境句柄*/     
    retcode = SQLAllocHandle(SQL_HANDLE_ENV,SQL_NULL_HANDLE,&henv);     
    if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO){  
    /*设置ODBC环境属性*/  
        retcode = SQLSetEnvAttr(henv,SQL_ATTR_ODBC_VERSION,(void*)SQL_OV_ODBC3,0); 
        if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO){ 
        /*分配连接句柄*/  
         retcode = SQLAllocHandle(SQL_HANDLE_DBC,henv,&hdbc);  
         if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO){   
         /*连接到数据源*/   
         retcode = SQLConnect (hdbc, (SQLCHAR*)"Sales",SQL_NTS,(SQLCHAR*)"",SQL_NTS,  (SQLCHAR*)"",SQL_NTS);       
         if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO){  
         /*分配语句句柄*/     
         retcode = SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);       
         if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO){   
          /*处理数据*/    
          cout << "ok" << endl;    
          SQLFreeHandle(SQL_HANDLE_STMT,hstmt); 
          }     
          SQLDisconnect(hdbc);         
          }    
          SQLFreeHandle(SQL_HANDLE_DBC,hdbc);         
          } 
         }
     }     
     return 0;
}
