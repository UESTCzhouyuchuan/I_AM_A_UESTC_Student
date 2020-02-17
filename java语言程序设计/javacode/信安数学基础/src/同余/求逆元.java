package ͬ��;

import java.util.Scanner;

/*
 * ����Ԫ�������ַ�����һ��������ŷ������a^m = 1(mod m)����a^-1 = a^(m-1)(mod m)
 * ��һ�ַ�������չ��ŷ����ã��ݹ飩
 */
public class ����Ԫ {
	// �ظ�ƽ���㷨
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
	// �ظ�ƽ���㷨����

	// �ݹ����չŷ������㷨
	static Demo extendsEuclidenAlgorithm(int a, int q) {
		// ��qΪ0ʱ������ݹ��յ㣬����������ӣ��Լ�x =1,y=0
		if (q == 0) {
			Demo tDemo = new Demo(a, 1, 0);
			return tDemo;
		} else {
			// �õ���һ���Demo
			Demo tDemo = extendsEuclidenAlgorithm(q, a % q);
			// �Ƶ����������Ӳ��gcd��x��y��ϵ
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
		System.out.println("����������Լ�Ҫģ�����֣�a,m(���x = a^-1 mod m)");
		a = xScanner.nextInt();
		m = xScanner.nextInt();
		xScanner.close();
		// ������չ��ŷ��������
		Demo tDemo = extendsEuclidenAlgorithm(a, m);
		System.out.println(tDemo + "\t������չŷ������㷨:\n" + a + "ģ" + m + "����ԪΪ" + tDemo.x);
		// ����ŷ���������x = a^(m-1) mod m
		int x = repeatedSquareAlgorithm(a, m - 1, m);
		System.out.println("\n����ŷ���������x = " + a + "^" + (m - 1) + "mod" + m + ":\n" + a + "ģ" + m + "����ԪΪ" + x);
	}

}

//���洢����չŷ�����ϵ��
class Demo {
	int x, y;
	int gcd;

	// ��������ʼ��
	public Demo(int gcd, int x, int y) {
		this.gcd = gcd;
		this.x = x;
		this.y = y;
	}

	// �ı�x��y
	public void setData(int gcd, int x, int y) {
		this.gcd = gcd;
		this.x = x;
		this.y = y;
	}
}
