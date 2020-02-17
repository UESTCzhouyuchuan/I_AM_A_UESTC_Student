package 第4章;
/*创建一个类，它有一个接受一个String参数的构造器。
 * 在构造阶段，打印该参数。创建一个该类的对象引用数组，
 * 并通过以下两种方式对该数组初始化：
"1、构造函数，2、创建对象赋值给该引用数组。*/
//导入包java.util的类接口
import java.util.*; 
//创建类Sample
class Sample{
	//带参数的构造函数
	Sample( String x ) {
		System.out.println(x);
	}
	//不带参数的构造函数
	Sample(){
		this("No String");
	}
}
public class 第一题 {
	public static void main ( String[] args) {
		Sample[] sam = new Sample[2];
		Scanner x = new Scanner(System.in);
		//利用new 创建对象赋值给引用数组 sam[2]
		sam[0] = new Sample(x.nextLine());
		sam[1] = new Sample();
		x.close();
		
	}
}
