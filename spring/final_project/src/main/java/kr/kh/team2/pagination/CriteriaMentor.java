package kr.kh.team2.pagination;

import java.util.ArrayList;

import kr.kh.team2.model.vo.member.MentorJobVO;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CriteriaMentor extends Criteria{
	private ArrayList<MentorJobVO> jobList = new ArrayList<MentorJobVO>(); //검색분야
	public CriteriaMentor(int page, int perPageNum) {
		super(page, perPageNum);
	}
	
	
}
