package �ڶ���ʵ��;

class MyDate{
	int year;
	String month;
	int day;
	//��������
	void SetDate(int year, String month, int day){
		this.year = year;
		this.month = month;
		this.day = day;
	}
	//��������
	void AddDate(int add){
		this.day+=1;
	}
	//��ӡ����
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
