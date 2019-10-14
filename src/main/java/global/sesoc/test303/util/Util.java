package global.sesoc.test303.util;

import java.security.MessageDigest;

// MessageDigest라는 라이브러리를 이용해서 ‘SHA-256’ 해시 알고리즘을 사용하겠다고 명시한 것


public class Util {

	//사용자로부터 받은 입력을 SHA-256 해시를 적용하여 그 값을 바이트(Byte) 배열 형태로 반환하도록 함수가 작성
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
