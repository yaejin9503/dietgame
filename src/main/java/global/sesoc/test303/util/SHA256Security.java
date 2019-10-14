package global.sesoc.test303.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class SHA256Security {

	/**
	 * ��ȣȭ�� �߿伺
	 * ��ȣȭ�� �����͸� ������ �� �ִ���(��ȣȭ�� �Ǵ���) �ȵǴ��Ŀ� ���� ��ȣȭ ������ ������ �� �ִ�.
	 * ������� �� ��ĥ ����¿� ���� ��ȣȭ ��ȭ ������ ���Ѵ�.
	 * 
	 * ���ſ��� ��ȣȭ�� ������ ��Ͼ�ȣ�� ��������� ���ó� ��κ� �����͸� ��ȣȭ�� �� �Ϲ��� ��ȣȭ �˰����� ����Ѵ�. 
	 * ��ǥ������ SHA-256, SHA-512 ���� �ִ�. ���� SHA-256�� ���� ��й�ȣ ��ȣȭ ���� ������.
	 * 
	 * SHA�� Secure Hash Algorithm�� ���� �ؽ��Լ��� ����ϴ� ��ȣȭ �˰����̴�. 
	 * �ڹٿ����� security ��Ű���� ���� �̸� �����Ѵ�. ������ ������ ������ ����.
	 * 
	 * 
	 * <-- ��ȣȭ ���� 
	 * 1) ȸ�������� �� �� ��й�ȣ�� �޾� ��ȣȭ �Ѵ�.
	 * - ��ȣȭ �� �� ¦�� �̷�� ������ �߻����� ��ȣȭ�� �̿��Ѵ�. �� ������ ���þ� Salt�� �Ѵ�.
	 * - DB�� ��ȣȭ�� ��й�ȣ�� Salt ���� �����Ѵ�.
	 * 2) �α����� �� ID�� �´� Salt �����´�.
	 * 3) �Է��� Password�� Salt�� ���� ��ȣȭ ��Ų ���� ��й�ȣ�� �� �������� �����Ѵ�.
	 * 
	 * DB�� SALT�� �߰��Ѵ�.
	 * Salt ���� ��ȣȭ�� �־� �߿��� �ܼ��� ������ �̶��� �״�� �������� �ʴ´�. �ǹ������� �ٸ� ������ SATL������ ������ DB�� �ΰų� SALT�� ����� ��ȣȭ �ϵ��� �Ѵ�.
	 * ��й�ȣ�� ��ȣȭ �� ������� ������ ����� �˳��ϰ� �ؾ� �Ѵ�.
	 */
	
	
	 /**
     * SHA-256 ��ȣȭ ��
     * @param source ����
     * @param salt(String) SALT ��
     * @return
     * 
     */
    public static String getEncrypt(String source, String salt) {
        return getEncrypt(source, salt.getBytes());
    }
    /**
     * SHA-256 ��ȣȭ ��
     * @param source ����
     * @param salt(byte[]) SALT ��
     * @return
     */
    public static String getEncrypt(String source, byte[] salt) {
         
        String result = "";
         
        byte[] a = source.getBytes(); //������ Ÿ���� byte�� �� �迭�� �����ϰ�, String Ÿ���� source��  byte�ڵ�� ���ڵ����ش�. 
        byte[] bytes = new byte[a.length + salt.length]; //length�� a.length + salt.length�� ���� ���̴�. 
         
        /**system.arraycopy�� �ڹ� �迭�� ���� ������ ��� ��� �Ѵ�.
         * �迭���� ���ϴ� �κи� �����Ѵٴ� �ǹ� */ 
        System.arraycopy(a, 0, bytes, 0, a.length); //a.length������ �����͸� byte�� ��������
        System.arraycopy(salt, 0, bytes, a.length, salt.length);
        //data�� bytes�� �� ����ǰ� �ȴ�.a�� ������, bytes�� ������
        //arraycopy(Object src, int srcPos, object dest, int destPos, length)
       /**
        * src - �����ϰ��� �ϴ� �ҽ�, �����̶�� �����ϸ� ��   (������ ��) 
        * srcPos - ���� �ҽ����� ��� �κк��� �о���� ��ġ�� ������ 
        * dest - ������ �ִٸ� ���纻�� �־���� , �����Ϸ��� ��� (�����ϴ°� ���� �迭)
        * destPos - ���� dest���� �ڷḦ ���� ��, ��� �κк��� ���� ���� ���� ��ġ�� ������ 
        * length - �������� ���纻���� ��ŭ �о� ���� �Է��ϴ� �� �Դϴ�. 
        * 
        * */
         
        try {
            // ��ȣȭ ��� ���� �޼ҵ�
            MessageDigest md = MessageDigest.getInstance("SHA-256"); //sha-256���� �ؽ����� ������شٴ� ���
            /**�� MessageDigest Ŭ������ SHA-1 
             * 256�� �ǹ̴� 256��Ʈ�� �����Ǿ� 64�ڸ� ���ڿ��� ��ȯ
             * �Ǵ� SHA-256�� ���� �޽��� ��� �˰����� ����� ���� ���α׷��� �����մϴ�. 
             * �޽��� ����� ���� ũ���� �����͸� ������ ���� ���� �ؽ� ���� ����ϴ� ������ �ܹ��� �ؽ� �Լ��Դϴ�.*/     
            md.update(bytes);
            // byte -> -128~127 ǥ���ɼ� �ִ� ���� 
            byte[] byteData = md.digest();// digest()�� �������� �� �ؽ� ���� ����Ʈ �迭�� return ���� 
             
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
            	//byte�� hexstring--> ���� ��ȯ�ϴ� ���  16���� ����Ʈ�� hexString���� �ٲ���!? �̷����� �� ���� 	
                sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
                /**Integer.toString (int��, 16)�޼ҵ带 ���� �������� 16������ ��ȯ�ϴ� ��
                 * �� ? &0xFF�� ���ְ� �� + 256�� ���ִ� ���� �˾ƾ� �Ѵ�.*/ 
            }
            result = sb.toString(); //�迭�� �ִ� �͵��� ���ڿ��� ��ȯ�ϰڴ� ! �̰� �ƴ�? ! 
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return result;
    }
    /**
     * SALT�� ���´�.
     * @return
     */
    public static String generateSalt() {
        Random random = new Random(); //���� ��ü�� �ϳ� �������ش�.
         
        byte[] salt = new byte[8]; //byte������ ��ü 8�ڸ��� �� 
        random.nextBytes(salt); //������ ����Ʈ�� �����Ͽ� ����� ���� ����Ʈ �迭�� ��ġ�մϴ�,  ���� �� ������ ����Ʈ ���� ����Ʈ �迭�� ���̿� �����ϴ�.
         
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < salt.length; i++) {
            // byte ���� Hex ������ �ٲٱ�.
            sb.append(String.format("%02x",salt[i]));
        }
        return sb.toString();
    }
}
