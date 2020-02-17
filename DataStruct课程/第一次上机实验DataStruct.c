
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define MAXNUM 50
typedef struct node{
	char name[20];
	int age;
	char stuID[14];
}ElemType;
typedef struct Node{
	ElemType data;
	struct Node*next;
}ListNode,*ListPtr;
void List_Init(ListPtr L);
void Input(ListPtr L);
void List_SortInsert(ListPtr L,ElemType x);
void List_Destory(ListPtr h);
ListPtr List_Merge(ListPtr La,ListPtr Lb);
void Output(ListPtr La);
void List_Check(ListNode *a, ListNode *b);
void List_Delete(ListPtr L);
int main(void)
{
	ListPtr L=(ListPtr)malloc(sizeof(ListNode)),L1=(ListPtr)malloc(sizeof(ListNode));
	List_Init(L);
	List_Init(L1);
	int time;
	printf("Operation prompt: \nInsert: i\nDelete: D\nPrint: p\nQuit: q\n");
	char operate;
	bool con=true;;
	printf("As for the link L:\n");
	for (;con;){
		printf("Please input operation: ");
		operate=getchar();
		printf("\n");
		while (getchar()!='\n');
		switch(operate){
			case 'q':case 'Q': con=false;break;
			case 'I':case 'i':Input(L);	break;
			case 'D':case 'd':List_Delete(L); break;
			case 'P':case 'p':Output(L);break;
			default : 					break;
		}
	}
	con=true;
	printf("As for the link L1:\n"); 
	for (;con;){
		printf("Please input operation: ");
		operate=getchar();
		printf("\n");
		while (getchar()!='\n');
		switch(operate){
			case 'q':case 'Q': con=false;break;
			case 'I':case 'i':Input(L1);	break;
			case 'D':case 'd':List_Delete(L1); break;
			case 'P':case 'p':Output(L1);break;
			default : 					break;
		}
	}
	List_Check(L, L1);
	ListPtr LL=List_Merge(L,L1);
	printf("After merge L and L1: \n");
	Output(LL);
	return 0;
}
void List_Init(ListPtr L){
	L->next=NULL;
}
void List_Check(ListNode *a, ListNode *b){
	ListPtr la=a,L,p;
	while (la->next!=NULL){
		L=b;
		while(L->next!=NULL)
		{
			if (strcmp(la->next->data.name,L->next->data.name)==0)
			{
				 L->next->data.age=L->next->data.age < la->next->data.age ? L->next->data.age : la->next->data.age;
				 p=la->next;
				 la->next=la->next->next;
				 free(p);
				 break;
			}
			if (L->next!=NULL)
			L=L->next;
		}
		if (la->next!=NULL)
		la=la->next;
	}
}
void Input(ListPtr L){
	ElemType x;
	printf("Enter the & to end.\n");
	do{
	printf("Enter the name: ");
	gets(x.name);
	if (strcmp(x.name,"&")==0)
	{
		return ;
	}
	printf("Enter the age: ");
	scanf("%d",&x.age);
	printf("Enter the student id:");
	scanf("%s",x.stuID);
	while(getchar()!='\n');
	List_SortInsert(L,x);
	}while(1);
}
void List_SortInsert(ListPtr L,ElemType x){
	ListPtr Lp=L;
	for (;Lp->next!=NULL&&Lp->next->data.age < x.age;){
		if (strcmp(Lp->next->data.name,x.name)==0){
			Lp->next->data.age=(L->next->data.age < x.age)? L->next->data.age:x.age;
			return ;
		}
		Lp=Lp->next;
	}
		ListPtr p=(ListPtr)malloc(sizeof(ListNode));
		p->data=x;
		p->next=Lp->next;
		Lp->next=p;
}
void List_Destory(ListPtr h){
	ListPtr L;
	for (;h->next!=NULL;){
		L=h->next;
		free(h);
		h=L;
	}
	free(h);
}
ListPtr List_Merge(ListPtr La,ListPtr Lb){ //二路并归算法 
	ListPtr L=(ListPtr)malloc(sizeof(ListNode)),p,q,Lp;
	Lp=L;
	p=La->next;
	q=Lb->next;
	while(q!=NULL&&p!=NULL){
		if (p->data.age <q->data.age){
			Lp->next=p;
			p=p->next;
			Lp=Lp->next;
		}
		else{
			Lp->next=q;
			q=q->next;
			Lp=Lp->next;
		}
		
	}
	while (p!=NULL){
		Lp->next=p;
		p=p->next;
		Lp=Lp->next;
	}
	while (q!=NULL){
		Lp->next=q;
		q=q->next;
		Lp=Lp->next;
	}
	return L;
}
void List_Delete(ListPtr L){
	char deleteId[14];
	printf("Please enter the id  you delete: ");
	scanf ("%s",deleteId);
	while(getchar()!='\n');
	ListPtr p=L->next,pre=L;
	for (;p!=NULL;){
		if (strcmp(p->data.stuID,deleteId)==0)
		{
			pre->next=p->next;
		}
		pre=p;
		p=p->next;
	}
}
void Output(ListPtr La){
	ListPtr L=La->next;
	printf("姓名	年龄	学号\n"); 
	for (;L!=NULL;)
	{
		printf("%s	%4d	%s\n",L->data.name,L->data.age,L->data.stuID);
		L=L->next;
	} 
}
 
