package 第五章;

//抽象父类Person1类，可理解为基本类
abstract class Person1{
	//三个成员变量
	String name;
	char sex;
	int age;
	Person1(){
		name = "鑫鑫";
		sex ='g';
		age = 19;
	}
	//两个抽象函数
	abstract void setData(String name, char sex, int age);
	abstract String getData();
}
//子类Student1，可理解为扩展类
class Student1 extends Person1{
	//成员变量，学号，专业
	int sID;
	String speciality;
	//不带参构造函数
	Student1(){
		super();
		sID=1302006;
		speciality = "软件工程";
	}
	//带参数构造函数
	Student1(String name, char sex, int age, int sID, String speciality){
		this.name =name;
		this.sex = sex;
		this.age = age;
		this.sID = sID;
		this.speciality = speciality;
	}
	//实现父类抽象setDate函数
	void setData(String name, char sex, int age) {
		this.name =name;
		this.sex = sex;
		this.age = age;
	}
	//根据学生类成员变量扩展setData函数
	void setData(String name, char sex, int age, int sID, String speciality) {
		setData(name, sex, age);
		this.sID = sID;
		this.speciality = speciality;
	}
	//返回学生信息
	String getData() {
		// TODO Auto-generated method stub
		return ("name: "+name+"\tsex: "+sex+"\tage: "+age+"\tsID: "+sID+"\tspeciality: "+speciality);
	}
	
}
//子类Teacher,Person1的扩展类
class Teacher extends Person1{
	//成员变量老师编号，部门
	int tID;
	String department;
	//不带参构造函数
	Teacher(){
		super();
		tID=110;
		department = "教务处";
	}
	//带参数构造函数
	Teacher(String name, char sex, int age, int sID, String department){
		this.name =name;
		this.sex = sex;
		this.age = age;
		this.tID = sID;
		this.department = department;
	}
	//实现父类setData函数
	void setData(String name, char sex, int age) {
		// TODO Auto-generated method stub
		this.name = name;
		this.sex = sex;
		this.age =age;
	}
	//扩展setDate函数
	void seData(String name, char sex, int age, int sID, String department) {
		setData(name, sex, age);
		this.tID = sID;
		this.department = department;
	}
	//返回老师信息
	String getData() {
		// TODO Auto-generated method stub
		return ("name: "+name+"\tsex: "+sex+"\tage: "+age+"\tsID: "+tID+"\tdeaprtment: "+department);
		}
}
public class p5_10 {

	public static void main(String[] agrs) {
		//进行测试实验
		Student1 student = new Student1("玉川", 'b', 19,1302028,"软件工程");
		//Person1  person  = new Teacher() ;//不能用抽象类实例化 or 抽象类不能实例化,which one,也只能用子类实例
		Teacher  teacher = new Teacher() ;
		System.out.println("Student: "+student.getData()+"\n");
		//System.out.println("Person or Teacher: "+person.getData()+"\n");
		System.out.println("Teacher: "+teacher.getData()+"\nEND");
	}
}
