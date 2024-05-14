package kr.kh.team2.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReportSimpleDTO {
	private String repo_repo_state;
	private String repo_table;
	private String repo_table_str;	//테이블 명
    private String repo_target;
    private String repo_target_str;	//대상명
    private int repo_count;
    

}
