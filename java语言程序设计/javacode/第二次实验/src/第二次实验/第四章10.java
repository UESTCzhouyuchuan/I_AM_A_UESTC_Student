package �ڶ���ʵ��;

class ArraySort{
	int[] sim = new int[20];
	//���캯���������������ʼ������
	ArraySort(){
		for ( int i = 0 ; i < 20 ; i++ ){
			sim[i] = (int)(Math.random()*100+1);
		}
	}
	//����������
	void setOrder(){
		int i,j;
		int temp;
		//ð������
		for ( i = 0 ; i < 20 ; i ++){
			for ( j = i+1 ; j < 20 ; j++){
				if (sim[i] > sim[j]){
					temp=sim[i];
					sim[i]=sim[j];
					sim[j]=temp;
				}
		   }
	  }
   }
}
public class ������10 {
	public static void main(String [] args){
		ArraySort test = new ArraySort();
		//����ǰ
		System.out.println("Before sort: ");
		for ( int i = 0 ; i < 20 ; i++ ){
			System.out.print(test.sim[i]+",");
		}
		test.setOrder();
		//�����
		System.out.println("\nAfter sort: ");
		for ( int i = 0 ; i < 20 ; i++ ){
			System.out.print(test.sim[i]+",");
		}
	}

}
