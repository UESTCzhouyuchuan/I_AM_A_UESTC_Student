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
		new hereThread();// ����ʱ��
		new AmericaThread();// ����ʱ��
		new CandaThread();// ���ô�ʱ��
	}

	public static void main(String args[]) {
		new clock();// ʱ�ӳ���
	}

}
