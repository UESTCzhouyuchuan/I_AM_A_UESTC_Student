package throw和throws语句;

import java.util.*;//使用Scanner
public class ThrowTest {
	
	public static void main(String[] args) {
		int aver = 0;
		int[] marks = new int[50];
		int count = 0;
		System.out.println("输入数字：");
		Scanner x = new Scanner(System.in);
		//规定输入分数，然后自动输出平均分
		try {
			while(x.hasNextInt()&&x.hasNextLine()) {
				marks[count] = x.nextInt();
				if (marks[count] > 100 || marks[count] < 0) {
					//分数不合法抛出异常
					throw new IllegalMarkException();
				}
				count++;
			}
			
			for (int k = 0 ; k < count ; k++) {
				//k大于等于50时，数组越界，抛出该异常
				aver += marks[k];
			}
			//除零代表没输入分数，抛出该异常
			aver = aver/count;
			System.out.println("这"+count+"个学生的平均分为: "+aver);
		}catch(ArrayIndexOutOfBoundsException e) {
			System.out.println("程序只能输入50个分数");
		}catch (ArithmeticException e) {
			System.out.println("没有输入分数");
		}catch (IllegalMarkException e) {
			System.out.println("不合法的分数：" + marks[count] +"\t分数应该在0--100之间");
		}
		finally{
			x.close();
		}
	}
}
//自定义异常类，分数不合法。
final class IllegalMarkException extends Throwable{
	IllegalMarkException() {
		
	}
}
