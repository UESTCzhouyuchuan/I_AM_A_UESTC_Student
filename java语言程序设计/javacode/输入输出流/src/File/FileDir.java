package File;

import java.io.File;
import java.sql.Date;

/*
 * 输出文件属性，相当于unix的ls -l
 */
public class FileDir {
	public static void main(String[] args) {
		if (args.length != 1) {
			System.out.println("Usage:java FileDir<filePath>");
			System.exit(-1);
		}
		File file = new File(args[0]);
		String[] ls = file.list();// 得到目录中的文件名或者子目录名
		for (String chr : ls) { // 遍历ls中的文件或者目录
			printOne(new File(chr));
		}
	}

	public static void printOne(File f) {
		if (f.exists()) {
			System.out.print(f.isDirectory() ? "d" : "-");// 输出权限
			System.out.print(f.canWrite() ? "w" : "-");
			System.out.print(f.canRead() ? "r" : "-");
			if (!f.isDirectory())
				System.out.print("\t\t" + f.length());// 若不是目录，输出文件大小
			else
				System.out.print("\t<Dir>\t");
			System.out.print("\t" + new Date(f.lastModified()) + "\t");// 输出上一次修改时间
		} else
			System.out.print("\t\t\t\t");
		System.out.println(f.getName());// 最后输出文件名
	}

}
