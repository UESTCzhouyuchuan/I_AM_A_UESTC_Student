package 多线程机制;

public class Example {
	static int balance = 1000;
	Example(){
		DepositThread first,second;
		first = new DepositThread(this,1000,"#1");
		second = new DepositThread(this, 1000,"\t\t\t#2");
		first.start();
		second.start();
		try {
			first.join();
			second.join();
			
		}catch(InterruptedException e) {}
		System.out.println("----------------");
		System.out.println("Final balance is " + balance);
		
	}
	/*synchronized */ void Deposit( int amount, String name) {//未加synchronized 会出现错误结果，synchronized 同步锁
		int bal;
		synchronized(this) {
			
		
		System.out.println(name+" trying to deposit "+amount);
		System.out.println(name+" geting balance...");
		bal = getBalance();
		System.out.println(name+" balance got is "+balance);
		bal+=amount;
		System.out.println(name+" setting balance...");
		setBalance(bal);
		System.out.println(name+" new balance set to "+balance);
		}
	}
	int getBalance() {
		try {
			Thread.sleep(5000);
			
		}catch(InterruptedException e) {}
		return balance;
	}
	void setBalance(int bal) {
		try {
			Thread.sleep(5000);
		}catch(InterruptedException e) {}
		balance = bal;
	}
	public static void main(String[] args) {
		new Example();
	}

}

class DepositThread extends Thread{
	Example account;
	int Deposit_amount;
	String message;
	DepositThread(Example account, int amount, String message){
		this.message = message;
		this.account = account;
		this.Deposit_amount = amount;
	}
	public void run() {
		account.Deposit(Deposit_amount, message);
	}
}
