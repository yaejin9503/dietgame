package global.sesoc.test303.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class SHA256Security {

	/**
	 * 암호화의 중요성
	 * 암호화된 데이터를 복원할 수 있느냐(복호화가 되느냐) 안되느냐에 따라 암호화 강약을 가늠할 수 있다.
	 * 노출됐을 때 미칠 영향력에 따라 암호화 강화 정도를 정한다.
	 * 
	 * 과거에는 복호화가 가능한 블록암호를 사용했지만 오늘날 대부분 데이터를 암호화할 때 일방향 암호화 알고리즘을 사용한다. 
	 * 대표적으로 SHA-256, SHA-512 등이 있다. 그중 SHA-256을 통한 비밀번호 암호화 과정 포스팅.
	 * 
	 * SHA는 Secure Hash Algorithm의 약어로 해쉬함수를 사용하는 암호화 알고리즘이다. 
	 * 자바에서는 security 패키지를 통해 이를 지원한다. 간략한 절차는 다음과 같다.
	 * 
	 * 
	 * <-- 암호화 순서 
	 * 1) 회원가입을 할 때 비밀번호를 받아 암호화 한다.
	 * - 암호화 할 때 짝을 이루는 난수를 발생시켜 암호화에 이용한다. 이 난수를 일컬어 Salt라 한다.
	 * - DB에 암호화된 비밀번호와 Salt 값을 저장한다.
	 * 2) 로그인할 때 ID에 맞는 Salt 가져온다.
	 * 3) 입력한 Password와 Salt를 통해 암호화 시킨 값을 비밀번호로 해 쿼리문을 수행한다.
	 * 
	 * DB에 SALT를 추가한다.
	 * Salt 값은 복호화에 있어 중요한 단서기 때문에 이또한 그대로 저장하지 않는다. 실무에서는 다른 서버에 SATL값만을 가지는 DB를 두거나 SALT를 양방향 암호화 하도록 한다.
	 * 비밀번호가 암호화 돼 길어지기 때문에 사이즈를 넉넉하게 해야 한다.
	 */
	
	
	 /**
     * SHA-256 암호화 함
     * @param source 원본
     * @param salt(String) SALT 값
     * @return
     * 
     */
    public static String getEncrypt(String source, String salt) {
        return getEncrypt(source, salt.getBytes());
    }
    /**
     * SHA-256 암호화 함
     * @param source 원본
     * @param salt(byte[]) SALT 값
     * @return
     */
    public static String getEncrypt(String source, byte[] salt) {
         
        String result = "";
         
        byte[] a = source.getBytes(); //데이터 타입이 byte로 된 배열을 생성하고, String 타입인 source를  byte코드로 인코딩해준다. 
        byte[] bytes = new byte[a.length + salt.length]; //length는 a.length + salt.length를 더한 것이다. 
         
        /**system.arraycopy는 자바 배열의 값을 복사할 경우 사용 한다.
         * 배열에서 원하는 부분만 복사한다는 의미 */ 
        System.arraycopy(a, 0, bytes, 0, a.length); //a.length까지의 데이터를 byte에 저장해줌
        System.arraycopy(salt, 0, bytes, a.length, salt.length);
        //data가 bytes에 다 저장되게 된다.a의 데이터, bytes의 데이터
        //arraycopy(Object src, int srcPos, object dest, int destPos, length)
       /**
        * src - 복사하고자 하는 소스, 원본이라고 생각하면 됨   (복사할 거) 
        * srcPos - 위의 소스에서 어느 부분부터 읽어올지 위치를 정해줌 
        * dest - 원본이 있다면 복사본이 있어야함 , 복사하려는 대상 (복사하는게 들어가는 배열)
        * destPos - 위의 dest에서 자료를 받을 때, 어느 부분부터 쓸지 시작 시작 위치를 정해줌 
        * length - 원본에서 복사본까지 얼마큼 읽어 올지 입력하는 것 입니다. 
        * 
        * */
         
        try {
            // 암호화 방식 지정 메소드
            MessageDigest md = MessageDigest.getInstance("SHA-256"); //sha-256으로 해쉬값을 만들어준다는 얘기
            /**이 MessageDigest 클래스는 SHA-1 
             * 256의 의미는 256비트로 구성되어 64자리 문자열을 반환
             * 또는 SHA-256과 같은 메시지 요약 알고리즘의 기능을 응용 프로그램에 제공합니다. 
             * 메시지 요약은 임의 크기의 데이터를 가져와 고정 길이 해시 값을 출력하는 안전한 단방향 해시 함수입니다.*/     
            md.update(bytes);
            // byte -> -128~127 표현될수 있는 범위 
            byte[] byteData = md.digest();// digest()을 해줌으로 써 해쉬 값의 바이트 배열을 return 해줌 
             
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
            	//byte를 hexstring--> 으로 변환하는 방법  16진수 바이트를 hexString으로 바꿔줌!? 이런식인 것 같음 	
                sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
                /**Integer.toString (int값, 16)메소드를 통해 정수값을 16진수로 변환하는 것
                 * 왜 ? &0xFF을 해주고 왜 + 256을 해주는 건지 알아야 한다.*/ 
            }
            result = sb.toString(); //배열에 있는 것들을 문자열로 반환하겠다 ! 이거 아님? ! 
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return result;
    }
    /**
     * SALT를 얻어온다.
     * @return
     */
    public static String generateSalt() {
        Random random = new Random(); //랜덤 객체를 하나 생성해준다.
         
        byte[] salt = new byte[8]; //byte형식의 객체 8자리를 줌 
        random.nextBytes(salt); //임의의 바이트를 생성하여 사용자 제공 바이트 배열에 배치합니다,  생성 된 임의의 바이트 수는 바이트 배열의 길이와 같습니다.
         
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < salt.length; i++) {
            // byte 값을 Hex 값으로 바꾸기.
            sb.append(String.format("%02x",salt[i]));
        }
        return sb.toString();
    }
}
