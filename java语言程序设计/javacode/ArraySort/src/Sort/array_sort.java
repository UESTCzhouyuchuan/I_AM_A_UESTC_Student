package Sort;
//随机数
import java.util.Random;

class array_sort{
	//冒泡排序
	void sort1(int[]a) {
			int l=a.length;
			int i,j;
			for ( i = 0; i < l; i++)
				for ( j = i+1; j < l ; j++)
				{
					if (a[i] > a[j])
					{
						int tmp=a[i];
						a[i]=a[j];
						a[j]=tmp;
					}
				}
		}

	public static void main(String args[])
	{
		//利用随机数creat一个数组
		Random rand =new Random();
		int[] sim = new int[30];
		for (int i = 0 ; i < sim.length ; i++)
		{
			//或者sim[i] = (int)(Math.random()*100);
			sim[i]=rand.nextInt(100)+1;
		}
		System.out.println("Before sort:");
		for (int i = 0;i < sim.length ; i++)
			System.out.print(sim[i]+" ");
		array_sort h=new array_sort();
		h.sort1(sim);
		System.out.println("\nAfter Sort:");
		for (int i = 0;i < sim.length ; i++)
			System.out.print(sim[i]+" ");

	
	}
}
