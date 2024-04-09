package kr.kh.team2.model.vo.member;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MentorInfoVO {
	private String mentIf_me_id;
    private int mentIf_exp;
    private String mentIf_job;
    private String mentIf_portfolio;
    private String mentIf_intro;
    private String mentIf_account;
    private Date mentIf_date;
    private int mentIf_state;
}
