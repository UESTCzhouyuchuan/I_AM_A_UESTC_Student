package test;
/*
 * ��̬��ʾʱ��
 */
import java.awt.*;
import javax.swing.*;
import java.util.Date;
import java.awt.*;
class Time extends JFrame implements Runnable{//ʵ�ֽӿ�
Thread clockThread;
   JLabel jLabel=new JLabel();
   public Time()
   {
   Container con=this.getContentPane();
   con.add(new Drawtime());
   }
public void start(){
//�÷�������ķ����������̵߳ķ���
if(clockThread==null){
   clockThread=new Thread(this,"Clock");
   /*�߳�����Clock�������߳�����Ϊ"Clock"*/
   clockThread.start();//�����߳�
}
} 
public void run(){//run()���������߳�ִ�е�����
    while(clockThread!=null){
    repaint();//ˢ����ʾ����
    try{
       clockThread.sleep(1000);
       //˯��1�룬��ÿ��1��ִ��һ��
    }
    catch(InterruptedException e){}
    }
}
public void stop(){
//�÷�������ķ����������̵߳ķ���
clockThread.stop();
clockThread=null; 
}
}
public class JFrameDemo 
{public static void main(String[] args)
{Time frame=new Time(); 
frame.setSize(500,300); 
frame.setVisible(true);                   //��������ɼ�   
frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE); //�ر��ݿڣ����������������
frame.start();
frame.run();
frame.stop();
}
}
class Drawtime extends JPanel
{
public void paint(Graphics g){
   g.setColor(Color.red);
   Font font1=new Font("����",Font.ITALIC,60);
   g.setFont(font1);
Date now=new Date();//��õ�ǰ��ʱ�����
g.drawString(now.getHours()+":"+now.getMinutes()+":"+now.getSeconds(),140,140);
//��ʾ��ǰʱ��
} 
}