package ��һ��ʵ��;

import java.util.*;

public class plus_num {

	public static void main(String args[]) {
		Scanner x = new Scanner(System.in);
		System.out.println("����һ�����֣�");
		int i = x.nextInt();x.close();
		int sum=0;
		while (i!=0) {
			sum+=i%10;
			i=i/10;
		}
		System.out.println("Output: "+sum);
		
	}
}
