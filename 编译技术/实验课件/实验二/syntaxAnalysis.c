/*
	Name:syntaxAnalysis.cpp
	Time:2018.11.30
	Auther：周玉川 
	*/
	
/****************************************************** 
原始文法：											  * 
Expr->Expr+Term|Term|Expr-Term						  * 
Term->Term*Factor|Factor|Term/Factor				  * 
Factor->(Expr)|i									  * 
******************************************************/
 

/******************************************************************** 
消除回溯后的语法,其中空记为 $										* 
Expr->Term Expr_													* 
Expr_->+Term Expr_|-Term Expr_|$									* 
Term->Factor Term_													* 
Term_ ->*Factor Term_|/Facter Term_|$								* 
Factor->(Expr)|i													* 
输入字符串为source.txt、source1.txt、source2.txt等三个文档			* 
*********************************************************************/


/************************************************
*计算Follow集,#为终结符 						*
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

char token[12] = {'\0'};	//记录当前分析的字符串 
int token_len = 0;			//token长度
char character;				//当前字符 
int place = -1;				//记录字符在字符串的位置 
char str[MAX_SIZE];			//储存字符串 

FILE* fp_src, *fp_out, *fp_error;//源文件，详细步骤文件，错误输出文件 

/**************************************************************** 
*getchr()：功能从str[]字符串中读入字符							* 
*error()：功能：打印错误信息      								* 
*print(): 功能：打印串，包括已经分析的串，当前字串，以及剩余串 	* 
*getToken(): 功能：得到当前要分析的字符串						* 
*concat(char character): 功能：将getchr得到的字符添加到token中	* 
*****************************************************************/
void getchr();
void getToken();
void error();
void print();
void concat(char character); 

/****************************************** 
*文法对应函数，取首字母大写				  *
*******************************************/ 
void E();
void E_();
void F();
void T();
void T_();

/**************************************************** 
*  		主函数 										* 
*****************************************************/
int main(){
	char* source = "source3.txt";		//源文件 
	char* output = "detail.txt";		//分析步骤文件 
	char* error	 = "error.txt"; 		//错误输出文件 

	fp_src = fopen(source,"r");			//打开源文件
	if ( fp_src == NULL ){
		printf("Error:打开源文件失败。");
		exit(-1);						//失败策略 
	}
	fp_out = fopen(output, "w");		//打开分析步骤文件 
	if ( fp_out == NULL ){
		printf("Error:打开步骤分析输出文件失败。");
		exit(-1);						//失败策略 
	}
	fp_error = fopen(error, "w");		// 打开错误输出文件 
	if ( fp_error == NULL ){
		printf("Error:打开错误输出文件失败。");
		exit(-1);						//失败策略 
	}
	
	fprintf(fp_out,"学号：2017221302006\t姓名：周玉川\n");
	fprintf(fp_error,"学号：2017221302006\t姓名：周玉川\n");//输出学号信息到detail.txt,error.txt以及屏幕上 
	printf("学号：2017221302006\t姓名：周玉川\n");
	
	fgets(str,MAX_SIZE,fp_src); 		//从文件中读入表达式串到字符串str中
	printf("The experssion: %s\n",str); //输出表达式 
	int str_len = strlen(str);  		//表达式串的长度
	str[str_len] = '#';
	str[str_len+1] = '\0'; 				//在表达式串中添加终结符 
	
	getToken();						//读入第一个单词符号 
	E();							//开始递归分析 
	
	fprintf(fp_out, "\n=========================================\n"); 
	fprintf(fp_out, "分析表达式串结束\n");//递归结束后，打印终结符串到detai.txt文件中
	print();					
	printf("分析结果：接受");				//递归成功，输出接受信息到屏幕 
	
	fclose(fp_src);				//关闭文件 
	fclose(fp_out);
	fclose(fp_error);
	
	return 0;					//程序结束 
}


/******************************** 
* 产生式：Expr->Term Expr_		* 
*********************************/ 
void E(){
	T();
	E_();
}


/******************************************** 
*产生式：Expr_->+Term Expr_|-Term Expr_|$ 	*
*包含空串，要判断 Follow(Expr_) =  { #, ) }	*
*********************************************/ 
void E_(){ 					
	if ( character == '+' ){//当前符号是加号 
		fprintf(fp_out,"\n=====================================\n");
		fprintf(fp_out,"使用的产生式：Expr_ ----> +Term Expr_\n");//输出信息到detail.txt文件中 
		print();												//打印当前串，已经分析串，未分析串 
		getToken();												//读取下一个单词符号 
		T();
		E_();													//继续递归 
	}
	else if ( character == '-' ){								//	当前符号是减号 
		fprintf(fp_out,"\n======================================\n");//输出信息到detail.txt文档中 
		fprintf(fp_out,"使用的产生式：Expr_ ----> -Term Expr_\n");
		print();
		getToken();													//读取下一个单词符号 
		T();
		E_();														//继续递归 
	}
	
	/************************************************************
	*添加follow集,Follow(E_)={ #, ) }							* 
	*************************************************************/ 
	else if (  character == ')'|| character == '#' )		//如果下一个字符输入Expr_的Follow集，就继续递归 
			return ;
	else{												//其余的作为错误，输出错误信息到error.txt文件中 
		fprintf(fp_error, "\n=====================================\n");
		fprintf(fp_error, "使用的产生式：Expr_ ----> +Term Expr_ | -Term Expr_ | $\n");
		error();
	}
		
}


