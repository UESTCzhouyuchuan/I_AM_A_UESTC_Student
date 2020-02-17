package 同余;

import java.util.Scanner;

/*
 * 求逆元，有两种方法，一个是利用欧拉定理a^m = 1(mod m)所以a^-1 = a^(m-1)(mod m)
 * 另一种方法用扩展的欧几里得（递归）
 */
public class 求逆元 {
	// 重复平方算法
	static int repeatedSquareAlgorithm(int a, int k, int m) {
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
	// 重复平方算法结束

	// 递归的扩展欧几里得算法
	static Demo extendsEuclidenAlgorithm(int a, int q) {
		// 当q为0时，到达递归终点，返回最大公因子，以及x =1,y=0
		if (q == 0) {
			Demo tDemo = new Demo(a, 1, 0);
			return tDemo;
		} else {
			// 得到下一层的Demo
			Demo tDemo = extendsEuclidenAlgorithm(q, a % q);
			// 推导出父层与子层的gcd，x，y关系
			int temp = tDemo.x;
			tDemo.x = tDemo.y;
			tDemo.y = temp - (int) (a / q) * tDemo.y;
			return tDemo;
		}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int a, m;
		Scanner xScanner = new Scanner(System.in);
		System.out.println("输入该数字以及要模的数字，a,m(求解x = a^-1 mod m)");
		a = xScanner.nextInt();
		m = xScanner.nextInt();
		xScanner.close();
		// 利用扩展的欧几里得求解
		Demo tDemo = extendsEuclidenAlgorithm(a, m);
		System.out.println(tDemo + "\t利用扩展欧几里得算法:\n" + a + "模" + m + "的逆元为" + tDemo.x);
		// 利用欧拉定理求解x = a^(m-1) mod m
		int x = repeatedSquareAlgorithm(a, m - 1, m);
		System.out.println("\n利用欧拉定理求解x = " + a + "^" + (m - 1) + "mod" + m + ":\n" + a + "模" + m + "的逆元为" + x);
	}

}

//里面储存扩展欧几里得系数
class Demo {
	int x, y;
	int gcd;

	// 构造器初始化
	public Demo(int gcd, int x, int y) {
		this.gcd = gcd;
		this.x = x;
		this.y = y;
	}

	// 改变x，y
	public void setData(int gcd, int x, int y) {
		this.gcd = gcd;
		this.x = x;
		this.y = y;
	}
}
