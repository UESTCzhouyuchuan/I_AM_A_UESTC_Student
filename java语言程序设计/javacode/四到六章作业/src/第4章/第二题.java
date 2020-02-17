package 第4章;
/*
 * 以学生类为例，基本成员包括：学号、姓名、性别、年龄、爱好，其中爱好为枚举类型，为Football,Basketball,Dancing,Music的集合。
试在定义学生类基础上实现构造函数的过载，并实现不访问学生对象具体成员，用System.out.println()方法对学生对象的直接字符串输出显示功能。

 */
//爱好为枚举类型，为Football,Basketball,Dancing,Music的集合
enum Hobby {
	Football,Basketball,Dancing,Music
}
//学生类
class Student{
	String idNumber;//学号
	String name;//姓名
	int year;//年龄
	Hobby hobby;//爱好，枚举类型
	//构造函数过载
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
public class 第二题 {
	public static void main(String[] args) {
		Student test = new Student("2017221302006","周玉川",19,Hobby.Dancing);
		test.Print();
	}

}