/******************************** 
*产生式： Term->Factor Term_	* 
*********************************/ 
void T(){  
	F();
	T_();
}

/**************************************************** 
*产生式：Term_ ->*Factor Term_|/Facter Term_|$		*
*包含空串，要使用Follow(Term_) =  { +，-,),# }		*
*****************************************************/ 
void T_(){ // 
	if ( character == '*' ){
		fprintf(fp_out, "\n======================================\n");//输出信息到detail.txt文档中 
		fprintf(fp_out, "使用的产生式：Term_ ----> *Factor Term_\n");
		print();
		getToken();														//读入下一个单词符号 
		F();
		T_();															//继续递归 
	}
	else if ( character == '/' ){										//判断token串为除号 
		fprintf(fp_out, "\n=======================================\n");//输出信息到detail.txt文档中 
		fprintf(fp_out, "使用的产生式：Term_ ----> /Facter Term_\n");
		print();
		getToken();													//读入下一个单词符号 
		F();
		T_();														//继续递归 
		 
	}
	/************************************************************ 
	*添加follow集,Follow(E_)={ +，-,),# }						* 
	*************************************************************/ 
	else if ( character == '+' || character == '-' 
					|| character == ')' || character == '#' )//在Follow集的字符串，就继续递归 
			return ;
	else{													//否则作为错误，输出错误信息到error.txt文件中													
		fprintf(fp_error, "\n=========================================\n");
		fprintf(fp_error, "使用的产生式：Term_ ----> *Factor Term_ | /Facter Term_ | $\n");
		error();
	}
	
}

/******************************** 
*产生式： Factor->(Expr)|i		* 
*********************************/ 
void F(){
	if ( character == '(' ){						//匹配左括号 
		fprintf(fp_out, "\n=======================================\n");
		fprintf(fp_out, "使用的产生式：Factor ----> (Expr) \n");
		print();										//输出信息 
		getToken();
		E();											//继续递归 
		if ( character == ')'){					//匹配右括号，输出信息到detail.txt文件中 
			fprintf(fp_out, "\n=======================================\n");
			fprintf(fp_out, "使用的产生式：Factor ----> (Expr) \n");
			print();
			getToken();
		}else{											//没有匹配到右括号，视为错误 
			fprintf(fp_error, "\n=======================================\n");
			fprintf(fp_error, "使用的产生式：Factor ----> (Expr) \n");
			error();
		}
	}
	else if ( isdigit( token[0] ) || token_len > 1){	//匹配到数字，或者标识符，输出信息到detail.txt文件 
		fprintf(fp_out, "\n=======================================\n");
		fprintf(fp_out, "使用的产生式：Factor ----> i\n");
		print();
		getToken();
	}
}


/******************************************************** 
*name:getchr				   							* 
*function:省略空格方式读入字符 							* 
*********************************************************/ 
void getchr(){
	while( ( character = str[++place] ) == ' ');
}

/************************************************************ 
*name:concat 												* 
*function:把单个字符连接到token末尾，插入'\0',并修改长度	* 
*************************************************************/ 
void concat(char character){
	token[token_len] = character;
	token_len++;
	token[token_len] = '\0';
}


/************************************************************************ 
*name:getToken 															* 
*function:从表达式串中得到单词符号，标识符，数字，或者运算符，结束符 	* 
*************************************************************************/ 
void getToken(){
	int i;
	for ( i = 0 ; i < token_len ; i++)
		token[i]='\0';
	token_len = 0;									//清空token，开始读入新的单词符号 
	getchr();
	if (isdigit( character )){						//判断字符为数字，最终在token中得到数字串 
		while (isdigit( character)){
			concat(character);
			character = str[++place];
		}
		place--;									//多读入一次，退回一个字符 
	}
	else if (isalpha( character) || character == '_') 		//判断首字母未字母或者下划线，最终在token中得到一个标识符 
	{
		while ( isalnum( character )|| character == '_' ){	//当前字符是字母，数字，下划线 
			concat(character);
			character = str[++place];						//读入下一个字符 
		}
		place--; 											//因为多读入一次，回退一个字符 
	}
	else{													//处理其他情况 
		switch ( character ){
			case '+': case '-': case '*': case '/': case '#': case '(': case ')': //若是规定字符，存入token中 
				concat(character);
				break;
			default:
				concat(character);												//将未知字符添加到token中，方便输出 
				error();														//否则视为错误 
		}
	}
}

/******************************************************************** 
*name：print 														* 
*function: 打印已经分析的串，当前串，已经剩余串到detail.txt文件中	* 
*********************************************************************/ 
void print(){
	fprintf(fp_out, "已经分析的串:	");
	int i;
	for ( i = 0 ; i < place-token_len+1 ; i++)
		fprintf(fp_out, "%c", str[i]);					//输出分析过的字串 
	fprintf(fp_out, "\n当前字符:	%s", token );		//输出当前字串 
	fprintf(fp_out, "\n剩余串:	%s\n", str+place+1);	//输出剩余表达式串 
		
}

/******************************************************** 
*name：error 											* 
*function：打印错误信息到error.txt文件中 				*
*********************************************************/ 
void error(){
	fprintf(fp_error, "\nError: %s\n", token);				//输出当前错误字符串 
	printf("分析结果：拒绝\n");										//出现错误，输出拒绝信息到屏幕
	fclose(fp_src);											//关闭文件 
	fclose(fp_out);
	fclose(fp_error);
	exit(-1);												//退出程序 
}

