package 第八章作业;
/*
 * 请写一个程序，用wait()和notify()方法控制线程之间的通信
 */
import java.lang.Runnable;
import java.lang.Thread;

public class DemoThread implements Runnable{
	public DemoThread() {
		TestThread testthread1 = new TestThread(this,"1");
		TestThread testthread2 = new TestThread(this,"2");
		testthread1.start();
		testthread2.start();
	}
	public static void main(String[] args) {
		new DemoThread();
	}
	public void run() {
		TestThread t= (TestThread)Thread.currentThread();
		try {
			if (t.getName().equalsIgnoreCase("1")) {
				synchronized(this) {
					wait();//线程锁，wait()方法，需异常处理
				}
			}
			while(true) {
				System.out.println("@time in thread"+t.getName()
				                           +"="+t.increaseTime());
				if(t.getTime()%10==0) {
					synchronized(this){
						System.out.println("************");
						notify();
						if (t.getTime()==100)break;
						wait();
					}
				}
			}
			
		}catch(Exception e) {e.printStackTrace();}
	}
}
class TestThread extends Thread{
	private int time =0;
	public TestThread(Runnable r, String name) {
		super(r,name);
	}
	public int getTime() {
		return time;
	}
	public int increaseTime() {
		return ++time;
	}
}