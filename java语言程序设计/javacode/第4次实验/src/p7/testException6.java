package p7;

class testNull {
	int k;

	public testNull() {
		// TODO Auto-generated constructor stub
		k = 5;
	}
}

public class testException6 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			int[] array = new int[5];
			int k = 0;
			int result = 521;
			testNull test = null;
			test.k = 521;// NullPointerException
			result = array[521];// IndexOutOfBoundsException
			result = result / k; // ArithmeticException
		} catch (ArithmeticException e) {
			System.err.println(e.getMessage());
			System.err.println(e.toString());
			e.printStackTrace();
		} catch (IndexOutOfBoundsException e) {
			System.err.println(e.getMessage());
			System.err.println(e.toString());
			e.printStackTrace();
		} catch (NullPointerException e) {
			System.err.println(e.getMessage());
			System.err.println(e.toString());
			e.printStackTrace();
		}

	}

}
