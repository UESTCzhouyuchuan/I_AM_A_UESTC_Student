package �ڰ�����ҵ;
/*
 * ��дһ������Runnable�ӿ�ʵ��һ��ʵ��9*9�˷�����Print99��main()�����������̣߳�
 * ��ͬһ����Print99����Ϊ������ʵ����Thread������������̷ֱ߳�ʵ�֣�
 * �߳�1����Ļ���99�˷���ǰ3�У��߳�2����Ļ���99�˷���4~6�У��߳�3����Ļ���99�˷���7~9�С�
 * ��wait()��notify()���������̼߳�ͨ�ţ�ʹ�����߳���α����ȣ�����˷���Ϊ��ȷ����ʽ��
 */
public class homework1 {
	homework1(){
		Print99 t1 = new Print99();
		//��������ʹ��һ������
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
				notify();//��ֹ����ȫ��������̬
			}
			if (!t.getName().equalsIgnoreCase("first"))//��һ�������Ƚ���
				synchronized(this) {
					System.out.println("Thread"+t.getName()+" wait()");
					wait();
				}
			if (t.getName().equalsIgnoreCase("third")) {//��third��������second����
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
					notify();//������������
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


