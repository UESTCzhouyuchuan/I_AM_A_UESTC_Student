package 第五章;

public class p5_9 {

	public static void main(String[] args) {
		// 实例化Person类对象person
		Person person = new Person("周玉川", 'b', 19);
		// 查看date
		System.out.println("the person's date: " + person.getDate());
		// 实例化Student类对象student
		Student student = new Student();
		// 信息setDate提示
		System.out.println("<----Set student's date---->");
		student.setDate("zhouyuchuan", 'b', 19, 221302006, 221302);
		// 输出学生信息
		System.out.println("the student's date: " + student.getDate());

	}

}

//person类
class Person {
	// 三个成员变量
	String name;
	char sex;
	int age;

	// 带参数构造函数
	Person(String name, char sex, int age) {
		this.name = name;
		this.sex = sex;
		this.age = age;
	}

	// 不带参数构造函数
	Person() {
		this("鑫鑫", 'g', 19);
	}

	// 成员方法，设置信息
	void seDate(String name, char sex, int age) {
		this.name = name;
		this.sex = sex;
		this.age = age;
	}

	// 成员方法，得到信息
	String getDate() {
		return ("Name:" + name + "\tSex:" + sex + "\tAge" + age);
	}
}

//Person的子类Student类
class Student extends Person {
	// 5个成员变量，三个在父类中
	int sID;
	int classNo;

	// 不带参数构造函数
	Student() {
		super();
		sID = 0000;
		classNo = 00;
	}

	// 带参数构造函数
	Student(String name, char sex, int age, int sID, int classNo) {
		super(name, sex, age);
		this.sID = sID;
		this.classNo = classNo;
	}

	// 成员方法，setDate设置信息
	void setDate(String name, char sex, int age, int sID, int classNo) {
		super.seDate(name, sex, age);
		this.sID = sID;
		this.classNo = classNo;
	}

	// 成员方法，获得信息getDate
	String getDate() {
		return (super.getDate() + "\tsID" + sID + "\tclassNo:" + classNo);
	}
}
//结束End