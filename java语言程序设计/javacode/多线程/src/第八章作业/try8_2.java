package �ڰ�����ҵ;
/*
 * ��дһ�����̵߳ĳ�������4���̡߳���������ѭ��10�Σ�ÿ�ν�ȫ�ֱ�����һ��
 * ������ѭ��10�Σ�ÿ�ν���ȫ�ֱ�����1 .
 * ������ñ����ı仯���
 */

public class try8_2 {
	int global = 0;
	public try8_2 (){
		AddThread firstAdd = new AddThread(this);
		AddThread secondAdd = new AddThread(this);
		MinusThread firstMinus = new MinusThread(this);
		MinusThread secondMinus = new MinusThread(this);
		firstAdd.start();
		secondAdd.start();
		firstMinus.start();
		secondMinus.start();
		try {
			firstAdd.join();
			secondAdd.join();
			firstMinus.join();
			secondMinus.join();
		}catch(InterruptedException e) {}
		
	}
	public static void main(String[] args) {
		new try8_2();
	}

}
//�ӷ��߳�
class AddThread extends Thread{
	public AddThread(try8_2 t) {
		System.out.println("AddThread begins:");
		for ( int i=0 ; i < 10 ; i++) {
			System.out.println("global = "+ ++(t.global));
		}
		System.out.println("AddThread stops.\n");
	}
}
//�������߳�
class MinusThread extends Thread{
	public MinusThread(try8_2 t) {
		System.out.println("MinusThread begins:");
		for ( int i=0 ; i < 10 ; i++) {
			System.out.println("global = "+ --(t.global));
		}
		System.out.println("MinusThread stops.\n");
	}
}