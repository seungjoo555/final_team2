package kr.kh.team2.model.vo.member;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MetoringVO {
	private int ment_num;
    private String ment_title;
    private Date ment_duration;
    private String ment_me_id;
    private int ment_state;
}