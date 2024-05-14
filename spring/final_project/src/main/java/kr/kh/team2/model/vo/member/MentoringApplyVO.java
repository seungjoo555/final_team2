package kr.kh.team2.model.vo.member;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MentoringApplyVO {
	private int mentAp_num;
    private int mentAp_ment_num;
    private String mentAp_me_id;
    private String mentAp_content;
    private String mentAp_contact;
    private int mentAp_state;
}
