package kr.kh.team2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.MemberDAO;
import kr.kh.team2.model.dto.LoginDTO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.utils.Methods;

@Service
public class MemberServiceImp implements MemberService{
	Methods methods = new Methods();
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public MemberVO login(LoginDTO loginDTO) {
		if(loginDTO == null||
		   !methods.checkString(loginDTO.getId())||
		   !methods.checkString(loginDTO.getPw())) {
			return null;
		}
		
		MemberVO user = memberDAO.selectMember(loginDTO.getId());
		
		if(user == null ||
		   !passwordEncoder.matches(loginDTO.getPw(), user.getMe_pw())){
			return null;
		}
		
		return user;
	}
	
	
}
