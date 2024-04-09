package kr.kh.team2.model.vo.community;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PostVO {
	private int post_num;
    private String post_name;
    private String post_content;
    private int post_view;
    private Date post_date;
    private int post_board_num;
    private String post_me_id;
}
