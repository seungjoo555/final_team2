package kr.kh.team2.model.vo.group;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GroupApplyVO {
	private int goap_num;
    private int goap_go_num;
    private int goap_recu_num;
    private String goap_content;
    private int goap_state;
    private String goap_me_id;
    private String goap_me_nickname;
}
