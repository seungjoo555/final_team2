package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;

public interface MentorDAO {
	
	ArrayList<MetoringVO> selectMentorList(@Param("cri")Criteria cri);

	int selectMentorTotalCount(@Param("cri")Criteria cri);

	ArrayList<MentorJobVO> selectJobList();

	boolean insertMentorInfo(@Param("mt_info")MentorInfoVO mentorInfoVO);

	MentorInfoVO selectMentorInfo(@Param("me_id")String me_id);

}
