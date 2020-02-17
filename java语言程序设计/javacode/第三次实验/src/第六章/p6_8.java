package 第六章;

//接口Person类
interface Person{
	//两个方法
	void setData(String name, char sex, String birthday);
	String getData();
}
//实现函数Student
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
//测试公共类
public class p6_8 {
	public static void main(String[] args) {
		//实例化student
		Student student = new Student();
		student.setData("周玉川", 'b', "20000429", 221302006, "软件工程");
		System.out.println("Student's date: "+student.getData());
	}

}
