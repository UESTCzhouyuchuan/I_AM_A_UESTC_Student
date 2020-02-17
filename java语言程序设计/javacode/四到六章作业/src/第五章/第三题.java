package 第五章;
/*
 * 创建一个抽象学生类，其中具有学生信息及print方法，
 * 创建学生类的子类分别为研究生类和本科生类，
 * 其中覆盖超类的print方法，通过超类引用实现多态。
 */
//超类student
abstract class Student{
	String idNum;
	String name;
	void print() {
		System.out.println("IdNum: "+idNum+"\nname: "+name);
	}
}
//子类
class Undergrade extends Student{
	void print() {
		System.out.println("Undergrade:");
		super.print();
	}
}
//子类
class Aftergrade extends Student{
	//覆盖超类print()函数
	void print() {
		System.out.println("Aftergrade:");
		//多态
		super.print();
	}
}
public class 第三题 {
	public static void main(String[] args) {
		Undergrade test = new Undergrade();
		test.idNum="2017221302006";test.name="周玉川";
		test.print();
	}

}
