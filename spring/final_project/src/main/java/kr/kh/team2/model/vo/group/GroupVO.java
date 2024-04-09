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
}
