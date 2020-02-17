package RandomAccessFile;

/*
 * 把一个文件复制到另一个文件里
 * public RandAccessFile(String name,String mode) throws IOException;
 * public RandAccessFile(File file,String mode) throws IOException;
 */
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;

public class RandCopy {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		RandomAccessFile raf1 = null, raf2 = null;
		long size = -1;
		byte[] buffer;
		if (args.length != 2) {
			System.out.println("Usage:java RandCopy<file><file2>");
			System.exit(-1);
		}
		if (args[0].equals(args[1])) {// 两个文件名相等
			System.out.println(args[0]);
			System.out.println("File can not copy onto itself");
			System.exit(-1);
		}
		try {
			raf1 = new RandomAccessFile(new File(args[0]), "r");
			size = raf1.length();
		} catch (IOException e) {
			System.out.println("Can not find " + args[0]);
			System.exit(-1);
		}
		try {
			raf2 = new RandomAccessFile(new File(args[1]), "rw");
		} catch (IOException e) {
			System.out.println("Cannot open " + args[1]);
			System.exit(-1);
		}
		buffer = new byte[(int) size];
		try {
			raf1.readFully(buffer, 0, (int) size);// 从raf1中读到buffer
			raf2.write(buffer, 0, (int) size);// 从buffer写到raf2对应文件中
		} catch (IOException e) {
			System.out.println("Cannot copy file " + args[0] + " to " + args[1]);
		} finally {
			try {
				raf1.close();// 在finally中关闭RandomAccessFile 类
				raf2.close();
			} catch (Exception e) {
				System.out.println(e);
			}
		}
	}

}
