package global.sesoc.test303.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Diary2 {
	private String userid;
	private int exernum;
	private String exerdate;
	private int totaltime;
	private double calburn;
	private double weight;
}
