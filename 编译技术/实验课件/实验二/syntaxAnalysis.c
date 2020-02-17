/*
	Name:syntaxAnalysis.cpp
	Time:2018.11.30
	Auther������ 
	*/
	
/****************************************************** 
ԭʼ�ķ���											  * 
Expr->Expr+Term|Term|Expr-Term						  * 
Term->Term*Factor|Factor|Term/Factor				  * 
Factor->(Expr)|i									  * 
******************************************************/
 

/******************************************************************** 
�������ݺ���﷨,���пռ�Ϊ $										* 
Expr->Term Expr_													* 
Expr_->+Term Expr_|-Term Expr_|$									* 
Term->Factor Term_													* 
Term_ ->*Factor Term_|/Facter Term_|$								* 
Factor->(Expr)|i													* 
�����ַ���Ϊsource.txt��source1.txt��source2.txt�������ĵ�			* 
*********************************************************************/


/************************************************
*����Follow��,#Ϊ�ս�� 						*
*Follow(E)={ # , ) } 							*
*Follow(E_)={ #, ) }							*
*Follow(T)={ +, - , # , ) }						*
*Follow(T_) ={ +, - , #, ) } 					*
*Follow(F) = { *, / }							*
*************************************************/ 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define MAX_SIZE 100

char token[12] = {'\0'};	//��¼��ǰ�������ַ��� 
int token_len = 0;			//token����
char character;				//��ǰ�ַ� 
int place = -1;				//��¼�ַ����ַ�����λ�� 
char str[MAX_SIZE];			//�����ַ��� 

FILE* fp_src, *fp_out, *fp_error;//Դ�ļ�����ϸ�����ļ�����������ļ� 

/**************************************************************** 
*getchr()�����ܴ�str[]�ַ����ж����ַ�							* 
*error()�����ܣ���ӡ������Ϣ      								* 
*print(): ���ܣ���ӡ���������Ѿ������Ĵ�����ǰ�ִ����Լ�ʣ�മ 	* 
*getToken(): ���ܣ��õ���ǰҪ�������ַ���						* 
*concat(char character): ���ܣ���getchr�õ����ַ���ӵ�token��	* 
*****************************************************************/
void getchr();
void getToken();
void error();
void print();
void concat(char character); 

/****************************************** 
*�ķ���Ӧ������ȡ����ĸ��д				  *
*******************************************/ 
void E();
void E_();
void F();
void T();
void T_();

/**************************************************** 
*  		������ 										* 
*****************************************************/
int main(){
	char* source = "source3.txt";		//Դ�ļ� 
	char* output = "detail.txt";		//���������ļ� 
	char* error	 = "error.txt"; 		//��������ļ� 

	fp_src = fopen(source,"r");			//��Դ�ļ�
	if ( fp_src == NULL ){
		printf("Error:��Դ�ļ�ʧ�ܡ�");
		exit(-1);						//ʧ�ܲ��� 
	}
	fp_out = fopen(output, "w");		//�򿪷��������ļ� 
	if ( fp_out == NULL ){
		printf("Error:�򿪲����������ļ�ʧ�ܡ�");
		exit(-1);						//ʧ�ܲ��� 
	}
	fp_error = fopen(error, "w");		// �򿪴�������ļ� 
	if ( fp_error == NULL ){
		printf("Error:�򿪴�������ļ�ʧ�ܡ�");
		exit(-1);						//ʧ�ܲ��� 
	}
	
	fprintf(fp_out,"ѧ�ţ�2017221302006\t����������\n");
	fprintf(fp_error,"ѧ�ţ�2017221302006\t����������\n");//���ѧ����Ϣ��detail.txt,error.txt�Լ���Ļ�� 
	printf("ѧ�ţ�2017221302006\t����������\n");
	
	fgets(str,MAX_SIZE,fp_src); 		//���ļ��ж�����ʽ�����ַ���str��
	printf("The experssion: %s\n",str); //������ʽ 
	int str_len = strlen(str);  		//���ʽ���ĳ���
	str[str_len] = '#';
	str[str_len+1] = '\0'; 				//�ڱ��ʽ��������ս�� 
	
	getToken();						//�����һ�����ʷ��� 
	E();							//��ʼ�ݹ���� 
	
	fprintf(fp_out, "\n=========================================\n"); 
	fprintf(fp_out, "�������ʽ������\n");//�ݹ�����󣬴�ӡ�ս������detai.txt�ļ���
	print();					
	printf("�������������");				//�ݹ�ɹ������������Ϣ����Ļ 
	
	fclose(fp_src);				//�ر��ļ� 
	fclose(fp_out);
	fclose(fp_error);
	
	return 0;					//������� 
}


