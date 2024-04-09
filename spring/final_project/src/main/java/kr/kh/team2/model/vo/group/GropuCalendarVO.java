package kr.kh.team2.model.vo.group;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GropuCalendarVO {
	private int gocal_num;
    private String gocal_title;
    private Date gocal_startdate;
    private Date gocal_enddate;
    private String gocal_memo;
    private String gocal_me_id;
    private int gocal_go_num;
}
