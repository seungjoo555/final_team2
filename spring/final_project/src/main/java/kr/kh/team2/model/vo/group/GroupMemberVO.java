package kr.kh.team2.model.vo.group;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GroupMemberVO {
	private String gome_me_id;
    private int gome_go_num;
    private int gome_type;
    private int gome_warn;
    
    private String nickname;
    private String mure_content = null; // 상호평가에서 필요
}
