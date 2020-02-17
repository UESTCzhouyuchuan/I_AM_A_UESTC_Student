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
	if((fp=fopen("C:/Users/鑫鑫玉川/Desktop/code2/goods_information.txt","rb+"))==NULL)
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


/* 用 C 语言实现一个小型的超市商品管理系统，该系统需要具备商品信息录入、商品信息修改、
商品信息删除、商品信息查找、商品信息的插入这几个功能。具体实现步骤如下：
1) 软件界面控制：实现一个数字选项式的启动界面，其中包含、商品信息修改
、商品信息删除、商品信息查找、退出系统并保存 5个选项。并且这些功能可
以循环调用。
2) 商品信息的初始化：定义一个商品信息的结构体，并且声明一个指针数
组，数组中的内容为指向结构体的指针。实现一个函数，从已有的商品信息文
中读入商品信息，并且分配内存保存至指针数组中。
3) 商品信息的修改：实现一个函数完成商品信息的修改功能，实现可以根据商品的名称

修改商品信息。其中用字符串比较的方式来查找待修改商品。
4) 商品信息的删除：实现一个函数，实现根据商品的名称来删除对应的商品
信息的功能，商品查找通过字符串比较的方式，查找到后释放对应指针指向的
内存区域，完成删除。
5) 商品信息的查找：实现一个函数，函数的功能是根据输入的商品名称来查
找对应的商品信息，商品名称的判断用字符串比较的方式来实现，然后调用格
式化输出子函数显示查找到的商品信息。
6) 退出系统，并保存：实现一个文件写入函数将所有信息的改动写入到商品
信息文件，然后清理系统运行过程中已分配的内存。*/
