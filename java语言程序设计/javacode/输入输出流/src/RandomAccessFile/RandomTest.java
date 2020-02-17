package RandomAccessFile;

import java.io.IOException;
/*
 * 输入文件，以覆盖方式写入，若文件不存在自动新建
 */
import java.io.RandomAccessFile;

public class RandomTest {
	public static void main(String[] args) {
		RandomAccessFile raf = null;
		if (args.length != 1) {
			System.out.println("Usage:java RandomTest <output file>");
			System.exit(-1);
		}
		try {
			raf = new RandomAccessFile(args[0], "rw");// 读写方式
			char a = 'a';
			byte b = 2;
			String c = "abc";
			byte[] b2 = { 'a', 'b', 'c' };
			raf.write(b);// 02
			raf.write(b2, 0, b2.length);// 写入byte数组，0为开始位置，write(byte[],int off,int len)
			raf.writeBoolean(true);// 写入01
			raf.writeChar(a);// 00 61
			raf.writeBytes(c);// 每个字符两个字节，61 62 63
			raf.writeChars(c);// 每个字符4个字节00 61 00 62 00 63
			raf.writeUTF(c);// 00 ，个数，00 03 61 62 63
			raf.writeUTF("abc\n");// 多一个 0a
			System.out.println("Lenght of file:" + raf.length());
		} catch (IOException e) {
			System.err.println(e);
		} finally {
			try {
				raf.close();
			} catch (Exception e) {
				System.err.println(e);
			}
		}
	}

}
