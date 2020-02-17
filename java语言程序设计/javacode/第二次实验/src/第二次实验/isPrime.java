package 第二次实验;

import java.util.*;
public class isPrime {
	public static void main(String [] args){
		System.out.println("Enter n(less than 1000) : ");
		//读入n
		Scanner x = new Scanner(System.in);
		int n = x.nextInt();
		x.close();
		int [] sim = new int[1001];
		int i,j;
		//初始化
		for ( i =1 ; i < n+1 ; i++){
			sim[i]=0;
		}
		//排除法
		for ( i = 2 ; i*2 < n+1 ;i++){
			//如果i暂时是素数
			if (sim[i]==0){
				for ( j =2 ; i*j < n+1;j++){
					sim[i*j] = 1;
		        }
		    }
		}
		//输出
		System.out.println("Prime(1-"+n+"):");
		for ( i =2 ; i< n+1 ; i++){
			if (sim[i]==0){
				System.out.print(i+",");
			}
		}
		
	}

}
