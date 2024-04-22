package kr.kh.team2.model.vo.group;

import java.util.Calendar;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GroupPostVO {
	private int gopo_num;
    private String gopo_content;
    private Date gopo_date;
    private String gopo_gome_me_id;
    private int gopo_gome_go_num;
    
    private String nickname;
    private String time_ago; // n일 전, n시간 전 등 표기할 때 필요
    
	public void setGopo_date(Date date){
		this.gopo_date = date;
		calcTimeAgo();
	}
	
	// 'n시간 전' 문자열 생성 메서드 | setTime_ago()
	private void calcTimeAgo() {
		int year, month, day, hour, min; String result;
		Calendar postDate = Calendar.getInstance();
		Calendar today = Calendar.getInstance();
		
		Date now = new Date(); // 현재 시간 생성
		
		// Date를 Calendar형으로 변환
		today.setTime(now);
		postDate.setTime(gopo_date); 
		
		// 날짜 계산
		year = postDate.get(Calendar.YEAR) - today.get(Calendar.YEAR);
		month = postDate.get(Calendar.MONTH) - today.get(Calendar.MONTH); // 결과값이 0~11
		day = postDate.get(Calendar.DATE) - today.get(Calendar.DATE);
		
		hour = postDate.get(Calendar.HOUR_OF_DAY) - today.get(Calendar.HOUR_OF_DAY);
		min = postDate.get(Calendar.MINUTE) - today.get(Calendar.MINUTE);
		
		if(year < 0) { 
			// 지난 해에 쓰인 글일 경우,
			result = -(year) + "년 전";
		}
		
		else if(month < 0) { 
			// 같은 해 지난 달에 쓰인 글일 경우
			result = -(month) + "개월 전";
		}
		
		else if(day < 0) { 
			// 같은 월 지난 일에 쓰인 글일 경우
			result = -(day) + "일 전";
		}
		
		else if(hour < 0) { 
			// 같은 날 지난 시간에 쓰인 글일 경우
			result = -(hour) + "시간 전";
		}
		
		else if(min < 0) { 
			// 같은 시간 몇분 전에 쓰인 글일 경우
			result = -(min) + "분 전";
		}
		
		else { 
			result = "방금 전";
		}
			
		setTime_ago(result);
	}
    
    
}
