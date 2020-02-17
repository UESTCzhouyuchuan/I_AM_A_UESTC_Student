/*
 * digit.c
 *
 *  Created on: 20181127
 *      Author: ZhouYuchuan 
 */


#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "digit.h"

numTableItem constant_table[MAX_TAB_SIZE];	//������ 
int constant_size = 0;						//��������� 

char reserve_table[MAX_TAB_SIZE][10];		//�����ֱ� 
int reserve_size = 0;						//�����ָ��� 

int line = 1;	//��ʼ��Ϊ��һ�� 
int num = 1;	// ��ʶ���ֱ�� 
int change_line = 1;

/*****************************************************************************
* �������ƣ� getnbc
* ���������� ���ļ��ж����ַ����������Ƿ�Ϊ�հ��ַ������ǣ��������һ���ַ���ֱ������
*			�ǿհ��ַ�Ϊֹ
******************************************************************************/
char getnbc(FILE *fp1)	//fp1Դ�ļ��� 
{
	char ch = fgetc(fp1);
	while (ch == ' ' || ch == '\t') ch = fgetc(fp1);	//�Թ��ո���Ʊ��
	return ch;	//���ط��� 
}

/*****************************************************************************
* �������ƣ� concat
* ���������� ��character���ӵ�token�����ĩβ��Ȼ���ٲ���'\0'�����޸�token�ĳ���
******************************************************************************/
void concat(char character, char token[], int *n)
{
	token[*n] = character;	//��character��ӵ�token�� 
	(*n)++;					//token������һ 
	token[*n] = '\0';		//�ַ������� 
}

/*****************************************************************************
* �������ƣ� symbol
* ���������� ����token���ͣ��Ƿ�Ϊ��ʶ�����߹ؼ��� 
******************************************************************************/
int symbol(char token[])
{
	int i; 
	for (i = 0 ; i < reserve_size ; i++){	//�ڱ����ֱ�������Ƚϣ��Ƿ�Ϊ������ 
		if(strcmp(reserve_table[i],token)==0)		
		return i+3;							//���ر��������ͣ���������������������м�����ϵ 
	}
	return T_SYMBOL;								//�����Ǳ����֣����ر�ʶ������ 
}
/*****************************************************************************
* �������ƣ� digit
* ���������� �ж��Ƿ������֣������򷵻�1�����򷵻�0
******************************************************************************/
int digit(char character)
{
	return (character >= '0' && character <= '9');
}

/*****************************************************************************
* �������ƣ� retract
* ���������� �����ַ������Ƿǿհ��ַ������ַ�������back�У����ǿհ��ַ���������
******************************************************************************/
int retract(char character, char *back)
{
	if (character != ' ') {
		*back = character;
		return 1;
	}
	return 0;
}

/*****************************************************************************
* �������ƣ� constant
* ���������� ��token�е��ַ����鳣�������鵽�����ظó�������ţ������µĳ�������
���У��ٷ������
******************************************************************************/
int constant(char token[], int n)
{
	int i, j, b;
	int dec, rem, tmp;
	int stack[MAX_BIT];//ջ
	int top = 0;

	// ת����ʮ������
	for (i = 0, dec = 0; i < n; i++) {
		dec = dec * 10 + (token[i] - '0');
	}

	// ת���ɶ����������������ջ�У���λ����ջ��
	rem = dec;
	if (dec == 0) stack[top++] = 0;	//��0����������
	while (rem > 0) {
		stack[top++] = rem % 2;
		rem = rem / 2;
	}

	tmp = top;	//�ݴ�ջ��ָ�룬�������������λ��
	for (i = 0; i < constant_size; i++) {
		b = constant_table[i].bit;	//ȡ����������λ��
		if (top != b) continue;		//λ������ȣ�ֱ����������

		for (j = 0; j < b; j++) {	//��λ�Ƚ�
			if (stack[--top] != constant_table[i].binary[j]) break;
		}
		if (j >= b) return i;	//�ҵ���ͬ������ֱ�ӷ��ظ����ڱ��е�λ��
		top = tmp;	//��ԭtop
	}

	// ���û���ҵ���ͬ�������ͽ�����¼�����
	i = constant_size++;
	constant_table[i].binary = (int *)malloc((top + 1)* sizeof(int));//��̬�����ڴ� 
	constant_table[i].bit = top;	//bit�洢�ö���������λ��
	for (j = 0; top > 0; j++) {
		constant_table[i].binary[j] = stack[--top];   //˳��洢��������
	}
	return i;
}

