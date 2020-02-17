package 第六章;
/*
 * 以学生对象为基本元素，
 * 在P126-例6.3和P127-例6.4基础上，
 * 实现完整的先进先出队列代码。
 */
//学生对象
class Student{
	String name;
	String idNum;
}
//接口interface
interface Collection{
	int MAX_NUM = 100;
	void add(Student objAdd);
	void delete(Student objDelet);
	int find(Student objFind);
	int currentCount();
	boolean isEmpty();
	boolean isFull();
}
//队列
class FIFOQueue implements Collection{
	int rear = 0, front = 0;
	Student[] students = new Student[MAX_NUM];
	//添加
	public void add(Student objAdd) {

		if (isFull()) {
			System.out.println("No space");
		}
		else {
			rear = (rear + 1) % MAX_NUM;
			students[rear] = objAdd;
		}
	}
	//删除
	public void delete(Student objDelet) {
		int index = find(objDelet);
		if ( index == -1) {
			System.out.println("Not Found");	
		}
		else {
			int i = index ;
			if ( index > front ) {
				
				for ( ; i > front + 1 ; i--)
					students[i] = students[i-1];
				front = (front + 1) % MAX_NUM ;
			}
			else {
				for ( i = index ; i < rear ; i++)
					students[i] = students[i+1];
				rear = (rear -1) % MAX_NUM;
			}
		}
	}
	//判断存在
	public int find(Student objFind) {
		if (rear > front) {
			for (int i = front+1 ; i < rear + 1 ; i++) {
				if (students[i].equals(objFind)) {
					return i;
				}
			}
		}
		else if (front > rear) {
			int i;
			for ( i = front+1 ; i < MAX_NUM ; i++) 
				if (students[i].equals(objFind)) {
					return i;
				}
			for ( i = 0 ; i < rear +1 ; i++) 
				if (students[i].equals(objFind)) {
					return i;
				}
			}
			return -1 ;
	}
	//返回个数
	public int currentCount() {
		return ( rear >= front ? rear - front : rear - front +MAX_NUM );
	}
	//判断空
	public boolean isEmpty() {
		return (front == rear);
	}
	//判断满
	public boolean isFull() {
		return ((rear + 1 ) % MAX_NUM == front);
	}
}
//公共类
public class 队列 {
	public static void main(String[] args) {
		FIFOQueue test = new FIFOQueue();
		System.out.println(test.currentCount());
	}
}
