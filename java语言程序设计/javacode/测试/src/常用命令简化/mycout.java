package 常用命令简化;

public class mycout {

	void setdate(int a) {
		System.out.println(a);
	}

	public static void main(String args[]) {
		son xSon = new son();
		xSon.setdate();
		X.setDate(1);// 成员方法
		int k = X.a;
	}

}

class son extends mycout {
	void setdate() {
		setdate(1);
	}
}

abstract class Test {
	Test() {

	}
}

interface Test1 {
	int a = 1;

	void setDate();
}

class X implements Test1 {
	public void setDate() {
	}

	static void setDate(int a) {

	}
}