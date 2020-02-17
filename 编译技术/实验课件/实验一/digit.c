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

numTableItem constant_table[MAX_TAB_SIZE];	//常数表 
int constant_size = 0;						//常数表个数 

char reserve_table[MAX_TAB_SIZE][10];		//保留字表 
int reserve_size = 0;						//保留字个数 

int line = 1;	//初始化为第一行 
int num = 1;	// 标识符字编号 
int change_line = 1;

/*****************************************************************************
* 函数名称： getnbc
* 功能描述： 从文件中读入字符，检查变量是否为空白字符，若是，则读入下一个字符，直到读到
*			非空白字符为止
******************************************************************************/
char getnbc(FILE *fp1)	//fp1源文件名 
{
	char ch = fgetc(fp1);
	while (ch == ' ' || ch == '\t') ch = fgetc(fp1);	//略过空格和制表符
	return ch;	//返回符号 
}

/*****************************************************************************
* 函数名称： concat
* 功能描述： 将character连接到token数组的末尾，然后再插入'\0'，并修改token的长度
******************************************************************************/
void concat(char character, char token[], int *n)
{
	token[*n] = character;	//将character添加到token中 
	(*n)++;					//token个数加一 
	token[*n] = '\0';		//字符结束符 
}

/*****************************************************************************
* 函数名称： symbol
* 功能描述： 返回token类型，是否为标识符或者关键字 
******************************************************************************/
int symbol(char token[])
{
	int i; 
	for (i = 0 ; i < reserve_size ; i++){	//在保留字表中逐个比较，是否为保留字 
		if(strcmp(reserve_table[i],token)==0)		
		return i+3;							//返回保留字类型，保留字类型与数组底数有加三关系 
	}
	return T_SYMBOL;								//若不是保留字，返回标识符类型 
}
/*****************************************************************************
* 函数名称： digit
* 功能描述： 判断是否是数字，若是则返回1，否则返回0
******************************************************************************/
int digit(char character)
{
	return (character >= '0' && character <= '9');
}

/*****************************************************************************
* 函数名称： retract
* 功能描述： 回退字符，若是非空白字符，将字符保存在back中；若是空白字符，不回退
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
* 函数名称： constant
* 功能描述： 对token中的字符串查常数表，若查到，返回该常数的序号，否则将新的常数插入
表中，再返回序号
******************************************************************************/
int constant(char token[], int n)
{
	int i, j, b;
	int dec, rem, tmp;
	int stack[MAX_BIT];//栈
	int top = 0;

	// 转换成十进制数
	for (i = 0, dec = 0; i < n; i++) {
		dec = dec * 10 + (token[i] - '0');
	}

	// 转换成二进制数，倒序放在栈中，高位放在栈底
	rem = dec;
	if (dec == 0) stack[top++] = 0;	//“0”单独处理
	while (rem > 0) {
		stack[top++] = rem % 2;
		rem = rem / 2;
	}

	tmp = top;	//暂存栈顶指针，代表二进制数的位数
	for (i = 0; i < constant_size; i++) {
		b = constant_table[i].bit;	//取二进制数的位数
		if (top != b) continue;		//位数不相等，直接跳过该数

		for (j = 0; j < b; j++) {	//逐位比较
			if (stack[--top] != constant_table[i].binary[j]) break;
		}
		if (j >= b) return i;	//找到相同的数，直接返回该数在表中的位置
		top = tmp;	//还原top
	}

	// 如果没有找到相同的数，就将该数录入表中
	i = constant_size++;
	constant_table[i].binary = (int *)malloc((top + 1)* sizeof(int));//动态分配内存 
	constant_table[i].bit = top;	//bit存储该二进制数的位数
	for (j = 0; top > 0; j++) {
		constant_table[i].binary[j] = stack[--top];   //顺序存储进数组中
	}
	return i;
}

/*****************************************************************************
* 函数名称： error1
* 功能描述： 打印出错的信息
******************************************************************************/
void error1(FILE *fp4, char character, int line)
{
	printf("\nerror: line %.2d: 含有非法字符:\t%c\n\n", line, character);	//打印屏幕上 
	fprintf(fp4, "error: line %.2d: 含有非法字符:\t%c \n", line, character);//打印error文件中 
}

