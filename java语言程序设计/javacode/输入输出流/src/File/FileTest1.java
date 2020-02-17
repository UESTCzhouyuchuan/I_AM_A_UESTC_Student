package File;

import java.io.File;

public class FileTest1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		if (args.length != 1) {
			System.out.println("Usage:FileTest1 <File or Dir>");
			System.exit(-1);
		}
		File f = new File(args[0]);
		if (f.exists()) {
			System.out.println("----------------");
			System.out.println("Absolute Path:" + f.getAbsolutePath());
			System.out.println("File Path:" + f.getPath());
			System.out.println("File Name:" + f.getName());
			System.out.println("Parent Dirtory:" + f.getParent());
			System.out.println("----------------");
			String canRead = f.canRead() ? "YES" : "No";
			String canWrite = f.canWrite() ? "Yes" : "No";
			String isFile = f.isFile() ? "Yes" : "No";
			String isDir = f.isDirectory() ? "Yes" : "No";
			String isAbs = f.isAbsolute() ? "Yes" : "No";
			System.out.println("Readable:	" + canRead);
			System.out.println("Writable: 	" + canWrite);
			System.out.println("Is Dirtory: " + isDir);
			System.out.println("Is File:	" + isFile);
			System.out.println("Is absolute path: " + isAbs);
		} else
			System.out.println("Cannot find file " + args[0]);

	}

}
