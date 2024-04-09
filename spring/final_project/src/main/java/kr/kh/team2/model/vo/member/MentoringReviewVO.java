package kr.kh.team2.model.vo.member;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MentoringReviewVO {
	private int mentRv_num;
    private String mentRv_content;
    private int mentRv_rate;
    private Date mentRv_date;
    private int mentRv_ment_num;
    private int mentRv_mentAp_num;
}
