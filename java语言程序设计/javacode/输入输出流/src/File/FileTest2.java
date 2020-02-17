package File;

import java.io.File;

/*
 * 创建一个目录和它的子目录，然后删除
 */
public class FileTest2 {
	public static void main(String args[]) {
		File dir, subdir;
		if (args.length != 1) {
			System.out.println("Usage:java FileTest2 <newDirPath>");
			System.exit(-1);
		}
		dir = new File(args[0]);
		if (dir.exists()) {
			System.out.println(dir.getPath() + " already exist!");
		} else {
			if (dir.mkdir()) {
				System.out.println("Create directory:" + dir.getAbsolutePath());
				subdir = new File(dir, "newSub");
				if (subdir.exists()) {
					System.out.println("Create subdirectory:" + subdir.getAbsolutePath());
					subdir.delete();// 删除创建的子目录
				} else
					System.out.println("Cannot create subdirectory:" + subdir.getAbsolutePath());
				dir.delete();// 删除目录
			} else
				System.out.println("Can not create dirctory:" + dir.getAbsolutePath());
			dir.delete();
		}

	}
}
