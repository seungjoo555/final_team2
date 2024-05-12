package kr.kh.team2.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MutualReviewDTO {
    private String memo;		// 평가 내용
    private int rate;			// 평가 점수
    private String user_id;		// 평가자 아이디
    private String target_id;	// 평가 대상 아이디
    private int num;			// 그룹 번호
    
}
