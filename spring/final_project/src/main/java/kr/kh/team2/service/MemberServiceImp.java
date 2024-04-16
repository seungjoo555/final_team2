package kr.kh.team2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import kr.kh.team2.model.dto.LoginDTO;
import kr.kh.team2.dao.MemberDAO;
import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.utils.Methods;



@Service
public class MemberServiceImp implements MemberService {
	private Methods methods = new Methods();
	
	@Autowired
	MemberDAO memberDao;
  
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public boolean signUp(SignupDTO signupDto) {
		// null check
		if(signupDto == null) {
			System.out.println("null dto");
			System.out.println("signupDto : "+signupDto);
			return false;
		}
		if(!methods.checkString(signupDto.getId())
			|| !methods.checkString(signupDto.getPw())
			|| !methods.checkString(signupDto.getNickname())
			|| !methods.checkString(signupDto.getName())
			|| !methods.checkString(signupDto.getPhone())
			|| !methods.checkString(signupDto.getAdd1())
			|| !methods.checkString(signupDto.getAdd2())) {
			System.out.println("null String");
			System.out.println("signupDto : "+signupDto);
			return false;
		}
		
		signupDto.setPw(passwordEncoder.encode(signupDto.getPw()));
		
		MemberVO member = new MemberVO(signupDto);
			
		return memberDao.insertMember(member);
	}

	@Override
	public boolean idCheck(String id) {
		MemberVO member = memberDao.findMemberById(id);
		return member == null;
	}

	@Override
	public boolean nicknameCheck(String nickname) {
		MemberVO member = memberDao.findMemberByNickname(nickname);
		return member == null;
	}

	
	
	
	@Override
	public MemberVO login(LoginDTO loginDTO) {
		if(loginDTO == null||
		   !methods.checkString(loginDTO.getId())||
		   !methods.checkString(loginDTO.getPw())) {
			return null;
		}
		
		MemberVO user = memberDao.findMemberById(loginDTO.getId());
		
		if(user == null ||
		   !passwordEncoder.matches(loginDTO.getPw(), user.getMe_pw())){
			return null;
		}
		
		return user;
	}
	
	
}
