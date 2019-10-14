package global.sesoc.test303.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Exercise {
	private String exernum;
	private String exername;
	private double calburn;
	private String originalfile;
	private String uploadfile;
	private int totaltime;
}
