package 多线程机制;

public class ThreadTest2 {
	@SuppressWarnings("deprecation")
	public ThreadTest2() {
		FirstThread1 first = new FirstThread1();
		SecondThread1 second = new SecondThread1();
		first.start();
		second.start();
		try {
			System.out.println("Waiting for first thread to finish.");
			first.join();
			System.out.println("Wake up second thread...");
			second.resume();
		}catch(InterruptedException e) {}
	}
	public static void main(String[] args) {
		new ThreadTest2();
	}

}
class FirstThread1 extends Thread{
	public void run() {
		try {
			System.out.println("First thread STARTS running.");
			for (int i = 0; i < 6 ; i++) {
				System.out.println("First"+i);
				sleep(1000);
			}
			System.out.println("First thread FINISHES running.");
		}catch (InterruptedException e) {}
	}
	
}
class SecondThread1 extends Thread{
	@SuppressWarnings("deprecation")
	public void run() {
		try {
			System.out.println("\tSecond thread STARTS running.");
			for (int i = 0; i < 6 ; i++) {
				if (i == 4) {
					System.out.println("\tSecond thread SUSPENDS itself.");
					suspend();
				}
				System.out.println("\tSecond"+i);
				sleep(1000);
				
			}
			System.out.println("\tSecond thread FINISFES running.");
		}catch (InterruptedException e) {}
	}
}