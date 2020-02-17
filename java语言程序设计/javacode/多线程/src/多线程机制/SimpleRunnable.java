package 多线程机制;

public class SimpleRunnable implements Runnable {
	private String message;
	public static void main(String args[]) {
		SimpleRunnable r1 = new SimpleRunnable("Hello!");
		Thread t1 = new Thread(r1);
		t1.start();
	}
	public SimpleRunnable(String message) {
		this.message = message;
		
	}
	public void run() {
		for(;;) {
			System.out.println(message);
		}
	}

}
