/******************************************* 
*本程序是为了记录信软大一新生参观企业情况  *
*完全出于本人兴趣，无任何盈利意图          * 
* 该版本只记录学生学号，姓名，是否参观企业,*
*参观企业，参观时间                        * 
* 学院代码201722                           *
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
*读写excel文件   *
*****************/

void WriteExcel(FILE*fp,Student*XR);
void ReadExcel (FILE*fp,Student*XR); 
/********************
*新的学员的插入     * 
********************/ 
void Sort(Student IT[]);
void Union(Student IT1[],Student IT2[]);


void Disp(Student *XR);
