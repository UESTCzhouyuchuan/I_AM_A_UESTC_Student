package 第八章作业;
/*
 * 编写一个多线程的程序：启动4个线程。其中两个循环10次，每次将全局变量加一，
 * 另两个循环10次，每次将次全局变量减1 .
 * 请输出该变量的变化结果
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
//加法线程
class AddThread extends Thread{
	public AddThread(try8_2 t) {
		System.out.println("AddThread begins:");
		for ( int i=0 ; i < 10 ; i++) {
			System.out.println("global = "+ ++(t.global));
		}
		System.out.println("AddThread stops.\n");
	}
}
//减法法线程
class MinusThread extends Thread{
	public MinusThread(try8_2 t) {
		System.out.println("MinusThread begins:");
		for ( int i=0 ; i < 10 ; i++) {
			System.out.println("global = "+ --(t.global));
		}
		System.out.println("MinusThread stops.\n");
	}
}