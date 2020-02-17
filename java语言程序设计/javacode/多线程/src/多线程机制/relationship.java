package ���̻߳���;
/*
 * ��java���̳߳������ģ�������ߺ������ߵĹ�ϵ������һ������Ϊ100�Ļ�������
 * ������������Producer�������壺ÿ������������д��һ��Ԫ�أ�������������Consumer����
 * ���壺ÿ�δӻ������ж���һ��Ԫ�ء���ʾ�������������������鶨�塣
 */

public  class relationship {
	int[] buffer = new int[100];//������
	int MAX_SIZE = 100;
	int top = -1;//����������
	relationship(){
		//Producer producer = new Producer(this);
		Consumer consumer = new Consumer(this);
		WriteThread write = new WriteThread(this);
		//producer.start();
		
		write.start();
		consumer.start();
		try {
			//producer.join();
			write.join();
			consumer.join();

		}catch(InterruptedException e) {}
		
	}
	//�ж���
	boolean isFull() {
		return top>= (MAX_SIZE-1);
	}
	//�жϿ�
	boolean isEmpty() {
		return top<=-1;
	}
	//дԪ��
		synchronized public  void addElem(int a) {
			if (isFull()) {
				System.out.println("The buffer is Full");
			}
			else {
				buffer[++top] = a;
				try {//д������󣬵ȴ�����
					notify();
					wait();
				}catch(InterruptedException e) {}
			}
			
		}
		//��Ԫ��
		synchronized public int popElem() {
				try {//��֮ǰ�ȴ�д������
					notify();
					wait();
				}catch(InterruptedException e) {}
			if (isEmpty()) {
				System.out.println("The buffer is Empty.");
				return 0;
			}
			else {
				System.out.print("top"+String.format("%-2d", top)+"-->");
				return buffer[top];
			}
			
			
		}
	public static void main(String[] args) {
		new relationship();
	}

}
class Producer extends Thread{
	relationship example;
	public Producer(relationship example){
		this.example = example;
	}
	//���������д������
	public void run() {
		int a = (int)(Math.random()*100+1);
		example.addElem(a);
	}
}
class Consumer extends Thread{
	relationship example;
	Consumer(relationship example){
		this.example = example;
	}
	int flag=0;
	//������
	public void run() {
		while(flag!=2)
		{
			System.out.println("����������Ϊ��"+example.popElem());
			if (example.isFull())flag++;
		}
		System.out.println("������ȫ������");
		
	}
}
class WriteThread extends Thread{
	relationship example;
	WriteThread(relationship example){
		this.example = example;
	}
	//д����
	public void run() {
		int a;
		while(!example.isFull()) {
			a =(int)(Math.random()*100+1);
			example.addElem(a);
		}
	}
}