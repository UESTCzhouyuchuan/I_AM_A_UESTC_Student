package ��������ҵ;
/*
 * ����һ�������࣬����ʵ�ֶ�����Խ���쳣�ļ��Ӻ��׳���
 * ���ڵ��ó�������쳣���д���
 */
//�����࣬�׳��쳣
class tryArrayTest{
	tryArrayTest(){
	int[] array = new int[4] ;
	try {
		array[521] = 11;
		
	}catch(ArrayIndexOutOfBoundsException e) {
		throw e;//�׳��쳣
	}
	}
}
public class arrayIndexOutOfBounds {
	public static void main(String[] args) {
		//���������в����쳣
		try{
			new tryArrayTest();
		}catch(ArrayIndexOutOfBoundsException e) {//�����쳣
			System.err.println("Exception msg: "+ e.getMessage());
			System.err.println("Exception string: " + e.toString());
			System.err.println("Exception StackTrace: ");
			e.printStackTrace();
		}
	}

}
