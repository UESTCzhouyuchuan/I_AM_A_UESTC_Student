package challenge;

import java.util.Scanner;

//超类shape类
abstract class Shape {
	int n;

	abstract double getArea();
}

//子类三角形类
class Triangle extends Shape {
	double x, y, z;

	// 构造函数
	Triangle(double x, double y, double z) {
		// 检查合法性
		if ((x + y > z) && (x - y < z) && (y - x < z)) {
			this.x = x;
			this.y = y;
			this.z = z;
		} else {
			System.out.println("Illegal input,usage:can't form a triangle");
			System.exit(-1);
		}
	}

	// 不带参数构造函数
	Triangle() {
		this(3, 4, 5);
	}

	// 设置数据
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

	// 返回面积
	double getArea() {
		// TODO Auto-generated method stub
		double p = (x + y + z) / 2;
		return (Math.sqrt((p - x) * (p - y) * (p - z)));
	}

}

//子类长方形类
class Rectangle extends Shape {
	double height, width;// 正方形的长和宽

	// 不带参数构造器
	public Rectangle() {
		// TODO Auto-generated constructor stub
		this(3, 4);
	}

	// 带参数
	public Rectangle(double height, double width) {
		this.width = width;
		this.height = height;
	}

	// 设置数据
	void setData(double height, double width) {
		this.height = height;
		this.width = width;
	}

	// 返回长方形面积
	double getArea() {
		// TODO Auto-generated method stub
		return (height * width);
	}

}

//柱体类
class Pillar {
	// 柱体底面边，以及高
	int n;
	double heigh;

	// 构造器初始化成员变量
	Pillar(int n, double h) {
		this.n = n;
		this.heigh = h;
	}

	// 返回柱体体积
	public double getVolume() {
		Scanner xx = new Scanner(System.in);
		Shape shape = null;// 定义一个超类，用其子类实例化
		if (n == 2) {
			double w, d;// 长方形长和宽
			w = xx.nextDouble();// 读入数据
			d = xx.nextDouble();

			shape = new Rectangle(w, d);// shape实例化为长方形类
		} else if (n == 3) {
			double a, b, c;// 三角形三个边
			a = xx.nextDouble();
			b = xx.nextDouble();
			c = xx.nextDouble();
			xx.close();
			shape = new Triangle(a, b, c);
		} else {
			System.out.println("Error: 边数为3或者2。");
			xx.close();
			System.exit(-1);
		}
		// 返回体积，面积乘高
		return (heigh * (shape.getArea()));
	}
}

//测试类
public class PillarTest {
	public static void main(String[] args) {
		Scanner x = new Scanner(System.in);
		// BufferedReader reader=new BufferedReader(new InputStreamReader(System.in));
		// 提示信息
		System.out.println("输入柱体底面的边数以及高，最后输入低面边的长度：");
		int n = x.nextInt();// 读入数据，边数和高
		double h = x.nextDouble();
		// x.close();不能关掉
		Pillar pillar = new Pillar(n, h);
		// 输出柱体高度
		System.out.println("\n柱体的体积为:" + pillar.getVolume());
		x.close();
	}

}
