package File;

import java.io.File;

public class FileRename {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String mge;
		if (args.length != 2) {
			System.out.println("Usage:java FileRename<file1><file2>");
			System.exit(-1);
		}
		File f1 = new File(args[0]);
		File f2 = new File(args[2]);
		if (f1.equals(f2)) {
			System.out.println("Cannot rename a file to itself.");
			System.exit(-1);
		}
		mge = f1.renameTo(f2) ? "renamed to" : "could not renamed to";
		System.out.println(f1.getPath() + mge + f2.getPath());

	}

}
