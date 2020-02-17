#include<stdio.h>
#include<stdbool.h>
#include<stdlib.h>
#define NUM_ROWS 10
#define NUM_COLS 10

typedef int A4[4];// 
int main(void)
{
	//int (*pointer4e)[4];//等价于以下声明 
	A4 *pointer4e;
	int a[NUM_ROWS][NUM_COLS],i=0;
	int (*p)[NUM_COLS];            //*p是指向a[]的指针 
	for(p = &a[0]; p<&a[NUM_ROWS];p++)//for(p= a; p<a +NUM_ROWS;p++) 
	(*p)[i]=0;
	/*int n,i,*ptr,sum=0;
	ptr=(int*)malloc(n*sizeof(int));
	if(ptr==null)
	{
		printf("Error.");
		exit(EXIT_FAILURE);
	}*/
	while((getchar())!=EOF);//ctrl c
	 
	return 0;
}


 

 