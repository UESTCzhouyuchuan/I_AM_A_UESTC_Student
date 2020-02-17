#include<stdio.h>
#define MAX 100
int main(void)
{
	int i=0,t,j;
	char ch[MAX];
	for(i=0;(ch[i]=getchar())!='.';i++);
	if(i==0)
	return 0;
	else{
	   int t1=0,t2=0;
	   do{
   		while(ch[t1]==' ')
   		t1++;
   		t2=t1;
   		while(ch[t2]!=' '&&ch[t2]!='.')
   		t2++;
   		if(ch[t2]=='.'){
		   	printf("%d",t2-t1);
		   	break;
		   }
		   else
		   printf("%d ",t2-t1);//It's great to see you here.

		   t1=t2;
   	   }while(1);	
	}
	return 0;
}