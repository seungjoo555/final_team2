package kr.kh.team2.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.member.MemberVO;

public interface MemberDAO {

	boolean insertMember(@Param("member")MemberVO member);

	MemberVO findMemberById(@Param("id")String id);

	MemberVO findMemberByNickname(@Param("nickname")String nickname);

}
