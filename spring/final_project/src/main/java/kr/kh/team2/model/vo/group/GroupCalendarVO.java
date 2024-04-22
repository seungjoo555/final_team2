package kr.kh.team2.model.vo.group;

import java.util.Calendar;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GroupCalendarVO {
	private int gocal_num;
    private String gocal_title;
    private Date gocal_startdate;
    private Date gocal_enddate;
    private String gocal_memo;
    private String gocal_me_id;
    private int gocal_go_num;
    
    private String dday;

	public void setGocal_startdate(Date gocal_startdate) {
		this.gocal_startdate = gocal_startdate;
		calcDday();
	}

	private void calcDday() {
		int year, month, day; String result = "";
		Calendar calDate = Calendar.getInstance();
		Calendar today = Calendar.getInstance();
		
		Date now = new Date(); // 현재 시간 생성
		
		// Date를 Calendar형으로 변환
		today.setTime(now);
		calDate.setTime(gocal_startdate); 

				
		// 날짜 계산
		year = calDate.get(Calendar.YEAR) - today.get(Calendar.YEAR);
		month = calDate.get(Calendar.MONTH) - today.get(Calendar.MONTH); // 결과값이 0~11
		day = calDate.get(Calendar.DATE) - today.get(Calendar.DATE);
		
		if(year != 0) { 
			// 다른 해에 설정된 일정일 경우,
		}
		
		else if(month != 0) { 
			// 같은 해 다른 달에 설정된 일정일 경우
		}
		
		else if(day != 0) { 
			// 같은 달 다른 일에 설정된 일정일 경우
		}
		else { 
			result = "-DAY";
		}
			
		setDday(result);
		
	}
    
    
}
