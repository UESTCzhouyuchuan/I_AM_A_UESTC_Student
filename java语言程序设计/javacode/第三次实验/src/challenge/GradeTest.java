package challenge;

/*
 * 创建学生成绩中所涉及的类：Student类、Teacher类、Course类，
 * 并由Grade类将Student类、Teacher类和Course类关联起来，
 * 由GradeTest类对以上四个类进行测试。
 */
//学生类
class Student {
	String name;
	char sex;
	int age;
	String speciality;
	int sID;

	// 构造器
	Student(String name, char sex, int age, int sID, String speciality) {
		this.name = name;
		this.sex = sex;
		this.age = age;
		this.sID = sID;
		this.speciality = speciality;
	}
}

//老师类
class Teacher {
	String name;
	char sex;
	int age;
	int tID;
	String department;

	// Teacher类的构造器
	Teacher(String name, char sex, int age, int sID, String department) {
		this.name = name;
		this.sex = sex;
		this.age = age;
		this.tID = sID;
		this.department = department;
	}
}

//课程类 
class Course {
	String name;
	int cID;

	// 构造器
	Course(String name, int cID) {
		this.name = name;
		this.cID = cID;
	}
}

//成绩类
class Grade {
	double grade;
	Student s;
	Teacher t;
	Course c;

	// 构造器,把学生老师课程类关联在一起
	Grade(Student s, Teacher t, Course c, int grade) {
		this.grade = grade;
		this.c = c;
		this.t = t;
		this.s = s;
	}
}

//测试公共类
public class GradeTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Initialization.....");
		Student student = new Student("玉川", 'b', 19, 1302028, "软件工程");
		Teacher teacher = new Teacher("钱伟中", 'b', 32, 110, "教务处");
		Course course = new Course("java语言程序设计", 521);
		Grade grade = new Grade(student, teacher, course, 98);
		System.out.println("关联后信息为：\n" + "Student:" + grade.s + "\nTeacher:" + grade.t + "\nCouse:	" + grade.c
				+ "\nGrade:	" + grade.grade);
	}

}
