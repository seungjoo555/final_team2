package kr.kh.team2.model.vo.lecture;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LectureRiviewVO {
	private int lectRv_num;
    private int lectRv_lect_num;
    private String lectRv_me_id;
    private String lectRv_content;
    private int lectRv_score;
}
