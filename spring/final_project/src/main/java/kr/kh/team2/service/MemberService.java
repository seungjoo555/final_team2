package kr.kh.team2.service;


import java.util.ArrayList;

import kr.kh.team2.model.dto.LoginDTO;
import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;

public interface MemberService {


	MemberVO login(LoginDTO loginDTO);
  
	boolean signUp(SignupDTO signupDto);

	boolean idCheck(String id);

	boolean nicknameCheck(String nickname);

	MemberVO getMember(String me_id);

	boolean updateProfile(String me_id, MemberVO memberVo);

	ArrayList<String> getMemberStateList();

	boolean updateMemberState(String set_me_id, String set_state);

	ArrayList<MemberVO> getAdminMemberList(Criteria cri);

	ArrayList<String> getMemberAuthList();

	boolean updateMember(MemberVO member);

	boolean deleteMember(String me_id);

	int getAdminMemberTotalCount(Criteria cri);


}
