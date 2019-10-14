package global.sesoc.test303.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Food {
	private int food_num;
	private String food_name;
	private String food_code;
	private int cal; 
	private int totalcal;
	private String originalfile;
	private String uploadfile;
	private double portein; 
	private double fat; 
	private double carb; 
	private double sugar; 
	private double na; 
	private String todaytime; 
}
