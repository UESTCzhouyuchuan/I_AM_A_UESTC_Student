package 第六章;

// 接口Print
interface Print {
	void print();
}

// 实现类1doPrint1
class doPrint1 implements Print {

	public void print() {
		// TODO Auto-generated method stub
		int i, j;
		for (i = 1; i < 9; i++)
			for (j = 1; j < i + 1; j++)
				System.out.print(j + "*" + i + "=" + i * j + (i == j ? '\n' : ' '));
	}
}

// 实现类2doPrint2
class doPrint2 implements Print {
	// 实现打印函数
	public void print() {
		// TODO Auto-generated method stub
		System.out.println("I love Java!");
	}
}

public class p6_7 {
	public static void main(String[] args) {
		// 进行测试
		// Print t = new Print() ; //接口不能被自己实例化
//		Print t = new doPrint1(); // 可以用实现类实例化
//		t.print();
//		t = new doPrint2();
//		t.print();
		doPrint1 t1 = new doPrint1();
		doPrint2 t2 = new doPrint2();
		System.out.println("Print1:");
		t1.print();
		System.out.println("\nPrint2");
		t2.print();
	}
}
