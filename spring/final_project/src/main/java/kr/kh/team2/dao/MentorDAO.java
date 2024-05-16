package kr.kh.team2.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.model.vo.member.MentoringApplyVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.CriteriaMentor;

public interface MentorDAO {
	
	ArrayList<MetoringVO> selectMentorList(@Param("cri")CriteriaMentor cri);

	int selectMentorTotalCount(@Param("cri")CriteriaMentor cri);

	ArrayList<MentorJobVO> selectJobList();

	boolean insertMentorInfo(@Param("mt_info")MentorInfoVO mentorInfoVO);

	MentorInfoVO selectMentorInfo(@Param("me_id")String me_id);

	MetoringVO selectMentoring(@Param("ment_num")int ment_num);

	boolean insertMentoringApply(@Param("mentAp")MentoringApplyVO mentoApVO);
	ArrayList<MetoringVO> selectMentoringList(@Param("me_id") String me_id);

	ArrayList<TotalCategoryVO> selectMentoCategory(@Param("ment_num")int ment_num, @Param("table")String table2);
  
	MetoringVO selectMetoring(@Param("me_id")String me_id);

	ArrayList<ProgrammingCategoryVO> selectProgrammingCategoryList();

	boolean insertMentoring(@Param("ment")MetoringVO mentoring);

	boolean insertTotalCategory(@Param("toCt")TotalCategoryVO toCt);

	ArrayList<MentorInfoVO> selectMentorInfoList(@Param("cri")Criteria cri);

	int selectMentorInfoTotalCount(@Param("cri")Criteria cri);

	boolean mentorInfoAccept(@Param("me_id")String me_id);

	boolean updateMemberMentorInfo(@Param("me_id")String me_id);

	boolean mentorInfoDeny(@Param("me_id")String me_id);

	boolean updateMentorInfoForDenied(@Param("mt_info")MentorInfoVO mentorInfoVO,@Param("me_id") String me_id);

	boolean updateMentoring(@Param("ment")MetoringVO mentoring);

	boolean deleteMentoring(@Param("ment_num")Integer mentNum);

	MentoringApplyVO selectMentoringApply(@Param("ment_num")int num, @Param("user")MemberVO user);
	
	boolean updateMentoringApply(@Param("mentAp")MentoringApplyVO mentoringAp, @Param("user")MemberVO user);

	ArrayList<MetoringVO> selectAllMentoring();

	Date selectDue(@Param("ment_num")String reco_target);

	MetoringVO selectMentoringIF(@Param("ment_num")int ment_num);

}
