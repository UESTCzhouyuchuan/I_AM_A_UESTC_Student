package ��4��;
/*
 * ��ѧ����Ϊ����������Ա������ѧ�š��������Ա����䡢���ã����а���Ϊö�����ͣ�ΪFootball,Basketball,Dancing,Music�ļ��ϡ�
���ڶ���ѧ���������ʵ�ֹ��캯���Ĺ��أ���ʵ�ֲ�����ѧ����������Ա����System.out.println()������ѧ�������ֱ���ַ��������ʾ���ܡ�

 */
//����Ϊö�����ͣ�ΪFootball,Basketball,Dancing,Music�ļ���
enum Hobby {
	Football,Basketball,Dancing,Music
}
//ѧ����
class Student{
	String idNumber;//ѧ��
	String name;//����
	int year;//����
	Hobby hobby;//���ã�ö������
	//���캯������
	Student(String idNumber, String name,int year,Hobby hobby){
		this.idNumber=idNumber;this.name=name;this.year=year;this.hobby=hobby;
	}
	Student(String idNumber, String name,Hobby hobby){
		this.idNumber=idNumber;this.name=name;this.hobby=hobby;
	}
	Student(String idNumber, String name,int year){
		this.idNumber=idNumber;this.name=name;this.year=year;
	}
	Student(int year,Hobby hobby){
		this.year=year;this.hobby=hobby;
	}
	Student(String idNumber, String name ){
		this.idNumber=idNumber;this.name=name;
	}
	Student(int year){
		this.year = year;
	}
	Student (Hobby hobby){
		this.hobby = hobby;
	}
	void Print(){
		System.out.println("idNumber:"+idNumber+"\nname:"+name+"\nyear:"+year+"\nhobby:"+hobby);
	}
}
public class �ڶ��� {
	public static void main(String[] args) {
		Student test = new Student("2017221302006","����",19,Hobby.Dancing);
		test.Print();
	}

}
