package 多线程机制;
/*
 * 用java多线程程序机制模拟生产者和消费者的关系：建立一个长度为100的缓冲区，
 * 生产者类名（Producer），定义：每次往缓冲区中写入一个元素，消费者类名（Consumer），
 * 定义：每次从缓冲区中读出一个元素。提示：缓冲区可用整型数组定义。
 */

public  class relationship {
	int[] buffer = new int[100];//缓冲区
	int MAX_SIZE = 100;
	int top = -1;//缓冲区顶层
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
	//判断满
	boolean isFull() {
		return top>= (MAX_SIZE-1);
	}
	//判断空
	boolean isEmpty() {
		return top<=-1;
	}
	//写元素
		synchronized public  void addElem(int a) {
			if (isFull()) {
				System.out.println("The buffer is Full");
			}
			else {
				buffer[++top] = a;
				try {//写入操作后，等待读入
					notify();
					wait();
				}catch(InterruptedException e) {}
			}
			
		}
		//读元素
		synchronized public int popElem() {
				try {//读之前等待写入数据
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
	//利用随机数写入数据
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
	//读数据
	public void run() {
		while(flag!=2)
		{
			System.out.println("读出的数据为："+example.popElem());
			if (example.isFull())flag++;
		}
		System.out.println("数据已全部读出");
		
	}
}
class WriteThread extends Thread{
	relationship example;
	WriteThread(relationship example){
		this.example = example;
	}
	//写数据
	public void run() {
		int a;
		while(!example.isFull()) {
			a =(int)(Math.random()*100+1);
			example.addElem(a);
		}
	}
}