package kr.kh.team2.model.vo.community;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardVO {
	private int board_num;
    private String board_name;
    private int board_post_count;
}
