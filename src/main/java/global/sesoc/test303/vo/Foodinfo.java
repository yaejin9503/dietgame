package global.sesoc.test303.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class Foodinfo {
	private int foodnum; 
	private String morning; 
	private String lunch; 
	private String dinner; 
	private String snack; 
}
