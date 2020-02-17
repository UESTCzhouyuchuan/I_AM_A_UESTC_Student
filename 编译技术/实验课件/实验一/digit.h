/*
 * digit.h
 *
 *  Created on: 2018年11月27日
 *      Author: ZhouYuchuan 
 */

/*****助记符的定义*****/
//标识符 
#define T_SYMBOL	1
//常数 
#define T_CONSTANT	2
//保留字 （基本字） 
#define T_INT 		3
#define T_IF  		4
#define T_ELSE		5
#define T_WHILE		6
#define T_FOR 		7
#define T_RETURN    8
#define T_FOPRN		9
#define T_FCLOSE	10
#define T_PRINTF	11
#define T_SCANF		12
#define	T_FLOAT		13
#define	T_DOUBLE	14
#define T_INCLUDE	15
#define	T_CIN		16
#define	T_COUT		17
#define	T_NEW		18
#define	T_DELETE	19
#define	T_MAIN		20

//运算符 
#define T_ADD 		80 // + 
#define T_SUB		81 // - 
#define T_MUL		82 // * 
#define T_DIV   	83 // /除 
#define T_L	     	84 // < 
#define T_LE		85 // <=
#define T_G      	86 // >
#define T_GE 		87 // >=
#define T_NE		88 // !=
#define T_EQ		89 // ==
#define T_N         90 // !
#define T_AND       91 // &&
#define T_OR        92 // || 
#define T_MOD       93 // %
//届符 
#define T_WELL      60 //井号# 
#define T_ASSIGN	61 //=号 
#define T_LPAR 		62 //(左括号 
#define T_RPAR		63 //)右括号 
#define T_COM		64 //,逗号 
#define T_SEM    	65 //;分号 
#define T_EOLN		66 //\n下一行 
#define T_EOF		67 //文本结束结束 
#define T_LMPAR     68 //[左中括号 
#define T_RMPAR     69 //]右中括号 
#define T_LBPAR     70 //{左大括号 
#define T_RBPAR     71 //}右大括号 
#define T_COLON     72 //：冒号 
#define T_POINT     73 //.点
#define T_SINGQU	74 //'单引号
#define	T_DOUBQU	75 //"双引号 
#define MAX_TAB_SIZE 	50   	//表的最大容量
#define MAX_BIT  	    128		//最大位数
#define MAX_ID_LENGTH 	128		//常量的最长长度

// 符号表存储类型定义
typedef struct symTableItem{
	char name[MAX_ID_LENGTH];
	int  type;
	int  ln;
} symTableItem;

// 常量表存储类型定义
typedef struct numTableItem {
	int *binary;	//二进制（数组）
	int bit;		//二进制位数
} numTableItem;

// 保留字表
extern char reserve_table[MAX_TAB_SIZE][10];
extern int reserve_size;

// 符号表，不规则数组
extern symTableItem symbol_table[MAX_TAB_SIZE];
extern int symbol_size;

// 常量表
extern numTableItem constant_table[MAX_TAB_SIZE]; //二进制存储
extern int constant_size;

extern int line;	//记录行号

// 词法分析所用到的函数声明
char getnbc(FILE *sfp);
void concat(char character, char token[], int *n);
int digit(char character);
int retract(char character, char *back);
int reserve(char token[]);
int symbol(char token[]);
int constant(char token[], int n);
void error1(FILE *fp4, char character, int line);
int analyze(FILE *fp1, FILE *fp2, FILE *fp3, FILE *fp4, int *back_flag, char *back);

