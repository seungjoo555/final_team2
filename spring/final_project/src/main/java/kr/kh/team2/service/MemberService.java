package kr.kh.team2.service;


import kr.kh.team2.model.dto.ChangePwTempDTO;
import kr.kh.team2.model.dto.LoginDTO;
import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.model.vo.member.MeVerifyVO;
import kr.kh.team2.model.vo.member.MemberVO;

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


}
