package in_outputStream;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/*
 * function����ʾ�ļ�����
 *
 * public abstract class InputStream extends Object{//������
 * 		public InputStream();//������û������Ҳû��չ�����Ի�����ֱ���ô���
 * 		public abstract int read() throws IOException;//һ��һ���ֽڶ��룬����-1��ʾ����
 * 		public int read(byte b[]) throws IOException;//���ֽڶ���byte���飬����ֵ���ֽ���������-1��ʾ����
 * 		public int read(byte b[], int off, int len) throws IOException;//off������ʼλ�ã�len��������ֽ���
 * 		public long skip(long n) throws IOException;
 * 		public int available() thows IOException;
 * 		public void close() throws IOException;
 * 
 * }
 *
 * public abstract class OutputStream extends Object{//�����
 * 		public OutputStream();//������û������Ҳû��չ�����Ի�����ֱ���ô���          
 * 		public abstract void write(int b) throws IOException;
 * 		public void write(byte b[]) throws IOException;
 * 		public void write(byte b[], int off, int len) throws IOException;
 * 		public void flush() throws IOException;//�ͷŻ������ڴ棬�ͷŵ�ָ��λ��
 * 		public void close() throws IOException;//�ر������
 * }
 * �ļ�������
 * public class FileInputStream extends InputStream{
 * 		public FileInputStream(String name)throws FileNotFoundException;
 * 		public FileInputStream(File file)throws FileNotFoundException;
 * 		public void close() throws IOException;
 * }
 * public class FileOutputStream extends OutputStream{
 * 		public FileOutputStream(String name) throws IOException;//��д��ʽ�������
 * 		public FileOutputStream(String name,boolean append) throws IOException;//appendΪtrueʱ׷�ӣ�Ϊ0ʱ����
 * 		public FileOutputStream(File file) throws IOException;//��д��ʽ
 * 		public void close() throws IOException;
 * 		
 * }
 */
public class FileType {
	public static void main(String[] args) {
		if (args.length != 1) {
			System.out.println("Usage:java FileType<input_file>");
			System.exit(-1);
		}
		File file = new File(args[0]);
		try {
			FileInputStream in = new FileInputStream(file);// ��Fileʵ����FileInputStream��
			int c;
			int i = 0;
			while ((c = in.read()) > -1) {// һ��һ���ֽڶ���
				if ((char) c == '\n')
					i++;// ������һ
				System.out.println((char) c);// ���
			}
			in.close();// �ر��ļ���
			System.out.flush();// �ͷŻ����������
			System.out.println("\n\n\n-----------");
			System.out.println("File:" + args[0] + "Lines:" + i);
		} catch (FileNotFoundException e) {
			System.out.println(file + " is not found.");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
