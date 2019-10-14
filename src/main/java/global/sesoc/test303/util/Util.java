package global.sesoc.test303.util;

import java.security.MessageDigest;

// MessageDigest��� ���̺귯���� �̿��ؼ� ��SHA-256�� �ؽ� �˰����� ����ϰڴٰ� ����� ��


public class Util {

	//����ڷκ��� ���� �Է��� SHA-256 �ؽø� �����Ͽ� �� ���� ����Ʈ(Byte) �迭 ���·� ��ȯ�ϵ��� �Լ��� �ۼ�
  public static String getHash(String input) {

    StringBuffer result = new StringBuffer();

    try {
      MessageDigest md = MessageDigest.getInstance("SHA-256");
      md.update(input.getBytes());
      byte bytes[] = md.digest();
      for(int i = 0; i < bytes.length; i++) {
        result.append(
	  Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1)
        );
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return result.toString();
  }

}
