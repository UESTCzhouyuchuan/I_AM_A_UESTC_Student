package 第二次实验;

class MyDate{
	int year;
	String month;
	int day;
	//设置日期
	void SetDate(int year, String month, int day){
		this.year = year;
		this.month = month;
		this.day = day;
	}
	//增加日期
	void AddDate(int add){
		this.day+=1;
	}
	//打印日期
	void PrintData(){
		System.out.println("year: "+year+"\nmonth: "+month+"\nday: "+day);
	}
}
public class TestDate {
	public static void main(String[] args){
		MyDate test = new MyDate();
		test.SetDate(2017, "October", 22);
		test.PrintData();
		
	}

}
