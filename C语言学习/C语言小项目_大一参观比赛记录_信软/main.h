/******************************************* 
*��������Ϊ�˼�¼�����һ�����ι���ҵ���  *
*��ȫ���ڱ�����Ȥ�����κ�ӯ����ͼ          * 
* �ð汾ֻ��¼ѧ��ѧ�ţ��������Ƿ�ι���ҵ,*
*�ι���ҵ���ι�ʱ��                        * 
* ѧԺ����201722                           *
* author : UESTC Zhou YuChuan 2017221302006* 
*************************************/ 

#pragma once

#define MAXV 800

typedef struct {
	char IDnum[15];
	char name[10];
	bool went;
	char firm[20];
	char time[15];
}student;
typedef struct{
	student IT[MAXV];
	int counter;
}Student;



/*****************
*��дexcel�ļ�   *
*****************/

void WriteExcel(FILE*fp,Student*XR);
void ReadExcel (FILE*fp,Student*XR); 
/********************
*�µ�ѧԱ�Ĳ���     * 
********************/ 
void Sort(Student IT[]);
void Union(Student IT1[],Student IT2[]);


void Disp(Student *XR);
