package RandomAccessFile;

import java.io.IOException;
/*
 * �����ļ����Ը��Ƿ�ʽд�룬���ļ��������Զ��½�
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
			raf = new RandomAccessFile(args[0], "rw");// ��д��ʽ
			char a = 'a';
			byte b = 2;
			String c = "abc";
			byte[] b2 = { 'a', 'b', 'c' };
			raf.write(b);// 02
			raf.write(b2, 0, b2.length);// д��byte���飬0Ϊ��ʼλ�ã�write(byte[],int off,int len)
			raf.writeBoolean(true);// д��01
			raf.writeChar(a);// 00 61
			raf.writeBytes(c);// ÿ���ַ������ֽڣ�61 62 63
			raf.writeChars(c);// ÿ���ַ�4���ֽ�00 61 00 62 00 63
			raf.writeUTF(c);// 00 ��������00 03 61 62 63
			raf.writeUTF("abc\n");// ��һ�� 0a
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
