package test;

class Point {
	int x,y;
	void setData(Point p) {
		p.x = 10;
		p.y = 20;
	}
	void setRefer(Point p) {
		System.out.println(p.x+","+p.y);//未改变p
		p = new Point();
		p.x=100;
		p.y=200;
		System.out.println(p.x+","+p.y);//改变p的地址
	}
}
public class test1 {
	
	public static void main(String [] args) {
		Point test = new Point();
		test.x = 1;
		test.y = 2;
		test.setRefer(test);
		System.out.println(test.x+","+test.y);//参数引用中p改变，所以test结果不变
		test.setData(test);
		System.out.println(test.x+","+test.y);//参数引用正常，text发生改变
	}

}
