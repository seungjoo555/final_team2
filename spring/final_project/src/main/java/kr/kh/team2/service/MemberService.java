package kr.kh.team2.service;

import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface MemberService {

	boolean signUp(SignupDTO signupDto);

}
