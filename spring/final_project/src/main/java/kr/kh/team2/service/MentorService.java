package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.CriteriaMentor;

public interface MentorService {
	
	ArrayList<MetoringVO> getMentorList(CriteriaMentor cri);

	int getMentorTotalCount(CriteriaMentor cri);

	ArrayList<MentorJobVO> getJobList();

	boolean insertMentorInfo(MentorInfoVO mentorInfoVO);

	boolean checkMentor(String me_id);

	ArrayList<MetoringVO> getMentoringList(String me_id);

	ArrayList<TotalCategoryVO> getMentoCategory(int ment_num, String table2);

  MentorInfoVO getMentorInfo(String me_id);

	MetoringVO getMetoring(String me_id);

	ArrayList<ProgrammingCategoryVO> getProgrammingCategory();

	boolean insertMentoring(MetoringVO mentoring, TotalCategoryVO toCt);


}
