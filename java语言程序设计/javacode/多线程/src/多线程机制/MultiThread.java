package 多线程机制;
/*
 * 显示三个线程的运行时间
 */
import java.util.Calendar;
import java.util.concurrent.locks.Lock;

public class MultiThread {
static Lock mylock;
public static void main(String[] args) {
RunningObject1 r1 = new RunningObject1();

Thread t1 = new Thread(r1, "t1");
Thread t2 = new Thread(r1, "t2");
Thread t3 = new Thread(r1, "t3");
t1.start();
t3.start();
t2.start();
}

static class RunningObject1 implements Runnable {
public void run() {
synchronized(this){
String name=Thread.currentThread().getName();
System.out.println(name+"开始时间:"+Calendar.getInstance().getTimeInMillis());

for (int i = 0; i < 100000000; i++) {
if (i == 9999999) {
System.out.println(name+"结束时间:"+Calendar.getInstance().getTimeInMillis());
break;
}
}
}
}
}

} 