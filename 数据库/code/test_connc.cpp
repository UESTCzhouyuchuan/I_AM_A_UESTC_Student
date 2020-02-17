#include <iostream>  
#include <windows.h>  
#include "sqlext.h"  

using namespace std;

/*��ODBC API�������ݿ�:�������ݿ�*/

int main(){

    SQLHENV henv;  //�������   
    SQLHDBC hdbc;  //���Ӿ��   
    SQLHSTMT hstmt;  //�����  
     SQLRETURN retcode; //����ֵ    
    /*���价�����*/     
    retcode = SQLAllocHandle(SQL_HANDLE_ENV,SQL_NULL_HANDLE,&henv);     
    if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO){  
    /*����ODBC��������*/  
        retcode = SQLSetEnvAttr(henv,SQL_ATTR_ODBC_VERSION,(void*)SQL_OV_ODBC3,0); 
        if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO){ 
        /*�������Ӿ��*/  
         retcode = SQLAllocHandle(SQL_HANDLE_DBC,henv,&hdbc);  
         if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO){   
         /*���ӵ�����Դ*/   
         retcode = SQLConnect (hdbc, (SQLCHAR*)"Sales",SQL_NTS,(SQLCHAR*)"",SQL_NTS,  (SQLCHAR*)"",SQL_NTS);       
         if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO){  
         /*���������*/     
         retcode = SQLAllocHandle(SQL_HANDLE_STMT,hdbc,&hstmt);       
         if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO){   
          /*��������*/    
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
