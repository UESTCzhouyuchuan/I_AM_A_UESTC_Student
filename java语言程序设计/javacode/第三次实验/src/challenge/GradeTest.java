package challenge;

/*
 * ����ѧ���ɼ������漰���ࣺStudent�ࡢTeacher�ࡢCourse�࣬
 * ����Grade�ཫStudent�ࡢTeacher���Course�����������
 * ��GradeTest��������ĸ�����в��ԡ�
 */
//ѧ����
class Student {
	String name;
	char sex;
	int age;
	String speciality;
	int sID;

	// ������
	Student(String name, char sex, int age, int sID, String speciality) {
		this.name = name;
		this.sex = sex;
		this.age = age;
		this.sID = sID;
		this.speciality = speciality;
	}
}

//��ʦ��
class Teacher {
	String name;
	char sex;
	int age;
	int tID;
	String department;

	// Teacher��Ĺ�����
	Teacher(String name, char sex, int age, int sID, String department) {
		this.name = name;
		this.sex = sex;
		this.age = age;
		this.tID = sID;
		this.department = department;
	}
}

//�γ��� 
class Course {
	String name;
	int cID;

	// ������
	Course(String name, int cID) {
		this.name = name;
		this.cID = cID;
	}
}

//�ɼ���
class Grade {
	double grade;
	Student s;
	Teacher t;
	Course c;

	// ������,��ѧ����ʦ�γ��������һ��
	Grade(Student s, Teacher t, Course c, int grade) {
		this.grade = grade;
		this.c = c;
		this.t = t;
		this.s = s;
	}
}

//���Թ�����
public class GradeTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Initialization.....");
		Student student = new Student("��", 'b', 19, 1302028, "�������");
		Teacher teacher = new Teacher("Ǯΰ��", 'b', 32, 110, "����");
		Course course = new Course("java���Գ������", 521);
		Grade grade = new Grade(student, teacher, course, 98);
		System.out.println("��������ϢΪ��\n" + "Student:" + grade.s + "\nTeacher:" + grade.t + "\nCouse:	" + grade.c
				+ "\nGrade:	" + grade.grade);
	}

}
