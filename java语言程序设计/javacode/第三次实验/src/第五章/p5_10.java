package ������;

//������Person1�࣬�����Ϊ������
abstract class Person1{
	//������Ա����
	String name;
	char sex;
	int age;
	Person1(){
		name = "����";
		sex ='g';
		age = 19;
	}
	//����������
	abstract void setData(String name, char sex, int age);
	abstract String getData();
}
//����Student1�������Ϊ��չ��
class Student1 extends Person1{
	//��Ա������ѧ�ţ�רҵ
	int sID;
	String speciality;
	//�����ι��캯��
	Student1(){
		super();
		sID=1302006;
		speciality = "�������";
	}
	//���������캯��
	Student1(String name, char sex, int age, int sID, String speciality){
		this.name =name;
		this.sex = sex;
		this.age = age;
		this.sID = sID;
		this.speciality = speciality;
	}
	//ʵ�ָ������setDate����
	void setData(String name, char sex, int age) {
		this.name =name;
		this.sex = sex;
		this.age = age;
	}
	//����ѧ�����Ա������չsetData����
	void setData(String name, char sex, int age, int sID, String speciality) {
		setData(name, sex, age);
		this.sID = sID;
		this.speciality = speciality;
	}
	//����ѧ����Ϣ
	String getData() {
		// TODO Auto-generated method stub
		return ("name: "+name+"\tsex: "+sex+"\tage: "+age+"\tsID: "+sID+"\tspeciality: "+speciality);
	}
	
}
//����Teacher,Person1����չ��
class Teacher extends Person1{
	//��Ա������ʦ��ţ�����
	int tID;
	String department;
	//�����ι��캯��
	Teacher(){
		super();
		tID=110;
		department = "����";
	}
	//���������캯��
	Teacher(String name, char sex, int age, int sID, String department){
		this.name =name;
		this.sex = sex;
		this.age = age;
		this.tID = sID;
		this.department = department;
	}
	//ʵ�ָ���setData����
	void setData(String name, char sex, int age) {
		// TODO Auto-generated method stub
		this.name = name;
		this.sex = sex;
		this.age =age;
	}
	//��չsetDate����
	void seData(String name, char sex, int age, int sID, String department) {
		setData(name, sex, age);
		this.tID = sID;
		this.department = department;
	}
	//������ʦ��Ϣ
	String getData() {
		// TODO Auto-generated method stub
		return ("name: "+name+"\tsex: "+sex+"\tage: "+age+"\tsID: "+tID+"\tdeaprtment: "+department);
		}
}
public class p5_10 {

	public static void main(String[] agrs) {
		//���в���ʵ��
		Student1 student = new Student1("��", 'b', 19,1302028,"�������");
		//Person1  person  = new Teacher() ;//�����ó�����ʵ���� or �����಻��ʵ����,which one,Ҳֻ��������ʵ��
		Teacher  teacher = new Teacher() ;
		System.out.println("Student: "+student.getData()+"\n");
		//System.out.println("Person or Teacher: "+person.getData()+"\n");
		System.out.println("Teacher: "+teacher.getData()+"\nEND");
	}
}
