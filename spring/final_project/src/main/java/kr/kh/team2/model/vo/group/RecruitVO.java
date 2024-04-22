package kr.kh.team2.model.vo.group;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RecruitVO {
	private int recu_num;
    private int recu_go_num;
    private String recu_content;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date recu_due;
    private int recu_state;
    private int recu_type;
    private String recu_topic;
    private String recu_target;
    private int recu_count;
    private String recu_required;
    private String recu_preferred;
    private int recu_online;
    private int recu_interview;
    private int recu_repoCount;
    //리더 닉네임
    private String recu_gome_me_nickname;
}