/*****************************************************************************
* �������ƣ� error1
* ���������� ��ӡ�������Ϣ
******************************************************************************/
void error1(FILE *fp4, char character, int line)
{
	printf("\nerror: line %.2d: ���зǷ��ַ�:\t%c\n\n", line, character);	//��ӡ��Ļ�� 
	fprintf(fp4, "error: line %.2d: ���зǷ��ַ�:\t%c \n", line, character);//��ӡerror�ļ��� 
}

/*****************************************************************************
* �������ƣ� analyze
* ���������� ���ʷ�����������ÿ����һ�λ�ȡһ�����ʣ������ӡ����Ļ��������ı�
******************************************************************************/
int analyze(FILE *fp1, FILE *fp2, FILE *fp3, FILE *fp4, int *back_flag, char *back)
{			//fp1Ϊ����Դ�ļ���fp2Ϊ����ļ���fp3Ϊ���ű��ļ���fp4Ϊ��������ļ� 
	char character;
	char token[24]={'\0'};
	int  n = 0;		//n��¼token�е��ַ�������
	int  type = 0;		//��������
	int  val = 0;		//�������ԣ�ֻ�б�ʶ���ͳ�������0

	if (*back_flag) {	//��һ���л��ˣ���ʹ����һ�ε��ַ��������ȡ�ļ�����һ���ַ� 
		character = *back;
		*back_flag = 0;
	}
	else character = getnbc(fp1);
	
	
	if (digit(character)) {	//��һ�����ǳ���
		while (digit(character)) {//��һ������Ҳ�ǳ��� 
			concat(character, token, &n);//��ӵ�token������ 
			character = fgetc(fp1);
		}
		val = constant(token, n);//�ڳ�������λ�� 
		type = T_CONSTANT;//�����ǳ��� 
		*back_flag = retract(character, back);//�Ƿ��л��� 
	}
	else if(isalpha(character)||character == '_')//����ĸ�£�������� ,�����Ǳ����֣���ʶ�� 
	{
		while(isalpha(character)||digit(character)||character == '_')//����ĸ���»��ߣ�������� ,�����Ǳ����֣���ʶ�� 
		{
			concat(character, token, &n);	//��ӵ�token������ 
			character = fgetc(fp1);
		}
		type = symbol(token);			//�����ַ������� 
		*back_flag = retract(character, back);	//�жϻ��� 
	}
	else {
		switch (character) {
		case '+':	type = T_ADD;	concat(character, token, &n);	break;//Ϊ�Ӻ� 
		case '-':	type = T_SUB;	concat(character, token, &n);	break;//Ϊ���� 
		case '*':	type = T_MUL;	concat(character, token, &n);	break;//Ϊ�˺� 
		case '%':	type = T_MOD;	concat(character, token, &n);	break;//Ϊ��ģ�� 
		case '/':	//�����жϣ�Ϊ���ţ�����ע�Ϳ�ʼ���� 
					character = fgetc(fp1);		//��һ������ 
					if ( character == '/' ){	//Ϊע�ͷ��� "//" 
						while( (character = fgetc(fp1)) != '\n');//���з��ź��� 
						line++;								//������һ 
						return 0;							//���� 
					}
					else if (character == '*'){//Ϊע�ͷ��� "/*"
						char ch;				//Э���ж�ע�ͽ����� "*/" 
						character = fgetc(fp1); //����һ���ַ� 
						if ( character == '\n')
								line++; 	//������һ 
						while (1){
							ch = fgetc(fp2); //��Դ�ļ�
							if ( ch == '\n')
								line++; 	//������һ 
							if ( ( character ) == '*' && ( ch == '/' )) //���������� 
								break;
							else{
								character = ch ;
							} 
						}
						return 0;
					}
					else
					{
						*back_flag = retract(character, back);
						type = T_DIV;	concat('/', token, &n);//Ϊ���� 
					}
					break;
		
		case '<':	type = T_L;	    concat(character, token, &n);//������ΪС�ڷ��� 
				character = fgetc(fp1); 
				if (character == '='){
					type = T_LE;    concat(character, token, &n);} 
				else{
					*back_flag = retract(character, back);			//�������һ���ַ� 
				}			
				break;
		case '>':	type = T_G;  	concat(character, token, &n); // ������Ϊ���ڷ��� 
				character = fgetc(fp1); 
				if (character == '='){
					type = T_GE;    concat(character, token, &n);}//������Ϊ�Ⱥ� ��Ϊ���ڵ��ں� 
				else{
					*back_flag = retract(character, back);	//�������һ���ַ� 
				}	
				break;
		case '=':	type = T_ASSIGN;concat(character, token, &n);//�ȼ�Ϊ��ֵ���� 
				character = fgetc(fp1);
				if (character == '='){							//����һ���ַ�Ϊ�Ⱥţ���Ϊ�Ⱥ� 
					type = T_EQ;    concat(character, token, &n);}
				else{
					*back_flag = retract(character, back);		//�������һ���ַ� 
				}
				break;
		case '!':  type = T_N;concat(character, token, &n); //�ȼ�Ϊ�� 
				character = fgetc(fp1); 
				if (character == '='){						//��һ���ַ�Ϊ�Ⱥţ����Ϊ������ 
					type = T_NE;    concat(character, token, &n);}
				else{
					*back_flag = retract(character, back);	//�������һ���ַ� 
				}		
				break;
		case '&': 	concat(character, token, &n);
				character = fgetc(fp1);						
				if (character == '&'){						//��λ����&����Ϊ�߼��� 
					type = T_AND;concat(character, token, &n);
				}	
				else {										//�����Ϊ������� 
					error1(fp4,'&',line);
					*back_flag = retract(character, back);//����һ���ַ� 
				}
				break;	
		case '|': 	concat(character, token, &n);
				character = fgetc(fp1);
				if (character == '|'){					//����|���ż�Ϊ�߼��� 
					type = T_AND;concat(character, token, &n);
				}	
				else {
					error1(fp4,*token,line);				//�����Ϊ�Ƿ��ַ� 
					*back_flag = retract(character, back);			//����һ���ַ� 
				}
				break;
		case '\\':	concat(character, token, &n);
				character = fgetc(fp1);
				if ( character == 'n'){						//����������Ϊ'/n' 
					type = T_EOLN;concat(character, token, &n);
					change_line = 0;
				}
				else {
					error1(fp4,*token,line);					//�����Ϊ�Ƿ��ַ� 
					*back_flag = retract(character, back);			//����һ���ַ� 
				}	
				break;	
		case '(':	type = T_LPAR;	concat(character, token, &n);	break;
		case ')':	type = T_RPAR;	concat(character, token, &n);	break;
		case '[':	type = T_LMPAR;	concat(character, token, &n);	break;
		case ']':	type = T_RMPAR;	concat(character, token, &n);	break;
		case '{':	type = T_LBPAR;	concat(character, token, &n);	break;
		case '}':	type = T_RBPAR;	concat(character, token, &n);	break;
		case ',':   type = T_COM;   concat(character, token, &n);   break;
		case ':':   type = T_COLON; concat(character, token, &n);   break; 
		case ';':	type = T_SEM;	concat(character, token, &n);	break;
		case '.':   type = T_POINT; concat(character, token, &n);	break;
		case'\'':   type = T_SINGQU;concat(character, token, &n);	break;
		case'\"':	type = T_DOUBQU;concat(character, token, &n);	break; 
		case EOF:	type = T_EOF;	concat('#', token, &n);	        break;
		case'\n':	type = T_EOLN;	change_line = 1 ;
									concat(character, token, &n);	break;
		case '#':	type = T_WELL;  concat(character, token, &n);	break;
		default:	error1(fp4, character, line);
		//return -1;
		}
	} 
	// ����Ļ�ϴ�ӡ��������ı�
	if ( type >= 3 && type < reserve_size+3){
		printf("line %.2d: ������  %s\n", line, token);
		fprintf(fp2, "line %.2d: ������  %s\n", line, token);
	} 
	else if ( type >= T_ADD && type <= T_MOD){
		printf("line %.2d: �����  %s\n", line, token);
		fprintf(fp2, "line %.2d: �����  %s\n", line, token);
	}
	else {
		switch ( type ){
			case T_SYMBOL:
				printf("line %.2d: ��ʶ��  %s\n", line, token);
				fprintf(fp2,"line %.2d ��ʶ��  %s\n", line,token);
				fprintf(fp3, "%d\t%d\t%s\n", num++,line, token);
				break;
			case T_CONSTANT:
				printf("line %.2d: CONSTANT %s\n", line, token);
				fprintf(fp2, "line %.2d: CONSTANT %s\n", line,token);
				break;
			case T_LPAR:
				printf("line %.2d: ������  %s\n", line, token);
				fprintf(fp2, "line %.2d: ������  %s\n", line, token);
				break;
			case T_RPAR:
				printf("line %.2d: ������  %s\n", line, token);
				fprintf(fp2, "line %.2d: ������  %s\n", line, token);
				break;
			case T_LMPAR:
				printf("line %.2d: �������� %s\n", line, token);
				fprintf(fp2, "line %.2d: �������� %s\n", line, token);
				break;
			case T_RMPAR:
				printf("line %.2d: �������� %s\n", line, token);
				fprintf(fp2, "line %.2d: �������� %s\n", line, token);
				break;
			case T_LBPAR:
				printf("line %.2d: ������� %s\n", line, token);
				fprintf(fp2, "line %.2d: ������� %s\n", line, token);
				break;
			case T_RBPAR:
				printf("line %.2d: �Ҵ����� %s\n", line, token);
				fprintf(fp2, "line %.2d: �Ҵ����� %s\n", line, token);
				break;
			case T_ASSIGN:
				printf("line %.2d: �Ⱥ�    %s\n", line, token);
				fprintf(fp2, "line %.2d: �Ⱥ�    %s\n", line, token);
				break;
			case T_COM:
				printf("line %.2d: ����    %s\n", line, token);
				fprintf(fp2, "line %.2d: ����    %s\n", line, token);
				break;
			case T_COLON:
				printf("line %.2d: ð��    %s\n", line, token);
				fprintf(fp2, "line %.2d: ð��    %s\n", line, token);
				break;
			case T_SEM:
				printf("line %.2d: �ֺ�    %s\n", line, token);
				fprintf(fp2, "line %.2d: �ֺ�    %s\n", line, token);
				break;
			case T_POINT:
				printf("line %.2d: ��      %s\n", line, token);
				fprintf(fp2, "line %.2d: ��       %s\n", line, token);
				break;
			case T_SINGQU:
				printf("line %.2d: ������  %s\n", line, token);
				fprintf(fp2, "line %.2d: ������  %s\n", line, token);
				break;
			case T_DOUBQU:
				printf("line %.2d: ˫����  %s\n", line, token);
				fprintf(fp2, "line %.2d: ˫����  %s\n", line, token);
				break;
			case T_EOF:
				printf("line %.2d: ��β��  %s\n", line, token);
				fprintf(fp2, "line %.2d: ��β��  %s\n", line, token);
				break;
			case T_WELL:
				printf("line %.2d: ����    %s\n", line, token);
				fprintf(fp2, "line %.2d: ����    %s\n", line, token);
				break;
			case T_EOLN:
				printf("line %.2d: ��β��  %s\n", line, token);
				fprintf(fp2, "line %.2d: ��β��  %s\n", line, token);
				if (change_line)//���������з��ͻ��У�������һ����'\n'�Ͳ����� 
				line++;
				break;
			default: break;
		}
	}
	return type;	//�������� 
}

