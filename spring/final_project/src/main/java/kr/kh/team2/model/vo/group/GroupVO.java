package kr.kh.team2.model.vo.group;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GroupVO {
	private int go_num;
    private String go_name;
    private long go_time;
    private boolean go_update;
    private int go_member_count; // 가입한 멤버 수
    private int goap_state; // 지원 처리 상태
    private String recu_topic; // 그룹 주제
    private int recu_count; // 모집 인원
    private String recu_gome_me_nickname; //리더 닉네임
    private int recu_num;	//공고 번호
}
