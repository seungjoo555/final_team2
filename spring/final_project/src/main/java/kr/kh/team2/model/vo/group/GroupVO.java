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
    private String leader; // 그룹 리더의 아이디
    
}
