package �ڶ���ʵ��;

import java.util.*;
public class isPrime {
	public static void main(String [] args){
		System.out.println("Enter n(less than 1000) : ");
		//����n
		Scanner x = new Scanner(System.in);
		int n = x.nextInt();
		x.close();
		int [] sim = new int[1001];
		int i,j;
		//��ʼ��
		for ( i =1 ; i < n+1 ; i++){
			sim[i]=0;
		}
		//�ų���
		for ( i = 2 ; i*2 < n+1 ;i++){
			//���i��ʱ������
			if (sim[i]==0){
				for ( j =2 ; i*j < n+1;j++){
					sim[i*j] = 1;
		        }
		    }
		}
		//���
		System.out.println("Prime(1-"+n+"):");
		for ( i =2 ; i< n+1 ; i++){
			if (sim[i]==0){
				System.out.print(i+",");
			}
		}
		
	}

}
