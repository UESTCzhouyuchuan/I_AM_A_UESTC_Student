package 第二次实验;

class Point{
	int x,y;
	Point(){
		x = 0;
		y = 0;
	}
	void SetX(int x){
		this.x = x;
	}
	void SetY(int y){
		this.y = y; 
	}
	void getPoint(){
		System.out.println("X: "+x+",Y: "+y);
	}
	void movePoint( int x , int y ){
		this.x = x;
		this.y = y;
	}
}
public class 第四章11 {
	public static void main(String[] args){
		Point test = new Point();
		test.getPoint();
		test.movePoint(4, 9);
		test.getPoint();
	}

}
