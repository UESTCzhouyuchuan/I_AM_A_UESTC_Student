package ������;
/*
 * ����һ������ѧ���࣬���о���ѧ����Ϣ��print������
 * ����ѧ���������ֱ�Ϊ�о�����ͱ������࣬
 * ���и��ǳ����print������ͨ����������ʵ�ֶ�̬��
 */
//����student
abstract class Student{
	String idNum;
	String name;
	void print() {
		System.out.println("IdNum: "+idNum+"\nname: "+name);
	}
}
//����
class Undergrade extends Student{
	void print() {
		System.out.println("Undergrade:");
		super.print();
	}
}
//����
class Aftergrade extends Student{
	//���ǳ���print()����
	void print() {
		System.out.println("Aftergrade:");
		//��̬
		super.print();
	}
}
public class ������ {
	public static void main(String[] args) {
		Undergrade test = new Undergrade();
		test.idNum="2017221302006";test.name="����";
		test.print();
	}

}
