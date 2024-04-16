package kr.kh.team2.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.member.MemberVO;

public interface MemberDAO {

	MemberVO selectMember(@Param("id")String id);

}
