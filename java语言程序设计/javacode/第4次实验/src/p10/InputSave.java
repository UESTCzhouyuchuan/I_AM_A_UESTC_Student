package p10;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;

public class InputSave {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
			BufferedWriter writer = new BufferedWriter(
					new FileWriter("C:\\Users\\������\\Desktop\\javacode\\��4��ʵ��\\src\\p10\\test.txt"));
			System.out.println("�����룺");
			String string;
			while (!(string = reader.readLine()).equals("")) {
				writer.write(string);
				writer.newLine();
			}
			writer.close();
		} catch (IOException e) {
			// TODO: handle exception
		} finally {

		}
	}

}
