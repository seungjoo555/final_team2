package kr.kh.team2.model.vo.community;

import lombok.NoArgsConstructor;

import lombok.Data;

@Data
@NoArgsConstructor
public class CommentVO {
	private int cmmt_num;
    private String cmmt_content;
    private int cmmt_repoCount;
    private int cmmt_post_num;
    private String cmmt_me_id;
}
