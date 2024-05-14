package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.dto.MentorInfoDTO;
import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.model.vo.member.MentoringApplyVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.CriteriaMentor;

public interface MentorService {
	
	ArrayList<MetoringVO> getMentorList(CriteriaMentor cri);

	int getMentorTotalCount(CriteriaMentor cri);

	ArrayList<MentorJobVO> getJobList();

	boolean insertMentorInfo(MentorInfoVO mentorInfoVO);

	MentorInfoVO checkMentor(String me_id);

	MetoringVO getMentoring(int ment_num);

	MentorInfoVO getMentor(String ment_me_id);

	boolean insertMentoringApply(MentoringApplyVO mentoApVO, MemberVO user);
	
	ArrayList<MetoringVO> getMentoringList(String me_id);

	ArrayList<TotalCategoryVO> getMentoCategory(int ment_num, String table2);

  MentorInfoVO getMentorInfo(String me_id);

	MetoringVO getMetoring(String me_id);

	ArrayList<ProgrammingCategoryVO> getProgrammingCategory();

	boolean insertMentoring(MetoringVO mentoring, TotalCategoryVO toCt);

	ArrayList<MentorInfoVO> getMentorInfoList(Criteria cri);

	int getMentorInfoTotalCount(Criteria cri);

	boolean mentorMultiRequest(MentorInfoDTO mentorInfoDTO);

	boolean mentorRequest(String mentIf_me_id, String btnType);

	boolean updateMentorInfoForDenied(MentorInfoVO mentorInfoVO, String me_id);

	boolean updateMentoring(MetoringVO mentoring, TotalCategoryVO toCt);

	boolean deleteMentoring(Integer mentNum);

	MentoringApplyVO getMentoringApply(int num, MemberVO user);




}
