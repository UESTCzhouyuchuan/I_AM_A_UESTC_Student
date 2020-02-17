package 第二次实验;


public class TestArray {
	//创建一个main()方法
	public static void main(String [] args){
		int [] sim = new int[50];
		int i,j;
		int temp;
		//获得随机数赋值给int型数组
		for ( i = 0 ; i < 50 ; i++ ){
			sim[i] = (int)(Math.random()*100+1);
		}
		System.out.println("Before sort: ");
		for ( i = 0 ; i < 50 ; i++){
			System.out.print(sim[i]+((i+1)%10!=0 ? ",":"\n"));
		}
		//冒泡排序
		for ( i = 0 ; i < 50 ; i ++){
			for ( j = i+1 ; j < 50 ; j++){
				if (sim[i] > sim[j]){
					temp=sim[i];
					sim[i]=sim[j];
					sim[j]=temp;
				}
			}
		}
		System.out.println("\nAfter sort: ");
		for ( i = 0 ; i < 50 ; i++){
			System.out.print(sim[i]+((i+1)%10!=0 ? ",":"\n"));
		}
		
	}

}
