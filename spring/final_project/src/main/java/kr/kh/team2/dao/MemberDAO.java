package kr.kh.team2.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.member.MemberVO;

public interface MemberDAO {


	boolean insertMember(@Param("member")MemberVO member);

	MemberVO findMemberById(@Param("id")String id);

	MemberVO findMemberByNickname(@Param("nickname")String nickname);

	MemberVO selectMember(@Param("me_id")String me_id);

	boolean updateProfile(@Param("me_id")String me_id, @Param("member")MemberVO member);

	String idFind(@Param("me_name")String me_name, @Param("me_phone")String me_phone);

	void updateMemberCookie(@Param("user")MemberVO user);

	MemberVO selectMemberByCookie(@Param("session_id")String sessionId);

	MemberVO pwFind(@Param("me_id")String me_id, @Param("me_phone")String me_phone);
}
