package kr.kh.team2.service;

import java.util.ArrayList;

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


}
