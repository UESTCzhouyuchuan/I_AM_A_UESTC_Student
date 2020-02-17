package 同余;

import java.util.Scanner;

public class 重复平方乘算法 {
	static int f(int a, int k, int m) {
		int b = 1;
		if (k == 0) {

		} else {
			int A = a;
			if (k % 2 == 1) {
				b = a;
			}
			k = k / 2;
			while (k != 0) {
				A = (A * A) % m;
				if (k % 2 == 1) {
					b = (A * b) % m;
				}
				k = k / 2;
			}
		}
		return b;
	}

	public static void main(String[] args) {
		Scanner x = new Scanner(System.in);
		int a, k, m;
		System.out.println("Input a,k,m,usage:a^k(mod m)");
		a = x.nextInt();
		k = x.nextInt();
		m = x.nextInt();
		x.close();
		System.out.println("Your input: a=" + a + "\tk=" + k + "\tm=" + m);
		System.out.println("After claculate: result-->" + a + "^" + k + "(mod " + m + ") = " + f(a, k, m));

	}

}
