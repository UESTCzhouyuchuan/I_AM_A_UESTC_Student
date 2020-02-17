package challenge;

import java.util.Scanner;

//����shape��
abstract class Shape {
	int n;

	abstract double getArea();
}

//������������
class Triangle extends Shape {
	double x, y, z;

	// ���캯��
	Triangle(double x, double y, double z) {
		// ���Ϸ���
		if ((x + y > z) && (x - y < z) && (y - x < z)) {
			this.x = x;
			this.y = y;
			this.z = z;
		} else {
			System.out.println("Illegal input,usage:can't form a triangle");
			System.exit(-1);
		}
	}

	// �����������캯��
	Triangle() {
		this(3, 4, 5);
	}

	// ��������
	void setData(double x, double y, double z) {
		if ((x + y > z) && (x - y < z) && (y - x < z)) {
			this.x = x;
			this.y = y;
			this.z = z;
		} else {
			System.out.println("Illegal input,usage:can't form a triangle");
			System.exit(-1);
		}
	}

	// �������
	double getArea() {
		// TODO Auto-generated method stub
		double p = (x + y + z) / 2;
		return (Math.sqrt((p - x) * (p - y) * (p - z)));
	}

}

//���೤������
class Rectangle extends Shape {
	double height, width;// �����εĳ��Ϳ�

	// ��������������
	public Rectangle() {
		// TODO Auto-generated constructor stub
		this(3, 4);
	}

	// ������
	public Rectangle(double height, double width) {
		this.width = width;
		this.height = height;
	}

	// ��������
	void setData(double height, double width) {
		this.height = height;
		this.width = width;
	}

	// ���س��������
	double getArea() {
		// TODO Auto-generated method stub
		return (height * width);
	}

}

//������
class Pillar {
	// �������ߣ��Լ���
	int n;
	double heigh;

	// ��������ʼ����Ա����
	Pillar(int n, double h) {
		this.n = n;
		this.heigh = h;
	}

	// �����������
	public double getVolume() {
		Scanner xx = new Scanner(System.in);
		Shape shape = null;// ����һ�����࣬��������ʵ����
		if (n == 2) {
			double w, d;// �����γ��Ϳ�
			w = xx.nextDouble();// ��������
			d = xx.nextDouble();

			shape = new Rectangle(w, d);// shapeʵ����Ϊ��������
		} else if (n == 3) {
			double a, b, c;// ������������
			a = xx.nextDouble();
			b = xx.nextDouble();
			c = xx.nextDouble();
			xx.close();
			shape = new Triangle(a, b, c);
		} else {
			System.out.println("Error: ����Ϊ3����2��");
			xx.close();
			System.exit(-1);
		}
		// �������������˸�
		return (heigh * (shape.getArea()));
	}
}

//������
public class PillarTest {
	public static void main(String[] args) {
		Scanner x = new Scanner(System.in);
		// BufferedReader reader=new BufferedReader(new InputStreamReader(System.in));
		// ��ʾ��Ϣ
		System.out.println("�����������ı����Լ��ߣ�����������ߵĳ��ȣ�");
		int n = x.nextInt();// �������ݣ������͸�
		double h = x.nextDouble();
		// x.close();���ܹص�
		Pillar pillar = new Pillar(n, h);
		// �������߶�
		System.out.println("\n��������Ϊ:" + pillar.getVolume());
		x.close();
	}

}
