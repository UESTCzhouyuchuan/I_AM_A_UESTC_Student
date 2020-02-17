package 多线程机制;

public class ThreadTest1 {
	public ThreadTest1() {
		FirstThread first = new FirstThread();
		SecondThread second = new SecondThread();
		first.start();
		second.start();
/*		second.start();
		first.start();
		Second thread starts running.
	Second0
First thread starts running.
First0
	Second1
First1
	Second2
First2
	Second3
First3
	Second4
First4
First5
	Second5
	Second6
First6
	Second7
First7
	Second8
First8
	Second9
First9
	Second thread finishes running.
First thread finishes running.
		*/
	}

	public static void main(String[] args) {
		new ThreadTest1();

	}

}
class FirstThread extends Thread{
	public void run() {
		try {//防止进程转换出现问题，异常处理一下
			System.out.println("First thread starts running.");
			for (int i = 0 ; i<10 ; i++) {
				System.out.println("First" + i);
				sleep(1000);
			}
			System.out.println("First thread finishes running.");
		}catch(InterruptedException e) {}
	}
}
class SecondThread extends Thread{
	public void run() {
		try {//防止进程转换出现问题，异常处理一下
			System.out.println("\tSecond thread starts running.");
			for (int i = 0 ; i<10 ; i++) {
				System.out.println("\tSecond" + i);
				sleep(1000);
			}
			System.out.println("\tSecond thread finishes running.");
		}catch(InterruptedException e) {}
	}
}
