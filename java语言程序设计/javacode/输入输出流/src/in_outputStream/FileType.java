package in_outputStream;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/*
 * function：显示文件内容
 *
 * public abstract class InputStream extends Object{//输入流
 * 		public InputStream();//构造器没参数，也没扩展，所以基本不直接用此类
 * 		public abstract int read() throws IOException;//一个一个字节读入，返回-1表示结束
 * 		public int read(byte b[]) throws IOException;//将字节读入byte数组，返回值是字节数，返回-1表示结束
 * 		public int read(byte b[], int off, int len) throws IOException;//off读入起始位置，len读入最大字节数
 * 		public long skip(long n) throws IOException;
 * 		public int available() thows IOException;
 * 		public void close() throws IOException;
 * 
 * }
 *
 * public abstract class OutputStream extends Object{//输出流
 * 		public OutputStream();//构造器没参数，也没扩展，所以基本不直接用此类          
 * 		public abstract void write(int b) throws IOException;
 * 		public void write(byte b[]) throws IOException;
 * 		public void write(byte b[], int off, int len) throws IOException;
 * 		public void flush() throws IOException;//释放缓冲区内存，释放到指定位置
 * 		public void close() throws IOException;//关闭输出流
 * }
 * 文件输入流
 * public class FileInputStream extends InputStream{
 * 		public FileInputStream(String name)throws FileNotFoundException;
 * 		public FileInputStream(File file)throws FileNotFoundException;
 * 		public void close() throws IOException;
 * }
 * public class FileOutputStream extends OutputStream{
 * 		public FileOutputStream(String name) throws IOException;//改写方式输出数据
 * 		public FileOutputStream(String name,boolean append) throws IOException;//append为true时追加，为0时覆盖
 * 		public FileOutputStream(File file) throws IOException;//改写方式
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
			FileInputStream in = new FileInputStream(file);// 用File实例化FileInputStream类
			int c;
			int i = 0;
			while ((c = in.read()) > -1) {// 一个一个字节读入
				if ((char) c == '\n')
					i++;// 行数加一
				System.out.println((char) c);// 输出
			}
			in.close();// 关闭文件流
			System.out.flush();// 释放缓冲区，输出
			System.out.println("\n\n\n-----------");
			System.out.println("File:" + args[0] + "Lines:" + i);
		} catch (FileNotFoundException e) {
			System.out.println(file + " is not found.");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
