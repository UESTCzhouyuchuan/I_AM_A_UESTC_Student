package ������;
/*
 * ��ѧ������Ϊ����Ԫ�أ�
 * ��P126-��6.3��P127-��6.4�����ϣ�
 * ʵ���������Ƚ��ȳ����д��롣
 */
//ѧ������
class Student{
	String name;
	String idNum;
}
//�ӿ�interface
interface Collection{
	int MAX_NUM = 100;
	void add(Student objAdd);
	void delete(Student objDelet);
	int find(Student objFind);
	int currentCount();
	boolean isEmpty();
	boolean isFull();
}
//����
class FIFOQueue implements Collection{
	int rear = 0, front = 0;
	Student[] students = new Student[MAX_NUM];
	//���
	public void add(Student objAdd) {

		if (isFull()) {
			System.out.println("No space");
		}
		else {
			rear = (rear + 1) % MAX_NUM;
			students[rear] = objAdd;
		}
	}
	//ɾ��
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
	//�жϴ���
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
	//���ظ���
	public int currentCount() {
		return ( rear >= front ? rear - front : rear - front +MAX_NUM );
	}
	//�жϿ�
	public boolean isEmpty() {
		return (front == rear);
	}
	//�ж���
	public boolean isFull() {
		return ((rear + 1 ) % MAX_NUM == front);
	}
}
//������
public class ���� {
	public static void main(String[] args) {
		FIFOQueue test = new FIFOQueue();
		System.out.println(test.currentCount());
	}
}
