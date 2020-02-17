#include<stdio.h>
#define MAX 10
#include<stdlib.h> 
#include<conio.h>
int*choose(int*,int);
int main(void){
	int i,j,k,t;
	int num[MAX];
	system("cls");//clrscr;
	printf("Input %d number: \n",MAX);
	for(i =0 ;i<MAX;i++)
	{
		printf("number[%d]=\n",i);
		scanf("%d",num+i);
	}
	for(i =0;i<MAX;i++)
	{
		k =i;
		for(j = i+1 ;j<MAX;j++)
		  if(num[j]<num[k])k=j;
		  if(k!=i){
  			t=num[i];
  			num[i]=num[k];
  			num[k]=t;
  		}
	} 
	for(i=0;i<MAX;i++)
	{
		printf("%4d\n",num[i]); 
	}
	return 0;
}