/*****************************************************************************
* 函数名称： analyze
* 功能描述： 主词法分析函数，每调用一次获取一个单词，将其打印到屏幕并输出到文本
******************************************************************************/
int analyze(FILE *fp1, FILE *fp2, FILE *fp3, FILE *fp4, int *back_flag, char *back)
{			//fp1为输入源文件，fp2为输出文件，fp3为符号表文件，fp4为错误输出文件 
	char character;
	char token[24]={'\0'};
	int  n = 0;		//n记录token中的字符串长度
	int  type = 0;		//单词类型
	int  val = 0;		//单词属性，只有标识符和常数不是0

	if (*back_flag) {	//上一次有回退，就使用上一次的字符，否则读取文件中下一个字符 
		character = *back;
		*back_flag = 0;
	}
	else character = getnbc(fp1);
	
	
	if (digit(character)) {	//第一个数是常数
		while (digit(character)) {//下一个数字也是常数 
			concat(character, token, &n);//添加到token数组中 
			character = fgetc(fp1);
		}
		val = constant(token, n);//在常数表中位置 
		type = T_CONSTANT;//类型是常数 
		*back_flag = retract(character, back);//是否有回退 
	}
	else if(isalpha(character)||character == '_')//是字母下，划线组成 ,可能是保留字，标识符 
	{
		while(isalpha(character)||digit(character)||character == '_')//是字母，下划线，数字组成 ,可能是保留字，标识符 
		{
			concat(character, token, &n);	//添加到token数组中 
			character = fgetc(fp1);
		}
		type = symbol(token);			//返回字符的类型 
		*back_flag = retract(character, back);	//判断回退 
	}
	else {
		switch (character) {
		case '+':	type = T_ADD;	concat(character, token, &n);	break;//为加号 
		case '-':	type = T_SUB;	concat(character, token, &n);	break;//为减号 
		case '*':	type = T_MUL;	concat(character, token, &n);	break;//为乘号 
		case '%':	type = T_MOD;	concat(character, token, &n);	break;//为求模号 
		case '/':	//进行判断，为除号，还是注释开始符号 
					character = fgetc(fp1);		//下一个符号 
					if ( character == '/' ){	//为注释符号 "//" 
						while( (character = fgetc(fp1)) != '\n');//该行符号忽略 
						line++;								//行数加一 
						return 0;							//结束 
					}
					else if (character == '*'){//为注释符号 "/*"
						char ch;				//协助判断注释结束符 "*/" 
						character = fgetc(fp1); //读下一个字符 
						if ( character == '\n')
								line++; 	//行数加一 
						while (1){
							ch = fgetc(fp2); //读源文件
							if ( ch == '\n')
								line++; 	//行数加一 
							if ( ( character ) == '*' && ( ch == '/' )) //遇到结束符 
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
						type = T_DIV;	concat('/', token, &n);//为除号 
					}
					break;
		
		case '<':	type = T_L;	    concat(character, token, &n);//先让它为小于符号 
				character = fgetc(fp1); 
				if (character == '='){
					type = T_LE;    concat(character, token, &n);} 
				else{
					*back_flag = retract(character, back);			//否则回退一个字符 
				}			
				break;
		case '>':	type = T_G;  	concat(character, token, &n); // 先让它为大于符号 
				character = fgetc(fp1); 
				if (character == '='){
					type = T_GE;    concat(character, token, &n);}//若后面为等号 即为大于等于号 
				else{
					*back_flag = retract(character, back);	//否则回退一个字符 
				}	
				break;
		case '=':	type = T_ASSIGN;concat(character, token, &n);//先记为赋值符号 
				character = fgetc(fp1);
				if (character == '='){							//若下一个字符为等号，记为等号 
					type = T_EQ;    concat(character, token, &n);}
				else{
					*back_flag = retract(character, back);		//否则回退一个字符 
				}
				break;
		case '!':  type = T_N;concat(character, token, &n); //先记为非 
				character = fgetc(fp1); 
				if (character == '='){						//下一个字符为等号，则记为不等于 
					type = T_NE;    concat(character, token, &n);}
				else{
					*back_flag = retract(character, back);	//否则会退一个字符 
				}		
				break;
		case '&': 	concat(character, token, &n);
				character = fgetc(fp1);						
				if (character == '&'){						//两位都是&，记为逻辑与 
					type = T_AND;concat(character, token, &n);
				}	
				else {										//否则记为错误符号 
					error1(fp4,'&',line);
					*back_flag = retract(character, back);//回退一个字符 
				}
				break;	
		case '|': 	concat(character, token, &n);
				character = fgetc(fp1);
				if (character == '|'){					//连个|符号记为逻辑或 
					type = T_AND;concat(character, token, &n);
				}	
				else {
					error1(fp4,*token,line);				//否则记为非法字符 
					*back_flag = retract(character, back);			//回退一个字符 
				}
				break;
		case '\\':	concat(character, token, &n);
				character = fgetc(fp1);
				if ( character == 'n'){						//若两个符号为'/n' 
					type = T_EOLN;concat(character, token, &n);
					change_line = 0;
				}
				else {
					error1(fp4,*token,line);					//否则记为非法字符 
					*back_flag = retract(character, back);			//回退一个字符 
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
	// 在屏幕上打印并输出到文本
	if ( type >= 3 && type < reserve_size+3){
		printf("line %.2d: 保留字  %s\n", line, token);
		fprintf(fp2, "line %.2d: 保留字  %s\n", line, token);
	} 
	else if ( type >= T_ADD && type <= T_MOD){
		printf("line %.2d: 运算符  %s\n", line, token);
		fprintf(fp2, "line %.2d: 运算符  %s\n", line, token);
	}
	else {
		switch ( type ){
			case T_SYMBOL:
				printf("line %.2d: 标识符  %s\n", line, token);
				fprintf(fp2,"line %.2d 标识符  %s\n", line,token);
				fprintf(fp3, "%d\t%d\t%s\n", num++,line, token);
				break;
			case T_CONSTANT:
				printf("line %.2d: CONSTANT %s\n", line, token);
				fprintf(fp2, "line %.2d: CONSTANT %s\n", line,token);
				break;
			case T_LPAR:
				printf("line %.2d: 左括号  %s\n", line, token);
				fprintf(fp2, "line %.2d: 左括号  %s\n", line, token);
				break;
			case T_RPAR:
				printf("line %.2d: 右括号  %s\n", line, token);
				fprintf(fp2, "line %.2d: 右括号  %s\n", line, token);
				break;
			case T_LMPAR:
				printf("line %.2d: 左中括号 %s\n", line, token);
				fprintf(fp2, "line %.2d: 左中括号 %s\n", line, token);
				break;
			case T_RMPAR:
				printf("line %.2d: 右中括号 %s\n", line, token);
				fprintf(fp2, "line %.2d: 右中括号 %s\n", line, token);
				break;
			case T_LBPAR:
				printf("line %.2d: 左大括号 %s\n", line, token);
				fprintf(fp2, "line %.2d: 左大括号 %s\n", line, token);
				break;
			case T_RBPAR:
				printf("line %.2d: 右大括号 %s\n", line, token);
				fprintf(fp2, "line %.2d: 右大括号 %s\n", line, token);
				break;
			case T_ASSIGN:
				printf("line %.2d: 等号    %s\n", line, token);
				fprintf(fp2, "line %.2d: 等号    %s\n", line, token);
				break;
			case T_COM:
				printf("line %.2d: 逗号    %s\n", line, token);
				fprintf(fp2, "line %.2d: 逗号    %s\n", line, token);
				break;
			case T_COLON:
				printf("line %.2d: 冒号    %s\n", line, token);
				fprintf(fp2, "line %.2d: 冒号    %s\n", line, token);
				break;
			case T_SEM:
				printf("line %.2d: 分号    %s\n", line, token);
				fprintf(fp2, "line %.2d: 分号    %s\n", line, token);
				break;
			case T_POINT:
				printf("line %.2d: 点      %s\n", line, token);
				fprintf(fp2, "line %.2d: 点       %s\n", line, token);
				break;
			case T_SINGQU:
				printf("line %.2d: 单引号  %s\n", line, token);
				fprintf(fp2, "line %.2d: 单引号  %s\n", line, token);
				break;
			case T_DOUBQU:
				printf("line %.2d: 双引号  %s\n", line, token);
				fprintf(fp2, "line %.2d: 双引号  %s\n", line, token);
				break;
			case T_EOF:
				printf("line %.2d: 结尾符  %s\n", line, token);
				fprintf(fp2, "line %.2d: 结尾符  %s\n", line, token);
				break;
			case T_WELL:
				printf("line %.2d: 井号    %s\n", line, token);
				fprintf(fp2, "line %.2d: 井号    %s\n", line, token);
				break;
			case T_EOLN:
				printf("line %.2d: 行尾符  %s\n", line, token);
				fprintf(fp2, "line %.2d: 行尾符  %s\n", line, token);
				if (change_line)//若遇到换行符就换行，行数加一，若'\n'就不换行 
				line++;
				break;
			default: break;
		}
	}
	return type;	//返回类型 
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
		printf("打开源文件失败！请确定源文件的位置！\n");
		return -1;
	}
	//从保留字文件中读取保留字 
	FILE *fp_res = fopen(reserve, "r");
	if (fp_res == NULL) {
		printf("打开保留字文件失败！请确定源文件的位置！\n");
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

	int back_flag = 0;	//回退的标记，1代表上一次有回退(空格不算)，0代表没有
	char back;			//存放上一次的回退值

	printf("周玉川-2017221302006\n\n");
	fprintf(fp_output, "周玉川-2017221302006\n\n");
	fprintf(fp_sym, "符号表\n编号\t行号\t名字\n");
	
	while (analyze(fp_src, fp_output, fp_sym, fp_err, &back_flag, &back) != T_EOF);//返回类型为文件结束，结束循环 

	fclose(fp_src);
	fclose(fp_output); 
	fclose(fp_sym);
	fclose(fp_err);
	fclose(fp_res);
	return 0;
}
