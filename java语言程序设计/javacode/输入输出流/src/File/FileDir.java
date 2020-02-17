package File;

import java.io.File;
import java.sql.Date;

/*
 * ����ļ����ԣ��൱��unix��ls -l
 */
public class FileDir {
	public static void main(String[] args) {
		if (args.length != 1) {
			System.out.println("Usage:java FileDir<filePath>");
			System.exit(-1);
		}
		File file = new File(args[0]);
		String[] ls = file.list();// �õ�Ŀ¼�е��ļ���������Ŀ¼��
		for (String chr : ls) { // ����ls�е��ļ�����Ŀ¼
			printOne(new File(chr));
		}
	}

	public static void printOne(File f) {
		if (f.exists()) {
			System.out.print(f.isDirectory() ? "d" : "-");// ���Ȩ��
			System.out.print(f.canWrite() ? "w" : "-");
			System.out.print(f.canRead() ? "r" : "-");
			if (!f.isDirectory())
				System.out.print("\t\t" + f.length());// ������Ŀ¼������ļ���С
			else
				System.out.print("\t<Dir>\t");
			System.out.print("\t" + new Date(f.lastModified()) + "\t");// �����һ���޸�ʱ��
		} else
			System.out.print("\t\t\t\t");
		System.out.println(f.getName());// �������ļ���
	}

}
