package kr.kh.team2.service;

import java.util.ArrayList;

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

	@Override
	public MemberVO getMember(String me_id) {
		if(me_id == null) {
			return null;
		}
		System.out.println(memberDao.selectMember(me_id));
		return memberDao.selectMember(me_id);
	}

	@Override
	public boolean updateProfile(String me_id, MemberVO member) {
		if(me_id == null) {
			return false;
		}
		System.out.println(memberDao.updateProfile(me_id, member));
		return memberDao.updateProfile(me_id, member);
	}

	@Override
	public ArrayList<String> getMemberStateList() {
		return memberDao.selectMemberStateList();
	}

	@Override
	public boolean updateMemberState(String set_me_id, String set_state) {
		if(!methods.checkString(set_state)||!methods.checkString(set_me_id)) {
			return false;
		}
		return memberDao.updateMemberState(set_me_id, set_state);
	}
	
	
}
