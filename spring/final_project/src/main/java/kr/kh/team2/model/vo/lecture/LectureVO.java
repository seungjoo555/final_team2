package kr.kh.team2.model.vo.lecture;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LectureVO {
	private int lect_num;
    private String lect_mentIf_me_id;
    private String lect_name;
    private String lect_intro;
    private int lect_price;
    private String lect_posting;
    private String lect_update;
}
