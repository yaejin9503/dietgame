package global.sesoc.test303.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Diet_table {
	private int diet_num;
	private String diet_name;
	private String mon; 
	private String tue;
	private String wed;
	private String thr;
	private String fri;
	private String sat;
	private String sun;
	private String morning;
	private String lunch;
	private String dinner;
}
