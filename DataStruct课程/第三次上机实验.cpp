//快速排序和折半查找   by zhou Yuchuan 
#include <bits/stdc++.h>
using namespace std;
#define END 999999
#define Info char
#define MAX 100
typedef struct{
	int key;
	Info data;
}RecType;
void QuickSort(RecType R[],int l,int r);
int  partition(RecType R[],int l,int r);
int  BinarySearch(RecType R[],int l,int r,int data);
int  UpperBound(RecType R[],int l,int r,int data);
int  LowerBound(RecType R[],int l,int r,int data);

void ReadFile(FILE*fp,RecType R[],int *n);
void Disp(RecType R[],int n);


void ChooseFind(RecType R[],int n)
{
	
	printf("\n");
	printf("Three choice and operation prompt:\nBinarySort: B/b\nUpperBound: U/u\nLowerBound: L/l\n");
	printf("Please choose the method of sort: ");
	char ch;
	scanf("%c",&ch);
	printf("\n");
	printf("Enter the number you want to search: ");
	int num;scanf("%d",&num);printf("\n");
	switch(ch)
	{
		case 'B':case 'b':printf("The location of %d is %dth\n",num,BinarySearch(R,0,n,num));break;
		case 'U':case 'u':printf("The location of %d is %dth\n",num,UpperBound(R,0,n,num));break;
		case 'L':case 'l':printf("The location of %d is %dth\n",num,LowerBound(R,0,n,num));break;
		default: printf("Illeagal Input\n");break;
	}
}
int main(void)
{
	FILE*fp;
	if ((fp=fopen("in.txt","r"))==NULL)
	{
		perror("");
		exit(EXIT_FAILURE);
	}
	RecType R[MAX];int n=0;
	memset(R,0,sizeof(R));
	ReadFile(fp,R,&n);fclose(fp);
	printf("Before sort: ");Disp(R,n);
	QuickSort(R,0,n);printf("After  sort: ");Disp(R,n);
	ChooseFind(R,n);
	return 0;
}

void QuickSort(RecType R[],int l,int r)
{
	int i;
	if (l<r-1)
	{
		i=partition(R,l,r);
		QuickSort(R,l,i);
		QuickSort(R,i,r);
	}
}
int partition(RecType R[],int l,int r)
{
	int i=l,j=r-1;
	RecType tmp=R[i];
	while (i<j)
	{
		while (i<j&&R[j].key>=tmp.key)
		j--;
		R[i]=R[j];
		while (i<j&&R[i].key<=tmp.key)
		i++;
		R[j]=R[i];
	}
	R[i]=tmp;
	return i+1;
}
int  BinarySearch(RecType R[],int l,int r,int data)
{
		int mid;
	while (l<r)
	{
		mid=(l+r)/2;
		if (data==R[mid].key) return mid+1;
		else if (R[mid].key>data)
				r=mid;
		else
				l=mid+1;
	}
	printf("NOT Find!\n");
	exit(EXIT_FAILURE);
}
int  UpperBound(RecType R[],int l,int r,int data)
{
	int mid;
	while (l<r)
	{
		mid=(l+r)/2;
		if (R[mid].key<=data)
			l=mid+1;
		else r=mid;
	}
	if (R[l-1].key!=data)
	{
	printf("NOT Find!\n");
	exit(EXIT_FAILURE);
	}
	return l;
}
int  LowerBound(RecType R[],int l,int r,int data)
{
	int mid;
	while (l<r)
	{
		mid=(l+r)/2;
		if (R[mid].key>=data)
			r=mid;
		else l=mid+1;
	}
	if (R[l].key!=data)
	{
		printf("NOT Find!\n");
  		exit(EXIT_FAILURE);
	}
	return l+1;
}

void ReadFile(FILE*fp,RecType R[],int*n)
{
	int i=0;
	int num;
	while (fscanf(fp,"%d",&num)!=EOF){
		R[i++].key=num;
		(*n)++;
	}
	R[i].key=END;	
}
void Disp(RecType R[],int n)
{
	int i;
	for (i=0;i<n;i++)
	{
		printf("%d%c",R[i].key,i==n-1?'\t':' ');
	}
	printf("The sum of number is %d\n",n);
}
