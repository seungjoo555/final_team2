package kr.kh.team2.service;


import kr.kh.team2.model.dto.LoginDTO;
import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface MemberService {


	MemberVO login(LoginDTO loginDTO);
  
	boolean signUp(SignupDTO signupDto);

	boolean idCheck(String id);

	boolean nicknameCheck(String nickname);


}
