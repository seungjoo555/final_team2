package kr.kh.team2.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface RecruitDAO {

	boolean insertGroup(@Param("group")GroupVO group);
	
	boolean insertRecruit(@Param("group")int go_num, @Param("recruit")RecruitVO recruit, @Param("user")MemberVO user);
	
}
