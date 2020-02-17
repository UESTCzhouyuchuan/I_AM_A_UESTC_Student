package p11;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

public class SaveBook extends JFrame implements ActionListener {
	private static final long serialVersionUID = 1L;
	private static final String FILE = "C:\\Users\\������\\Documents\\Upupoo\\Docker\\config\\�γ�\\java���Գ������\\���Ĵ�ʵ��\\1.txt"; // �����ļ���·���Լ�����
	JTextArea textArea;
	JScrollPane scrollPane;

	public SaveBook() {
		setTitle("���±�");
		setLayout(new BorderLayout());
		JMenuBar menuBar = new JMenuBar();
		JMenu[] menu = new JMenu[] { new JMenu("�ļ�"), new JMenu("�༭") };
		JMenuItem[] menuItem1 = new JMenuItem[] { new JMenuItem("�½�"), new JMenuItem("��"), new JMenuItem("����"),
				new JMenuItem("�ر�") };
		JMenuItem[] menuItem2 = new JMenuItem[] { new JMenuItem("����"), new JMenuItem("ճ��"), new JMenuItem("����") };
		for (int i = 0; i < menu.length; i++) {
			menuBar.add(menu[i]);
		}
		for (int i = 0; i < menuItem1.length; i++) {
			menu[0].add(menuItem1[i]);
		}
		for (int i = 0; i < menuItem2.length; i++) {
			menu[1].add(menuItem2[i]);
		}
		menuItem1[0].addActionListener(this); // ����¼�
		menuItem1[1].addActionListener(this);
		menuItem1[2].addActionListener(this);
		menuItem1[3].addActionListener(this);
		setJMenuBar(menuBar);
		textArea = new JTextArea(); // �ı���
		scrollPane = new JScrollPane(textArea);
		scrollPane.setVisible(false);
		add(scrollPane, BorderLayout.CENTER);
		setResizable(false);
		setSize(800, 600);
		setLocationRelativeTo(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setVisible(true);
	}

	public static void main(String[] args) {

		new SaveBook();
	}

	public void actionPerformed(ActionEvent e) { // �¼�����
		String command = e.getActionCommand();
		if ("�½�".equals(command)) {
			scrollPane.setVisible(true); // ����½�
			validate();
		} else if ("�ر�".equals(command)) {
			scrollPane.setVisible(false); // ���ò��ɼ�
			textArea.setText("");
			validate();
		} else if ("��".equals(command)) {
			scrollPane.setVisible(true);
			validate();
			try {
				FileReader fr = new FileReader(FILE); // ��ָ���ļ�
				char[] cs = new char[1];
				while (-1 != (fr.read(cs))) {
					textArea.append(new String(cs)); // ����ַ���ȡ��Ȼ����ʾ���ı���
				}
				fr.close();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} else if ("����".equals(command)) {
			try {
				FileWriter fw = new FileWriter(FILE);
				fw.write(textArea.getText()); // �ı������ı�д���ļ���
				fw.flush(); // ��ջ�����
				fw.close();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}
}