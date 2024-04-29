package kr.kh.team2.model.vo.group;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MutualReviewVO {
	private int mure_num;
    private String mure_content;
    private int mure_rate;
    private String mure_me_id;
    private String mure_target_id;
    private int mure_go_num;
    private int recu_type;
}
