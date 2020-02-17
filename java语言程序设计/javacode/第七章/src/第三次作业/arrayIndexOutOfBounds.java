package 第三次作业;
/*
 * 定义一个数组类，可以实现对数组越界异常的监视和抛出，
 * 并在调用程序里对异常进行处理。
 */
//数组类，抛出异常
class tryArrayTest{
	tryArrayTest(){
	int[] array = new int[4] ;
	try {
		array[521] = 11;
		
	}catch(ArrayIndexOutOfBoundsException e) {
		throw e;//抛出异常
	}
	}
}
public class arrayIndexOutOfBounds {
	public static void main(String[] args) {
		//在主程序中捕获异常
		try{
			new tryArrayTest();
		}catch(ArrayIndexOutOfBoundsException e) {//处理异常
			System.err.println("Exception msg: "+ e.getMessage());
			System.err.println("Exception string: " + e.toString());
			System.err.println("Exception StackTrace: ");
			e.printStackTrace();
		}
	}

}
