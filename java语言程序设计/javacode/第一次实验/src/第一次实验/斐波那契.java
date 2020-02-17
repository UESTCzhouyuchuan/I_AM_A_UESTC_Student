package 第一次实验;
import java.util.*;


public class 斐波那契 {
	
	static int[] remem = new int[51];
	
	static int Fib(int n) {
		if (n>50) {
			return 0;
		}
		if (n==1||n==2) {
			return 1;
		}
		else if( remem[n] > 0) {
			return remem[n];
		}
		else {
			return (remem[n]=Fib(n-1)+Fib(n-2));
		}
	}
	public static void main(String args[]) {
		Scanner x = new Scanner(System.in);
		System.out.println("Enter a int num(less than 40): ");
		int n = x.nextInt();
		x.close();
		for ( int i = 1 ; i <= n ; i++ ) {
			System.out.print(Fib(i)+" ");
		}
		
	}
}
