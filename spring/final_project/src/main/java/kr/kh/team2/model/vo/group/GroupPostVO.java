package kr.kh.team2.model.vo.group;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GroupPostVO {
	private int gopo_num;
    private String gopo_title;
    private String gopo_content;
    private Date gopo_date;
    private String gopo_gome_me_id;
    private int gopo_gome_go_num;
}
