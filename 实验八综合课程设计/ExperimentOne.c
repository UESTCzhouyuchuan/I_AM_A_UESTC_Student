#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME_SIZE 10			//����������󳤶� 
#define MAX_SPEC_SIZE 10			//����רҵ������󳤶� 
 
struct student{
	char stuName[MAX_NAME_SIZE]; 	//ѧ������ 
	char speciality[MAX_SPEC_SIZE];	//רҵ
	int English;					//Ӣ�� 
	int mathLinear; 				//�ִ�
	int C;							//C����
	int sumGrade;					//�ܳɼ� 
};

/************************************************************ 
*���֣� aveGrade,sumStuNum									*	 
*���ܣ��ֱ��ʾ����רҵƽ���ɼ����Լ�������					* 
*ע��㣺�±�Ϊ0��ʾͨ�ţ�Ϊ1��ʾ���磬Ϊ2��ʾ������		* 
************************************************************/ 
float aveGrade[3]={};
int sumStuNum[3]={};
char* SPE[3]={"ͨ��","����","����"}; 
/**************************************************************************** 
*name:ReadStudentInfo(const char*filename, struct student*pStudents)		* 
*function:filenameΪ��¼ѧ����Ϣ��csv�ļ���������Ϣ���浽����pStudents��	* 
*return:����ֵΪ����ѧ��������ʧ�ܷ���-1									* 
*****************************************************************************/ 
int ReadStudentInfo(const char*filename, struct student**pStudents){
		FILE* fp_source = fopen(filename, "at+");		//���ļ� 
		int count=0;									//��¼�Ѿ������ѧ����Ϣ 
		int i,k,sum;
		char ch;
		char str[50];
		if ( fp_source == NULL){						//�޷����ļ�����-1 
			perror("can't open this file");
			return -1;
		}
		while(fscanf(fp_source, "%s",str) != EOF){
			count++;							//ѭ��һ��õ�ѧ������ 
		}
		*pStudents = (struct student*)malloc(count*sizeof(struct student));	//Ϊѧ�������㹻�ڴ�ռ� 
		if (*pStudents == NULL){
			perror("apply for room fail");
			exit(-1);
		}
		rewind(fp_source);												//�ļ�ָ�붨λ��ͷ��
		for ( i = 0 ; i < count ; i++){									//���ļ� 
			fscanf(fp_source, "%s", str);
			char*temp = strtok(str,",");								//�ַ����ָ�� ,�ٶ�C���Կ⺯��strtok()���� 
			strcpy((*pStudents)[i].stuName, temp);	//copy��ѧ������ 
			temp = strtok(NULL,",");	//�õ�רҵ 
			strcpy((*pStudents)[i].speciality, temp);
			temp = strtok(NULL,",");	//�õ��ɼ� 
			sum=0,k=0;
			while (temp[k]!='\0'){
				sum = sum*10+temp[k++]-'0';	//���ַ���ת��Ϊ���� 
			}
			(*pStudents)[i].English = sum;
			
			temp = strtok(NULL,",");
			sum=0,k=0;
			while (temp[k]!='\0'){
				sum = sum*10+temp[k++]-'0';//�ַ���ת��Ϊ���� 
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
*name:Count(struct student pStudents[], int num),pStudentΪ����ѧ����Ϣ���飬
*		numΪѧ���ܸ���
*function:ͳ������ѧ�����ܳɼ���ÿ��רҵ���ٶ�һ������רҵ��
*			ͨ�ţ����磬����������ƽ���ɼ��������������ѧ����Ϣ�ṹ�����飬
*			ѧ�����������ص�ÿ��ѧ�����ܳɼ�ֱ����䵽��Ӧ������ṹ�������
*			Ӧ�ֶ��С�ͳ����Ϣ��������רҵ����������ƽ���ɼ����飬
*			��ȫ�ֱ�������ʾ 
*return :�޷���ֵ		
****************************************************************************/
void Count(struct student pStudents[], int num){
	int i;
	for ( i = 0 ;i < num ; i++){
		if ( strcmp(pStudents[i].speciality, "ͨ��") == 0){	//��ǰѧ����ͨ��רҵ 
			aveGrade[0]+=pStudents[i].sumGrade;
			sumStuNum[0]++;
		}
		else if ( strcmp(pStudents[i].speciality, "����") == 0){	//��ǰѧ��������רҵ 
			aveGrade[1]+=pStudents[i].sumGrade;
			sumStuNum[1]++;
		}
		else if ( strcmp(pStudents[i].speciality, "����") == 0){	//��ǰѧ��������רҵ 
			aveGrade[2]+=pStudents[i].sumGrade;
			sumStuNum[2]++;
		}
	}
	for ( i =0 ; i < 3 ;i++)
		aveGrade[i]/=sumStuNum[i];	//�ܳɼ������������õ�ƽ���ɼ� 
	
} 
int main(void){
	struct student* pStudents = (struct student*)malloc(sizeof(struct student));	//ΪpStudents����1������ռ� 
	char* filename = "test.txt";							//Ҫ���ļ������� 
	int count = 0 ;													//ѧ�������� 
	int i;
	if ( ( count = ReadStudentInfo(filename, &pStudents) ) == -1){	//����ֵΪ-1����ʾ���ļ�ʧ�� 
		perror("");
	}
	else{
		printf("ѧ����Ϣ��\n");
		printf("____________________________________________________________\n");
		printf("��� �� �� רҵ���� Ӣ��ɼ� ���Դ����ɼ� C�ɼ� �ܳɼ�\n");
		for ( i=0 ; i < count ; i++){
			printf("%3d %5s %6s %8d %10d %9d %5d\n",i,pStudents[i].stuName,pStudents[i].speciality,
					pStudents[i].English,pStudents[i].mathLinear,pStudents[i].C,pStudents[i].sumGrade);	//ѭ��һ��һ����ѧ����Ϣ��� 
		}
		
		Count(pStudents, count);
		printf("ͳ����Ϣ��\n");
		printf("_____________________________________________________________\n");
		printf("��� רҵ���� ѧ������ ƽ���ɼ�\n");
		for ( i =0 ;i<3;i++){
			printf("%3d %6s %6d %10g\n",i,SPE[i],sumStuNum[i],aveGrade[i]);		//������רҵ��Ϣ��� 
		}
	}
	free(pStudents);	//�ͷ��ڴ� 
	getchar();			//�ó�����ͣ��ֱ���û��ڰ����� 
	return 0;			//������� 
}
