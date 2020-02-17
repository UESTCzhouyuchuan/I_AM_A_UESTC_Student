package test;
/*
 * 动态显示时间
 */
import java.awt.*;
import javax.swing.*;
import java.util.Date;
import java.awt.*;
class Time extends JFrame implements Runnable{//实现接口
Thread clockThread;
   JLabel jLabel=new JLabel();
   public Time()
   {
   Container con=this.getContentPane();
   con.add(new Drawtime());
   }
public void start(){
//该方法是类的方法，不是线程的方法
if(clockThread==null){
   clockThread=new Thread(this,"Clock");
   /*线程体是Clock对象本身，线程名字为"Clock"*/
   clockThread.start();//启动线程
}
} 
public void run(){//run()方法中是线程执行的内容
    while(clockThread!=null){
    repaint();//刷新显示画面
    try{
       clockThread.sleep(1000);
       //睡眠1秒，即每隔1秒执行一次
    }
    catch(InterruptedException e){}
    }
}
public void stop(){
//该方法是类的方法，不是线程的方法
clockThread.stop();
clockThread=null; 
}
}
public class JFrameDemo 
{public static void main(String[] args)
{Time frame=new Time(); 
frame.setSize(500,300); 
frame.setVisible(true);                   //设置组件可见   
frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE); //关闭容口，并结束程序的运行
frame.start();
frame.run();
frame.stop();
}
}
class Drawtime extends JPanel
{
public void paint(Graphics g){
   g.setColor(Color.red);
   Font font1=new Font("黑体",Font.ITALIC,60);
   g.setFont(font1);
Date now=new Date();//获得当前的时间对象
g.drawString(now.getHours()+":"+now.getMinutes()+":"+now.getSeconds(),140,140);
//显示当前时间
} 
}