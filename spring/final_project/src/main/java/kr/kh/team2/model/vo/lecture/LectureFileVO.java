package kr.kh.team2.model.vo.lecture;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LectureFileVO {
	private int lectFi_num;
    private int lectFi_lect_num;
    private String lectFi_path;
    private String lectFi_ori_name;
    private boolean lectFi_choice;
    private boolean lectFi_link;
}
