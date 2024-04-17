package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;

public interface MentorDAO {

	ArrayList<MentorJobVO> selectJobList();

	boolean insertMentorInfo(@Param("mt_info")MentorInfoVO mentorInfoVO);

}
