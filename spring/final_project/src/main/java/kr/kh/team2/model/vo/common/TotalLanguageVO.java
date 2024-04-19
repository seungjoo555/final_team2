package kr.kh.team2.model.vo.common;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TotalLanguageVO {
	private int toLg_num;
    private int toLg_lang_num;
    private String toLg_lang_name;
    private String toLg_table_name;
    private String toLg_table_pk;
}
