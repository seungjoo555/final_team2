package kr.kh.team2.service;


import java.util.ArrayList;

import kr.kh.team2.model.dto.ChangePwTempDTO;
import kr.kh.team2.model.dto.LoginDTO;
import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.model.dto.SnsSignupDTO;
import kr.kh.team2.model.vo.member.MeVerifyVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;

public interface MemberService {


	MemberVO login(LoginDTO loginDTO);
  
	MemberVO signUp(SignupDTO signupDto);

	boolean idCheck(String id);

	boolean nicknameCheck(String nickname);

	MemberVO getMember(String me_id);

	boolean updateProfile(String me_id, MemberVO memberVo);

	String findId(String me_name, String me_phone);

	void updateMemberCookie(MemberVO user);

	MemberVO getMemberByCookie(String sessionId);

	MemberVO findPw(String me_id, String me_phone);

	boolean findMailForm(String me_id);

	boolean findPwVerify(MeVerifyVO meVerify);

	boolean changePwTemp(ChangePwTempDTO cptDTO, String me_id);

	boolean sendVerifyMail(String me_id);

	boolean signupVerify(MeVerifyVO meVerify);

	ArrayList<String> getMemberStateList();

	boolean updateMemberState(String set_me_id, String set_state);

	ArrayList<MemberVO> getAdminMemberList(Criteria cri);

	ArrayList<String> getMemberAuthList();

	boolean updateMember(MemberVO member);

	boolean deleteMember(String me_id);

	int getAdminMemberTotalCount(Criteria cri);

	MemberVO loginSns(String sns, String id);

	boolean signupSns(SnsSignupDTO ssd);

	int idCheckSns(String email,String sns);

}