int main(void)
{
	char *soure = "leapyear.txt";
	char *output = "lex.txt";
	char *error = "error.txt";
	char *symtable = "symtable.txt";
	char *reserve = "reserve.txt";
	
	FILE *fp_src = fopen(soure, "r");
	if (fp_src == NULL) {
		printf("��Դ�ļ�ʧ�ܣ���ȷ��Դ�ļ���λ�ã�\n");
		return -1;
	}
	//�ӱ������ļ��ж�ȡ������ 
	FILE *fp_res = fopen(reserve, "r");
	if (fp_res == NULL) {
		printf("�򿪱������ļ�ʧ�ܣ���ȷ��Դ�ļ���λ�ã�\n");
		return -1;
	}
	else{
		char ch[20];
		fscanf (fp_res, "%s", ch);
		while ( strchr(ch, '#') == NULL)
		fscanf (fp_res, "%s", ch);
		
		while (fscanf (fp_res, "%s", ch) != EOF)
		{
			strcpy(reserve_table[reserve_size], ch);
			reserve_size++;
		}
	} 

	FILE *fp_output = fopen(output, "w");
	FILE *fp_err = fopen(error, "w");
	FILE *fp_sym = fopen(symtable,"w");

	int back_flag = 0;	//���˵ı�ǣ�1������һ���л���(�ո���)��0����û��
	char back;			//�����һ�εĻ���ֵ

	printf("����-2017221302006\n\n");
	fprintf(fp_output, "����-2017221302006\n\n");
	fprintf(fp_sym, "���ű�\n���\t�к�\t����\n");
	
	while (analyze(fp_src, fp_output, fp_sym, fp_err, &back_flag, &back) != T_EOF);//��������Ϊ�ļ�����������ѭ�� 

	fclose(fp_src);
	fclose(fp_output); 
	fclose(fp_sym);
	fclose(fp_err);
	fclose(fp_res);
	return 0;
}
