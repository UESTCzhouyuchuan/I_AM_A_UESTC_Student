#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME_SIZE 10			//定义姓名最大长度 
#define MAX_SPEC_SIZE 10			//定义专业名字最大长度 
 
struct student{
	char stuName[MAX_NAME_SIZE]; 	//学生姓名 
	char speciality[MAX_SPEC_SIZE];	//专业
	int English;					//英语 
	int mathLinear; 				//现代
	int C;							//C语言
	int sumGrade;					//总成绩 
};

/************************************************************ 
*名字： aveGrade,sumStuNum									*	 
*功能：分别表示三个专业平均成绩，以及总人数					* 
*注意点：下标为0表示通信，为1表示网络，为2表示互联网		* 
************************************************************/ 
float aveGrade[3]={};
int sumStuNum[3]={};
char* SPE[3]={"通信","网络","物联"}; 
/**************************************************************************** 
*name:ReadStudentInfo(const char*filename, struct student*pStudents)		* 
*function:filename为记录学生信息的csv文件，读入信息保存到数组pStudents中	* 
*return:返回值为读入学生个数，失败返回-1									* 
*****************************************************************************/ 
int ReadStudentInfo(const char*filename, struct student**pStudents){
		FILE* fp_source = fopen(filename, "at+");		//打开文件 
		int count=0;									//记录已经读入的学生信息 
		int i,k,sum;
		char ch;
		char str[50];
		if ( fp_source == NULL){						//无法打开文件返回-1 
			perror("can't open this file");
			return -1;
		}
		while(fscanf(fp_source, "%s",str) != EOF){
			count++;							//循环一遍得到学生个数 
		}
		*pStudents = (struct student*)malloc(count*sizeof(struct student));	//为学生申请足够内存空间 
		if (*pStudents == NULL){
			perror("apply for room fail");
			exit(-1);
		}
		rewind(fp_source);												//文件指针定位到头部
		for ( i = 0 ; i < count ; i++){									//读文件 
			fscanf(fp_source, "%s", str);
			char*temp = strtok(str,",");								//字符串分割函数 ,百度C语言库函数strtok()函数 
			strcpy((*pStudents)[i].stuName, temp);	//copy到学生姓名 
			temp = strtok(NULL,",");	//得到专业 
			strcpy((*pStudents)[i].speciality, temp);
			temp = strtok(NULL,",");	//得到成绩 
			sum=0,k=0;
			while (temp[k]!='\0'){
				sum = sum*10+temp[k++]-'0';	//把字符串转化为数字 
			}
			(*pStudents)[i].English = sum;
			
			temp = strtok(NULL,",");
			sum=0,k=0;
			while (temp[k]!='\0'){
				sum = sum*10+temp[k++]-'0';//字符串转化为数字 
			}
			(*pStudents)[i].mathLinear = sum;
			
			temp = strtok(NULL,",");
			sum=0,k=0;
			while (temp[k]!='\0'){
				sum = sum*10+temp[k++]-'0';
			}
			(*pStudents)[i].C = sum;
			
			(*pStudents)[i].sumGrade = (*pStudents)[i].English +(*pStudents)[i].mathLinear + (*pStudents)[i].C;
		}
		fclose(fp_source);
		return count;
}

/***************************************************************************
*name:Count(struct student pStudents[], int num),pStudent为保存学生信息数组，
*		num为学生总个数
*function:统计所有学生的总成绩和每个专业（假定一共三个专业：
*			通信，网络，物联网）的平均成绩；输入参数包括学生信息结构体数组，
*			学生人数，返回的每个学生的总成绩直接填充到对应的输入结构体数组对
*			应字段中。统计信息包括三个专业的总人数、平均成绩数组，
*			用全局变量来表示 
*return :无返回值		
****************************************************************************/
void Count(struct student pStudents[], int num){
	int i;
	for ( i = 0 ;i < num ; i++){
		if ( strcmp(pStudents[i].speciality, "通信") == 0){	//当前学生是通信专业 
			aveGrade[0]+=pStudents[i].sumGrade;
			sumStuNum[0]++;
		}
		else if ( strcmp(pStudents[i].speciality, "网络") == 0){	//当前学生是网络专业 
			aveGrade[1]+=pStudents[i].sumGrade;
			sumStuNum[1]++;
		}
		else if ( strcmp(pStudents[i].speciality, "物联") == 0){	//当前学生是物联专业 
			aveGrade[2]+=pStudents[i].sumGrade;
			sumStuNum[2]++;
		}
	}
	for ( i =0 ; i < 3 ;i++)
		aveGrade[i]/=sumStuNum[i];	//总成绩处以总人数得到平均成绩 
	
} 
int main(void){
	struct student* pStudents = (struct student*)malloc(sizeof(struct student));	//为pStudents分配1个储存空间 
	char* filename = "test.txt";							//要打开文件的名字 
	int count = 0 ;													//学生总人数 
	int i;
	if ( ( count = ReadStudentInfo(filename, &pStudents) ) == -1){	//返回值为-1，表示打开文件失败 
		perror("");
	}
	else{
		printf("学生信息：\n");
		printf("____________________________________________________________\n");
		printf("序号 姓 名 专业名称 英语成绩 线性代数成绩 C成绩 总成绩\n");
		for ( i=0 ; i < count ; i++){
			printf("%3d %5s %6s %8d %10d %9d %5d\n",i,pStudents[i].stuName,pStudents[i].speciality,
					pStudents[i].English,pStudents[i].mathLinear,pStudents[i].C,pStudents[i].sumGrade);	//循环一个一个把学生信息输出 
		}
		
		Count(pStudents, count);
		printf("统计信息：\n");
		printf("_____________________________________________________________\n");
		printf("序号 专业名称 学生人数 平均成绩\n");
		for ( i =0 ;i<3;i++){
			printf("%3d %6s %6d %10g\n",i,SPE[i],sumStuNum[i],aveGrade[i]);		//把三个专业信息输出 
		}
	}
	free(pStudents);	//释放内存 
	getchar();			//让程序暂停，直到用户在按键盘 
	return 0;			//程序结束 
}
