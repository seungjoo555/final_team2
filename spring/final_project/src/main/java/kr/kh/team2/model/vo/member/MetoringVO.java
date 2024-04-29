package kr.kh.team2.model.vo.member;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MetoringVO {
	private int ment_num;
    private String ment_title;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ment_duration;
    private String ment_me_id;
    private int ment_state;
    private String ment_content;
    //멘토 닉네임
    private String ment_me_nickname;
    //멘토 경력
    private String ment_mentIf_exp;
    //멘토 직무
    private String ment_mentIf_job;
}