/******************************** 
* ����ʽ��Expr->Term Expr_		* 
*********************************/ 
void E(){
	T();
	E_();
}


/******************************************** 
*����ʽ��Expr_->+Term Expr_|-Term Expr_|$ 	*
*�����մ���Ҫ�ж� Follow(Expr_) =  { #, ) }	*
*********************************************/ 
void E_(){ 					
	if ( character == '+' ){//��ǰ�����ǼӺ� 
		fprintf(fp_out,"\n=====================================\n");
		fprintf(fp_out,"ʹ�õĲ���ʽ��Expr_ ----> +Term Expr_\n");//�����Ϣ��detail.txt�ļ��� 
		print();												//��ӡ��ǰ�����Ѿ���������δ������ 
		getToken();												//��ȡ��һ�����ʷ��� 
		T();
		E_();													//�����ݹ� 
	}
	else if ( character == '-' ){								//	��ǰ�����Ǽ��� 
		fprintf(fp_out,"\n======================================\n");//�����Ϣ��detail.txt�ĵ��� 
		fprintf(fp_out,"ʹ�õĲ���ʽ��Expr_ ----> -Term Expr_\n");
		print();
		getToken();													//��ȡ��һ�����ʷ��� 
		T();
		E_();														//�����ݹ� 
	}
	
	/************************************************************
	*���follow��,Follow(E_)={ #, ) }							* 
	*************************************************************/ 
	else if (  character == ')'|| character == '#' )		//�����һ���ַ�����Expr_��Follow�����ͼ����ݹ� 
			return ;
	else{												//�������Ϊ�������������Ϣ��error.txt�ļ��� 
		fprintf(fp_error, "\n=====================================\n");
		fprintf(fp_error, "ʹ�õĲ���ʽ��Expr_ ----> +Term Expr_ | -Term Expr_ | $\n");
		error();
	}
		
}


/******************************** 
*����ʽ�� Term->Factor Term_	* 
*********************************/ 
void T(){  
	F();
	T_();
}

/**************************************************** 
*����ʽ��Term_ ->*Factor Term_|/Facter Term_|$		*
*�����մ���Ҫʹ��Follow(Term_) =  { +��-,),# }		*
*****************************************************/ 
void T_(){ // 
	if ( character == '*' ){
		fprintf(fp_out, "\n======================================\n");//�����Ϣ��detail.txt�ĵ��� 
		fprintf(fp_out, "ʹ�õĲ���ʽ��Term_ ----> *Factor Term_\n");
		print();
		getToken();														//������һ�����ʷ��� 
		F();
		T_();															//�����ݹ� 
	}
	else if ( character == '/' ){										//�ж�token��Ϊ���� 
		fprintf(fp_out, "\n=======================================\n");//�����Ϣ��detail.txt�ĵ��� 
		fprintf(fp_out, "ʹ�õĲ���ʽ��Term_ ----> /Facter Term_\n");
		print();
		getToken();													//������һ�����ʷ��� 
		F();
		T_();														//�����ݹ� 
		 
	}
	/************************************************************ 
	*���follow��,Follow(E_)={ +��-,),# }						* 
	*************************************************************/ 
	else if ( character == '+' || character == '-' 
					|| character == ')' || character == '#' )//��Follow�����ַ������ͼ����ݹ� 
			return ;
	else{													//������Ϊ�������������Ϣ��error.txt�ļ���													
		fprintf(fp_error, "\n=========================================\n");
		fprintf(fp_error, "ʹ�õĲ���ʽ��Term_ ----> *Factor Term_ | /Facter Term_ | $\n");
		error();
	}
	
}

