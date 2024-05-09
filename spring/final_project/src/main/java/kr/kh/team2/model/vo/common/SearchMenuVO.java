package kr.kh.team2.model.vo.common;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SearchMenuVO {
	private int sear_num;
	private int progCt_num;
	private String progCt_name;
	private int lang_num;
	private String lang_name;
	private String searchType = "all";
}
