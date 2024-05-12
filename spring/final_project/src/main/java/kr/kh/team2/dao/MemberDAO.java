package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;

public interface MemberDAO {


	boolean insertMember(@Param("member")MemberVO member);

	MemberVO findMemberById(@Param("id")String id);

	MemberVO findMemberByNickname(@Param("nickname")String nickname);

	MemberVO selectMember(@Param("me_id")String me_id);

	boolean updateProfile(@Param("me_id")String me_id, @Param("member")MemberVO member);

	ArrayList<String> selectMemberStateList();

	boolean updateMemberState(@Param("me_id")String set_me_id, @Param("me_ms_state")String set_state);

	ArrayList<MemberVO> selectAdminMemberList(@Param("cri")Criteria cri);

	ArrayList<String> selectMemberAuthList();

	boolean updateMember(@Param("me") MemberVO member);

	boolean deleteMemberVO(@Param("me_id")String me_id);

	int selectAdminMemberTotalCount(@Param("cri")Criteria cri);
}
