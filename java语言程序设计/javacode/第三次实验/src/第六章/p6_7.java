package ������;

// �ӿ�Print
interface Print {
	void print();
}

// ʵ����1doPrint1
class doPrint1 implements Print {

	public void print() {
		// TODO Auto-generated method stub
		int i, j;
		for (i = 1; i < 9; i++)
			for (j = 1; j < i + 1; j++)
				System.out.print(j + "*" + i + "=" + i * j + (i == j ? '\n' : ' '));
	}
}

// ʵ����2doPrint2
class doPrint2 implements Print {
	// ʵ�ִ�ӡ����
	public void print() {
		// TODO Auto-generated method stub
		System.out.println("I love Java!");
	}
}

public class p6_7 {
	public static void main(String[] args) {
		// ���в���
		// Print t = new Print() ; //�ӿڲ��ܱ��Լ�ʵ����
//		Print t = new doPrint1(); // ������ʵ����ʵ����
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
