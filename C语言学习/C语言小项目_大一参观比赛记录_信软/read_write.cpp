#include <bits/stdc++.h>
#include "main.h"
using namespace std;

void WriteExcel(FILE*fp,Student*XR)
{
	int i=0;
    fprintf(fp,"%s\t\t%s\t%s  %s\t%s\n","ѧ��","����","�Ƿ�ι�","�ι۹�˾", "�ι�ʱ��");
	for (;i< XR->counter&&i<MAXV;i++)
	fprintf(fp,"%-15s%-10s%-10d%-10s%-10s\n",XR->IT[i].IDnum,XR->IT[i].name,XR->IT[i].went,XR->IT[i].firm,XR->IT[i].time);
}
//ÿ��readǰXR���ǿյ� 
void ReadExcel (FILE*fp,Student *XR)
{
	student e;
	fseek(fp,45L,SEEK_CUR);
	int i=0;
	while ((fscanf(fp,"%s\t%s\t%d\t%s\t%s\n",e.IDnum,e.name,&e.went,e.firm,e.time))!=EOF)
	{
		
		XR->IT[i++]=e;
	}
	XR->counter=i;
}
