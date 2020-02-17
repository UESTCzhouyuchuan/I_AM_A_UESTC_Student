package 第二次实验;

class ArraySort{
	int[] sim = new int[20];
	//构造函数中利用随机数初始化数组
	ArraySort(){
		for ( int i = 0 ; i < 20 ; i++ ){
			sim[i] = (int)(Math.random()*100+1);
		}
	}
	//对数组排序
	void setOrder(){
		int i,j;
		int temp;
		//冒泡排序
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
public class 第四章10 {
	public static void main(String [] args){
		ArraySort test = new ArraySort();
		//排序前
		System.out.println("Before sort: ");
		for ( int i = 0 ; i < 20 ; i++ ){
			System.out.print(test.sim[i]+",");
		}
		test.setOrder();
		//排序后
		System.out.println("\nAfter sort: ");
		for ( int i = 0 ; i < 20 ; i++ ){
			System.out.print(test.sim[i]+",");
		}
	}

}
