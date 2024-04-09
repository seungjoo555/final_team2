package kr.kh.team2.model.vo.common;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReportVO {
	private int repo_num;
    private String repo_repo_content;
    private String repo_repo_state;
    private String repo_me_id;
    private String repo_detail;
    private Date repo_date;
    private String repo_table;
    private String repo_target;
}
