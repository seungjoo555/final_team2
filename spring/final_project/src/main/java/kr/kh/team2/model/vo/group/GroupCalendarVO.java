package kr.kh.team2.model.vo.group;

import java.text.SimpleDateFormat;
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
    
    // =========================== Setter ===========================
    
	public void setGocal_startdate(Date gocal_startdate) {
		this.gocal_startdate = gocal_startdate;
		calcDday();
	}
	
	// =========================== Constructor ===========================
	
	public GroupCalendarVO(String title, Date startdt, Date enddt, String memo) {
		gocal_title = title;
		gocal_startdate = startdt;
		gocal_enddate = enddt;
		gocal_memo = memo;
	}
	
	// =========================== Methods ===========================

	private void calcDday() {
		long todayMs, calMs; long result; String ddayResult = "";
		Calendar calDate = Calendar.getInstance();
		Calendar today = Calendar.getInstance();
		
		Date now = new Date(); // 현재 시간 생성
		
		// Date를 Calendar형으로 변환
		today.setTime(now);
		calDate.setTime(gocal_startdate); 
		
		// Calendar에 있는 날짜 정보를 ms(밀리세컨드) 단위로 변환해서 저장
		todayMs = today.getTimeInMillis();
		calMs = calDate.getTimeInMillis();
		
		result = (todayMs-calMs)/(60*60*1000*24);
		
		if(result == 0) {
			if(calDate.get(Calendar.DATE) == today.get(Calendar.DATE))
				ddayResult = "-day";
			else{
				ddayResult = "" + (result - 1);
			}
		}
		else if(result >= 999) {
			ddayResult = "+999+";
		}else if(result <= -999) {
			ddayResult = "-999+";
		}else if(result < 0){
			ddayResult = "" + (result - 1);
		}else {
			ddayResult = "+" + result;
		}
		
		setDday(ddayResult);
		
	}
    
	// date를 string으로 변환하기
	public String getGocal_startdate_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		return format.format(gocal_startdate);
	}
    
	public String getGocal_enddate_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		return format.format(gocal_startdate);
	}

}
