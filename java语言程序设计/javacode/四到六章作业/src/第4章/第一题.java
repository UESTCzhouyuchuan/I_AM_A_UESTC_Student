package ��4��;
/*����һ���࣬����һ������һ��String�����Ĺ�������
 * �ڹ���׶Σ���ӡ�ò���������һ������Ķ����������飬
 * ��ͨ���������ַ�ʽ�Ը������ʼ����
"1�����캯����2����������ֵ�����������顣*/
//�����java.util����ӿ�
import java.util.*; 
//������Sample
class Sample{
	//�������Ĺ��캯��
	Sample( String x ) {
		System.out.println(x);
	}
	//���������Ĺ��캯��
	Sample(){
		this("No String");
	}
}
public class ��һ�� {
	public static void main ( String[] args) {
		Sample[] sam = new Sample[2];
		Scanner x = new Scanner(System.in);
		//����new ��������ֵ���������� sam[2]
		sam[0] = new Sample(x.nextLine());
		sam[1] = new Sample();
		x.close();
		
	}
}
