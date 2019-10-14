package global.sesoc.test303.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Diet_user_security {
	private String userid; 
	private byte[] password;
	private String name;
	private String gender;
	private String address;
	private String email;
	private int age; 
	private double height;
	private double weight;
	private double hopeweight;
	private double kcalresult;
	private String salt;
}
