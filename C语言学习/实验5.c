//finished by zhouyuchuan --2017.12.27
#include<stdio.h>
#include<stdlib.h>
#define NAME_LEN 10
#define MAX_GOODS 100
struct part{
	int number;
	char name[NAME_LEN+1];
	int on_hand;
} *Good[MAX_GOODS];
int counter=0;
void read_information(void);
void goods_change_information(void);
void goods_delete(void);
void goods_search(void);
void goods_insert(void);
void goods_exhibition(void);
int goods_quit(void);
void goods_save(void); 
int main(void){
	read_information();
	char operate;
	fprintf(stdout,"the code of operations:\nc: change_information\n"
	"d: delete\ns: search\ni: insert\nq: quit\ne: exhibition\n");
	for(;;){
		printf("Enter the operation code: ");
		scanf(" %c",&operate);
		while((getchar())!='\n');
	switch(operate){
		case 'C':case 'c':goods_change_information();break;
		case 'E':case 'e':goods_exhibition();break;
		case 'D':case 'd':goods_delete();break;
		case 'S':case 's':goods_search();break;
		case 'I':case 'i':goods_insert();break;
		case 'Q':case 'q':goods_quit();break;
		default:          printf("You enter error direction!\n"
		                          "Please enter agagin following the message\n");
                          break;
	             }
	}
	return 0;
}
void read_information(void){
	FILE*fp;
	if((fp=fopen("C:/Users/������/Desktop/code2/goods_information.txt","rb+"))==NULL)
	read_information();
	fscanf(fp,"%d",&counter);
	printf("%d\n",counter);
	fclose(fp);
	return;
}
void goods_change_information(void){
	int num;
	int i;
	printf("Enter the number of this goods that you want to change: ");
	fscanf(stdin," %d",&num);
	for(i=0;i<counter;i++){
		if(num==Good[i]->number){
			printf("Enter this new name and new on_hand: ");
			scanf(" %s %d",Good[i]->name,&Good[i]->on_hand);
			printf("Change successfully\n");
			return ;
		}
	
			printf("I am sorry.Not found!\n");
			return;
}
} 
void goods_exhibition(void){
	int i;
    printf("Number	Name	On_hand\n");
	for(i=0;i<counter;i++){
		printf("%d	%s	%d\n",Good[i]->number,Good[i]->name,Good[i]->on_hand);
	}
	return;
}
void goods_delete(void){
	int num;
	printf("Enter the number of the goods you want to desert: ");
	scanf(" %d",&num);
	puts("\n"); 
	int i,j;
	for(j=0;j<counter;j++){
		if(num==Good[j]->number){
		for(i=j;i<counter-1;i++)
		Good[i]=Good[i+1];
		counter--;
		break;
	}
	}
	return;
}
void goods_search(void){
	int num;
	int i;
	printf("Enter the number of this goods that you want to search: ");
	scanf(" %d",&num);
	for(i=0;i<counter;i++){
		if(num==Good[i]->number){
			printf("\nNumber	Name	On_hand\n");
			printf("%d	%s	%d\n",Good[i]->number,Good[i]->name,Good[i]->on_hand);
			return ;
		}
	}
	printf("Not found\n");
	return;
}
void goods_insert(void){
	struct part*meno_p;
	int i,j;
		meno_p=(struct part*)malloc(sizeof(struct part));
		if(meno_p==NULL)
		return;
		if(counter>MAX_GOODS){
			printf("NO--space-left");
			return;
		}
		printf("Enter its number,name and on_hand: ");
		scanf(" %d %s %d",&meno_p->number,meno_p->name,&meno_p->on_hand);
	
		for( i=0;i < counter;i++){
		 if(Good[i]->number>=meno_p->number)
	 	 break;}
			for(j =counter;j>i;j--){
				Good[j]=Good[j-1];
			}
			Good[i]=meno_p;
			counter++;
	//}while(1);
}
int goods_quit(void){
	goods_save();
	exit(EXIT_SUCCESS);
}
void goods_save(void){
	
	return;
}


/* �� C ����ʵ��һ��С�͵ĳ�����Ʒ����ϵͳ����ϵͳ��Ҫ�߱���Ʒ��Ϣ¼�롢��Ʒ��Ϣ�޸ġ�
��Ʒ��Ϣɾ������Ʒ��Ϣ���ҡ���Ʒ��Ϣ�Ĳ����⼸�����ܡ�����ʵ�ֲ������£�
1) ���������ƣ�ʵ��һ������ѡ��ʽ���������棬���а�������Ʒ��Ϣ�޸�
����Ʒ��Ϣɾ������Ʒ��Ϣ���ҡ��˳�ϵͳ������ 5��ѡ�������Щ���ܿ�
��ѭ�����á�
2) ��Ʒ��Ϣ�ĳ�ʼ��������һ����Ʒ��Ϣ�Ľṹ�壬��������һ��ָ����
�飬�����е�����Ϊָ��ṹ���ָ�롣ʵ��һ�������������е���Ʒ��Ϣ��
�ж�����Ʒ��Ϣ�����ҷ����ڴ汣����ָ�������С�
3) ��Ʒ��Ϣ���޸ģ�ʵ��һ�����������Ʒ��Ϣ���޸Ĺ��ܣ�ʵ�ֿ��Ը�����Ʒ������

�޸���Ʒ��Ϣ���������ַ����Ƚϵķ�ʽ�����Ҵ��޸���Ʒ��
4) ��Ʒ��Ϣ��ɾ����ʵ��һ��������ʵ�ָ�����Ʒ��������ɾ����Ӧ����Ʒ
��Ϣ�Ĺ��ܣ���Ʒ����ͨ���ַ����Ƚϵķ�ʽ�����ҵ����ͷŶ�Ӧָ��ָ���
�ڴ��������ɾ����
5) ��Ʒ��Ϣ�Ĳ��ң�ʵ��һ�������������Ĺ����Ǹ����������Ʒ��������
�Ҷ�Ӧ����Ʒ��Ϣ����Ʒ���Ƶ��ж����ַ����Ƚϵķ�ʽ��ʵ�֣�Ȼ����ø�
ʽ������Ӻ�����ʾ���ҵ�����Ʒ��Ϣ��
6) �˳�ϵͳ�������棺ʵ��һ���ļ�д�뺯����������Ϣ�ĸĶ�д�뵽��Ʒ
��Ϣ�ļ���Ȼ������ϵͳ���й������ѷ�����ڴ档*/
