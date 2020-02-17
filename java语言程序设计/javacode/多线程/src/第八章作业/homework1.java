package 第八章作业;
/*
 * 请写一程序，用Runnable接口实现一个实现9*9乘法的类Print99，main()创建三个新线程，
 * 用同一个类Print99对象为参数，实例化Thread子类对象，三个线程分别实现：
 * 线程1：屏幕输出99乘法表前3行，线程2：屏幕输出99乘法表4~6行，线程3：屏幕输出99乘法表7~9行。
 * 用wait()和notify()方法控制线程间通信，使无论线程如何被调度，输出乘法表为正确的形式。
 */
public class homework1 {
	homework1(){
		Print99 t1 = new Print99();
		//三个进程使用一个对象
		Thread first = new Thread(t1,"first");
		Thread second = new Thread(t1,"second");
		Thread third = new Thread(t1,"third");
		first.start();
		second.start();
		third.start();
	}
	public static void main(String[] args) {
		new homework1();
	}

}

class Print99 implements Runnable{
	int i=1,j;
	public synchronized void run() {
		try {
			Thread t = Thread.currentThread();
			System.out.println("Notify");
			synchronized(this) {
				notify();//防止进程全部在阻塞态
			}
			if (!t.getName().equalsIgnoreCase("first"))//第一个进程先进行
				synchronized(this) {
					System.out.println("Thread"+t.getName()+" wait()");
					wait();
				}
			if (t.getName().equalsIgnoreCase("third")) {//让third进程排在second后面
				notify();
				System.out.println("Notify");
				System.out.println("Threadthird wait");
				wait();
			}
			while(true) {
				System.out.print("currentThread"+ String.format("%-6s", t.getName())+": ");
			for ( j = 1 ; j < i+1 ; j++)
				System.out.print(j+"*"+i+"="+i*j+(i==j?"\n":" "));
			if ( i%3 ==0 ) {
				synchronized(this) {
					notify();//唤醒其他进程
					System.out.println("Notify");
					i++;
					break;
				}
			}
			i++;
		}
	}catch(InterruptedException e) {}
	}
}


