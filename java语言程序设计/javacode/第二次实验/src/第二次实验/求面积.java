package 第二次实验;

//三角形求面积
class Triangle{
	double area;
	Triangle( int x , int y, int z){
		double p = (x+y+z)*1.0/2;
		area = Math.sqrt(p*(p-x)*(p-y)*(p-z));
	}
}
//长方形求面积
class Rectangle{
	double area;
	Rectangle(int l, int h){
		area = l*h;
	}
}
public class 求面积 {
	public static void main(String [] args){
		Triangle test1 = new Triangle(3,4,5);
		Rectangle teat2 = new Rectangle(4,5);
		System.out.println("Area of triangle: "+test1.area+
				"\nArea of rectangle: "+teat2.area);
		
	}

}
