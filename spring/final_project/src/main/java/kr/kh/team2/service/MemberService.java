package kr.kh.team2.service;


import kr.kh.team2.model.dto.LoginDTO;
import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface MemberService {


	MemberVO login(LoginDTO loginDTO);
  
	boolean signUp(SignupDTO signupDto);

	boolean idCheck(String id);

	boolean nicknameCheck(String nickname);

	MemberVO getMember(String me_id);

	boolean updateProfile(String me_id, MemberVO memberVo);


}
