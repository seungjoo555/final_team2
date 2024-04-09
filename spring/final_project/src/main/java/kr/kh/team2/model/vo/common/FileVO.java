package kr.kh.team2.model.vo.common;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FileVO {
	private int file_num;
    private String file_name;
    private String file_ori_name;
    private String file_table;
    private String file_target;
}
