package ������;

//�ӿ�Person��
interface Person{
	//��������
	void setData(String name, char sex, String birthday);
	String getData();
}
//ʵ�ֺ���Student
class Student implements Person{
	String name;
	char sex;
	String birthday;
	int sID ;
	String speciality;

	public void setData(String name, char sex, String birthday) {
		// TODO Auto-generated method stub
		this.name = name;
		this.sex= sex;
		this.birthday= birthday;
	}
	void setData(String name, char sex, String birthday, int sID, String speciality) {
		setData(name, sex, birthday);
		this.sID  = sID;
		this.speciality = speciality;
	}
	public String getData() {
		// TODO Auto-generated method stub
		return ("name:"+name+"\tsex: "+sex+"\tbirthday: "+birthday+"\tsID: "+sID+"\tspeciality: "+speciality);
	}
}
//���Թ�����
public class p6_8 {
	public static void main(String[] args) {
		//ʵ����student
		Student student = new Student();
		student.setData("����", 'b', "20000429", 221302006, "�������");
		System.out.println("Student's date: "+student.getData());
	}

}
