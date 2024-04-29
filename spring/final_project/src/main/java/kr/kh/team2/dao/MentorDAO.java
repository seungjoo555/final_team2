package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.model.vo.member.MentoringApplyVO;
import kr.kh.team2.model.vo.member.MetoringVO;
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

}
