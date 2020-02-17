package p8;

import java.util.Date;

class hereThread extends Thread {
	public hereThread() {
		Date time = new Date();
		System.out.print("Time here:");
		System.out.println(time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds());
	}
}

class AmericaThread extends Thread {
	public AmericaThread() {
		// TODO Auto-generated constructor stub
		Date time = new Date();
		System.out.print("Time in America:");
		System.out.println(time.getHours() - 8 + ":" + time.getMinutes() + ":" + time.getSeconds());
	}
}

class CandaThread extends Thread {
	public CandaThread() {
		Date time = new Date();
		System.out.print("Time in Canda:");
		System.out.println(time.getHours() + 8 + ":" + time.getMinutes() + ":" + time.getSeconds());
	}
}

public class clock {
	public clock() {
		new hereThread();// 当地时间
		new AmericaThread();// 美国时间
		new CandaThread();// 加拿大时间
	}

	public static void main(String args[]) {
		new clock();// 时钟程序
	}

}
