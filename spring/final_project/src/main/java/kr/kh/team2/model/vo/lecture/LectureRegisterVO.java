package kr.kh.team2.model.vo.lecture;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LectureRegisterVO {
	private int lectRg_num;
    private int lectRg_lect_num;
    private String lectRg_me_id;
    private int lectRg_money;
    private boolean lectRg_state;
}
