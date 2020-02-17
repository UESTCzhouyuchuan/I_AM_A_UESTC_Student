package p11;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class TestButton extends JFrame implements ActionListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	JFrame myJFrame = null;
	JButton redButton = null, greenButton = null, blueButton = null;
	JPanel jp;

	// 构造器
	public TestButton() {
		// TODO Auto-generated constructor stub
		myJFrame = new JFrame("按钮事件");
		myJFrame.setLocation(500, 300);
		myJFrame.setSize(500, 500);
		myJFrame.setDefaultCloseOperation(3);
		myJFrame.setResizable(true);
		redButton = new JButton("set red");
		greenButton = new JButton("set green");
		blueButton = new JButton("set blue");
		jp = new JPanel();
		jp.add(redButton);
		jp.add(greenButton);
		jp.add(blueButton);
		myJFrame.add(jp);
		jp.setForeground(Color.white);
		redButton.setForeground(Color.black);
		greenButton.setForeground(Color.black);
		blueButton.setForeground(Color.black);
		redButton.addActionListener(this);
		redButton.setActionCommand("red");
		greenButton.addActionListener(this);
		greenButton.setActionCommand("green");
		blueButton.addActionListener(this);
		blueButton.setActionCommand("blue");
		myJFrame.setVisible(true);
	}

	public static void main(String args[]) {
		new TestButton();
	}

	// 事件处理
	public void actionPerformed(ActionEvent e) {
		if (e.getActionCommand().equals("red")) {
			redButton.setForeground(Color.red);
			greenButton.setForeground(Color.red);
			blueButton.setForeground(Color.red);
		} else if (e.getActionCommand().equals("green")) {
			redButton.setForeground(Color.green);
			greenButton.setForeground(Color.green);
			blueButton.setForeground(Color.green);
		} else {
			redButton.setForeground(Color.blue);
			greenButton.setForeground(Color.blue);
			blueButton.setForeground(Color.blue);
		}

	}
}