/******************************** 
*����ʽ�� Factor->(Expr)|i		* 
*********************************/ 
void F(){
	if ( character == '(' ){						//ƥ�������� 
		fprintf(fp_out, "\n=======================================\n");
		fprintf(fp_out, "ʹ�õĲ���ʽ��Factor ----> (Expr) \n");
		print();										//�����Ϣ 
		getToken();
		E();											//�����ݹ� 
		if ( character == ')'){					//ƥ�������ţ������Ϣ��detail.txt�ļ��� 
			fprintf(fp_out, "\n=======================================\n");
			fprintf(fp_out, "ʹ�õĲ���ʽ��Factor ----> (Expr) \n");
			print();
			getToken();
		}else{											//û��ƥ�䵽�����ţ���Ϊ���� 
			fprintf(fp_error, "\n=======================================\n");
			fprintf(fp_error, "ʹ�õĲ���ʽ��Factor ----> (Expr) \n");
			error();
		}
	}
	else if ( isdigit( token[0] ) || token_len > 1){	//ƥ�䵽���֣����߱�ʶ���������Ϣ��detail.txt�ļ� 
		fprintf(fp_out, "\n=======================================\n");
		fprintf(fp_out, "ʹ�õĲ���ʽ��Factor ----> i\n");
		print();
		getToken();
	}
}


/******************************************************** 
*name:getchr				   							* 
*function:ʡ�Կո�ʽ�����ַ� 							* 
*********************************************************/ 
void getchr(){
	while( ( character = str[++place] ) == ' ');
}

/************************************************************ 
*name:concat 												* 
*function:�ѵ����ַ����ӵ�tokenĩβ������'\0',���޸ĳ���	* 
*************************************************************/ 
void concat(char character){
	token[token_len] = character;
	token_len++;
	token[token_len] = '\0';
}


/************************************************************************ 
*name:getToken 															* 
*function:�ӱ��ʽ���еõ����ʷ��ţ���ʶ�������֣������������������ 	* 
*************************************************************************/ 
void getToken(){
	int i;
	for ( i = 0 ; i < token_len ; i++)
		token[i]='\0';
	token_len = 0;									//���token����ʼ�����µĵ��ʷ��� 
	getchr();
	if (isdigit( character )){						//�ж��ַ�Ϊ���֣�������token�еõ����ִ� 
		while (isdigit( character)){
			concat(character);
			character = str[++place];
		}
		place--;									//�����һ�Σ��˻�һ���ַ� 
	}
	else if (isalpha( character) || character == '_') 		//�ж�����ĸδ��ĸ�����»��ߣ�������token�еõ�һ����ʶ�� 
	{
		while ( isalnum( character )|| character == '_' ){	//��ǰ�ַ�����ĸ�����֣��»��� 
			concat(character);
			character = str[++place];						//������һ���ַ� 
		}
		place--; 											//��Ϊ�����һ�Σ�����һ���ַ� 
	}
	else{													//����������� 
		switch ( character ){
			case '+': case '-': case '*': case '/': case '#': case '(': case ')': //���ǹ涨�ַ�������token�� 
				concat(character);
				break;
			default:
				concat(character);												//��δ֪�ַ���ӵ�token�У�������� 
				error();														//������Ϊ���� 
		}
	}
}

/******************************************************************** 
*name��print 														* 
*function: ��ӡ�Ѿ������Ĵ�����ǰ�����Ѿ�ʣ�മ��detail.txt�ļ���	* 
*********************************************************************/ 
void print(){
	fprintf(fp_out, "�Ѿ������Ĵ�:	");
	int i;
	for ( i = 0 ; i < place-token_len+1 ; i++)
		fprintf(fp_out, "%c", str[i]);					//������������ִ� 
	fprintf(fp_out, "\n��ǰ�ַ�:	%s", token );		//�����ǰ�ִ� 
	fprintf(fp_out, "\nʣ�മ:	%s\n", str+place+1);	//���ʣ����ʽ�� 
		
}

/******************************************************** 
*name��error 											* 
*function����ӡ������Ϣ��error.txt�ļ��� 				*
*********************************************************/ 
void error(){
	fprintf(fp_error, "\nError: %s\n", token);				//�����ǰ�����ַ��� 
	printf("����������ܾ�\n");										//���ִ�������ܾ���Ϣ����Ļ
	fclose(fp_src);											//�ر��ļ� 
	fclose(fp_out);
	fclose(fp_error);
	exit(-1);												//�˳����� 
}

