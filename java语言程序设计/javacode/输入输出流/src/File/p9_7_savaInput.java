package File;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class p9_7_savaInput {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		BufferedInputStream test = new BufferedInputStream(System.in);// System.in «InputStream¿‡
		if (args.length != 1) {
			System.out.println("Usage:savaInput <File>");
			System.exit(-1);
		}
		File file = new File(args[0]);
		if (file.exists()) {
			try {
				FileOutputStream file1 = new FileOutputStream(file);
				byte[] str = new byte[100];
				while (test.read(str) != 0) {
					file1.write(str);
				}
				file1.close();
			} catch (IOException e) {
				System.err.println(e);
			} finally {
			}
		}
	}

}
