package ������;
/*����һ�����࣬������һ����Ĭ�ϵĹ�������
 * �ٴ���һ�����࣬������Ĭ�Ϲ������ͷ�Ĭ�Ϲ�������
 * ������Ĺ������е��ó���Ĺ�������
 */
class father{
	father(){
		System.out.println("I love xinxin");
	}
}
class son extends father{
	son(){
		super();
	}
}
public class �ڶ��� {
	public static void main(String[] args) {
		son test = new son();
	}

}
