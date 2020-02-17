#include <bits/stdc++.h>
#include "main.h"
using namespace std;

int main(void)
{
	FILE*fp;
	FILE*fp1;
	if ((fp=fopen("recoder.txt","r+"))==NULL||(fp1=fopen("in.txt","r+"))==NULL)
	{
		perror("Error: ");
		exit(EXIT_FAILURE);
	}
	Student*XR=new Student;
	memset(XR,sizeof(XR),1);
	ReadExcel(fp1,XR); 
	WriteExcel(fp,XR);
	printf("\t*****************************************\n"
	"\t*                                       *\n"
	"\t*           学生参观记录已写入文档中    *\n"
	"\t*****************************************\n\n");
	Disp(XR);
	fclose(fp);	fclose(fp1);
	return 0;
 } 
