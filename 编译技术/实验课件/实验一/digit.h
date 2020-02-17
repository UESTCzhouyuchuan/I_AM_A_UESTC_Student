/*
 * digit.h
 *
 *  Created on: 2018��11��27��
 *      Author: ZhouYuchuan 
 */

/*****���Ƿ��Ķ���*****/
//��ʶ�� 
#define T_SYMBOL	1
//���� 
#define T_CONSTANT	2
//������ �������֣� 
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

//����� 
#define T_ADD 		80 // + 
#define T_SUB		81 // - 
#define T_MUL		82 // * 
#define T_DIV   	83 // /�� 
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
//��� 
#define T_WELL      60 //����# 
#define T_ASSIGN	61 //=�� 
#define T_LPAR 		62 //(������ 
#define T_RPAR		63 //)������ 
#define T_COM		64 //,���� 
#define T_SEM    	65 //;�ֺ� 
#define T_EOLN		66 //\n��һ�� 
#define T_EOF		67 //�ı��������� 
#define T_LMPAR     68 //[�������� 
#define T_RMPAR     69 //]�������� 
#define T_LBPAR     70 //{������� 
#define T_RBPAR     71 //}�Ҵ����� 
#define T_COLON     72 //��ð�� 
#define T_POINT     73 //.��
#define T_SINGQU	74 //'������
#define	T_DOUBQU	75 //"˫���� 
#define MAX_TAB_SIZE 	50   	//����������
#define MAX_BIT  	    128		//���λ��
#define MAX_ID_LENGTH 	128		//�����������

// ���ű�洢���Ͷ���
typedef struct symTableItem{
	char name[MAX_ID_LENGTH];
	int  type;
	int  ln;
} symTableItem;

// ������洢���Ͷ���
typedef struct numTableItem {
	int *binary;	//�����ƣ����飩
	int bit;		//������λ��
} numTableItem;

// �����ֱ�
extern char reserve_table[MAX_TAB_SIZE][10];
extern int reserve_size;

// ���ű�����������
extern symTableItem symbol_table[MAX_TAB_SIZE];
extern int symbol_size;

// ������
extern numTableItem constant_table[MAX_TAB_SIZE]; //�����ƴ洢
extern int constant_size;

extern int line;	//��¼�к�

// �ʷ��������õ��ĺ�������
char getnbc(FILE *sfp);
void concat(char character, char token[], int *n);
int digit(char character);
int retract(char character, char *back);
int reserve(char token[]);
int symbol(char token[]);
int constant(char token[], int n);
void error1(FILE *fp4, char character, int line);
int analyze(FILE *fp1, FILE *fp2, FILE *fp3, FILE *fp4, int *back_flag, char *back);

