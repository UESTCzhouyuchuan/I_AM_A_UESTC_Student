package throw��throws���;

import java.util.*;//ʹ��Scanner
public class ThrowTest {
	
	public static void main(String[] args) {
		int aver = 0;
		int[] marks = new int[50];
		int count = 0;
		System.out.println("�������֣�");
		Scanner x = new Scanner(System.in);
		//�涨���������Ȼ���Զ����ƽ����
		try {
			while(x.hasNextInt()&&x.hasNextLine()) {
				marks[count] = x.nextInt();
				if (marks[count] > 100 || marks[count] < 0) {
					//�������Ϸ��׳��쳣
					throw new IllegalMarkException();
				}
				count++;
			}
			
			for (int k = 0 ; k < count ; k++) {
				//k���ڵ���50ʱ������Խ�磬�׳����쳣
				aver += marks[k];
			}
			//�������û����������׳����쳣
			aver = aver/count;
			System.out.println("��"+count+"��ѧ����ƽ����Ϊ: "+aver);
		}catch(ArrayIndexOutOfBoundsException e) {
			System.out.println("����ֻ������50������");
		}catch (ArithmeticException e) {
			System.out.println("û���������");
		}catch (IllegalMarkException e) {
			System.out.println("���Ϸ��ķ�����" + marks[count] +"\t����Ӧ����0--100֮��");
		}
		finally{
			x.close();
		}
	}
}
//�Զ����쳣�࣬�������Ϸ���
final class IllegalMarkException extends Throwable{
	IllegalMarkException() {
		
	}
}
