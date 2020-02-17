#include <bits/stdc++.h>
#include "main.h"
using namespace std;

void Disp(Student *XR)
{
	int i=0;
    fprintf(stdout,"%s\t\t%s\t%s  %s\t%s\n","学号","姓名","是否参观","参观公司", "参观时间");
	for (;i< XR->counter&&i<MAXV;i++)
	fprintf(stdout,"%-15s%-10s%-10d%-10s%-10s\n",XR->IT[i].IDnum,XR->IT[i].name,XR->IT[i].went,XR->IT[i].firm,XR->IT[i].time);
}
