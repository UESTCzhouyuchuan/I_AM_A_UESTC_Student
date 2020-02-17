package 第五章;
/*创建一个超类，它仅有一个非默认的构造器；
 * 再创建一个子类，它带有默认构造器和非默认构造器。
 * 在子类的构造器中调用超类的构造器。
 */
class father{
	father(){
		System.out.println("I love xinxin");
	}
}
class son extends father{
	son(){
		super();
	}
}
public class 第二题 {
	public static void main(String[] args) {
		son test = new son();
	}

}
