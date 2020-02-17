package 多线程机制;

public class RunTest {
	public RunTest() {
		FirstThread2 f1 = new FirstThread2();
		SecondThread2 s1 = new SecondThread2();
		Thread first = new Thread(f1);
		Thread second = new Thread(s1);
		first.start();
		second.start();
	}
	public static void main(String[] args) {
		new RunTest();
	}

}
class FirstThread2 implements Runnable{

	public void run() {
		try {
			System.out.println("First thread starts running.");
			for ( int i =0 ; i < 6 ;i++) {
				System.out.println("First" + i);
				Thread.sleep(1000);
			}
			System.out.println("First thread finished running.");
		}catch(InterruptedException e) {}
	}

	
}
class SecondThread2 implements Runnable{

	public void run() {
		try {
			System.out.println("\tSecond thread starts running.");
			for ( int i =0 ; i < 6 ;i++) {
				System.out.println("\tSecond" + i);
				Thread.sleep(1000);
			}
			System.out.println("\tSecond thread finished running.");
		}catch(InterruptedException e) {}
	}

	
}
