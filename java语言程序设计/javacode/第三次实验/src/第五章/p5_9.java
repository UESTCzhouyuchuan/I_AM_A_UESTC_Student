package ������;

public class p5_9 {

	public static void main(String[] args) {
		// ʵ����Person�����person
		Person person = new Person("����", 'b', 19);
		// �鿴date
		System.out.println("the person's date: " + person.getDate());
		// ʵ����Student�����student
		Student student = new Student();
		// ��ϢsetDate��ʾ
		System.out.println("<----Set student's date---->");
		student.setDate("zhouyuchuan", 'b', 19, 221302006, 221302);
		// ���ѧ����Ϣ
		System.out.println("the student's date: " + student.getDate());

	}

}

//person��
class Person {
	// ������Ա����
	String name;
	char sex;
	int age;

	// ���������캯��
	Person(String name, char sex, int age) {
		this.name = name;
		this.sex = sex;
		this.age = age;
	}

	// �����������캯��
	Person() {
		this("����", 'g', 19);
	}

	// ��Ա������������Ϣ
	void seDate(String name, char sex, int age) {
		this.name = name;
		this.sex = sex;
		this.age = age;
	}

	// ��Ա�������õ���Ϣ
	String getDate() {
		return ("Name:" + name + "\tSex:" + sex + "\tAge" + age);
	}
}

//Person������Student��
class Student extends Person {
	// 5����Ա�����������ڸ�����
	int sID;
	int classNo;

	// �����������캯��
	Student() {
		super();
		sID = 0000;
		classNo = 00;
	}

	// ���������캯��
	Student(String name, char sex, int age, int sID, int classNo) {
		super(name, sex, age);
		this.sID = sID;
		this.classNo = classNo;
	}

	// ��Ա������setDate������Ϣ
	void setDate(String name, char sex, int age, int sID, int classNo) {
		super.seDate(name, sex, age);
		this.sID = sID;
		this.classNo = classNo;
	}

	// ��Ա�����������ϢgetDate
	String getDate() {
		return (super.getDate() + "\tsID" + sID + "\tclassNo:" + classNo);
	}
}
//����End