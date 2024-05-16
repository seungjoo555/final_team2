package kr.kh.team2.service;

import java.util.ArrayList;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.MemberDAO;
import kr.kh.team2.model.dto.ChangePwTempDTO;
import kr.kh.team2.model.dto.LoginDTO;
import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.model.dto.SnsSignupDTO;
import kr.kh.team2.model.dto.SignupDetailDTO;
import kr.kh.team2.model.vo.member.MeVerifyVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.utils.Methods;



@Service
public class MemberServiceImp implements MemberService {
	private Methods methods = new Methods();
	
	@Autowired
	MemberDAO memberDao;
  
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public MemberVO signUp(SignupDTO signupDto) {
		// null check
		if(signupDto == null) {
			System.out.println("null dto");
			System.out.println("signupDto : "+signupDto);
			return null;
		}
		if(!methods.checkString(signupDto.getId())
			|| !methods.checkString(signupDto.getPw())
			|| !methods.checkString(signupDto.getNickname())
			|| !methods.checkString(signupDto.getName())
			|| !methods.checkString(signupDto.getPhone())
			|| !methods.checkString(signupDto.getAdd1())) {
			System.out.println("null String");
			System.out.println("signupDto : "+signupDto);
			return null;
		}
		
		signupDto.setPw(passwordEncoder.encode(signupDto.getPw()));
		
		MemberVO member = new MemberVO(signupDto);
			
		boolean res = memberDao.insertMember(member);
		
		if(res) {
			return member;
		}
		return null;
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
	public String findId(String me_name, String me_phone) {
		if(!methods.checkString(me_phone)||!methods.checkString(me_name)) {
			return null;
		}
		
		String dbMemberId = memberDao.idFind(me_name,me_phone);
		
		if(!methods.checkString(dbMemberId)) {
			return null;
		}
		
		return dbMemberId;
		
		
	}

	@Override
	public void updateMemberCookie(MemberVO user) {
		if(user == null)
			return;
		memberDao.updateMemberCookie(user);
		
	}

	@Override
	public MemberVO getMemberByCookie(String sessionId) {
		return memberDao.selectMemberByCookie(sessionId);
	}

	@Override
	public MemberVO findPw(String me_id, String me_phone) {
		
		if(!methods.checkString(me_id) || !methods.checkString(me_phone)) {
			return null;
		}
		
		MemberVO dbMember = memberDao.pwFind(me_id,me_phone);
		
		return dbMember;
		
		
	}

	@Override
	public boolean findMailForm(String me_id) {
		if(!methods.checkString(me_id)) {
			return false;
		}
		String authKey = randomAuthKey(6);
		String title = "비밀번호 찾기를 위한 인증키 입니다.";
		String content = "비밀번호 인증키는 <b>"+ authKey +"</b> 입니다.";
		MeVerifyVO meVerify = new MeVerifyVO();
		meVerify.setMv_me_id(me_id);
		meVerify.setMv_code(authKey);
		
		MemberVO dbMember = memberDao.findMemberById(me_id);
		
		if(dbMember == null) {
			return false;
		}
		
		deleteVerify(me_id);
		boolean res = findMailSend(me_id,title,content) && memberDao.insertMemberVerify(meVerify);
		
		return res;
	}
	
	private void deleteVerify(String me_id) {
		
		memberDao.deleteMemberVerify(me_id);
	}
	
	private boolean findMailSend(String me_id, String title, String content) {
	   String setfrom = "mimsso9703@gmail.com";
	   try{
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper messageHelper
	            = new MimeMessageHelper(message, true, "UTF-8");

	        messageHelper.setFrom(setfrom);// 보내는사람 생략하거나 하면 정상작동을 안함
	        messageHelper.setTo(me_id);// 받는사람 이메일
	        messageHelper.setSubject(title);// 메일제목은 생략이 가능하다
	        messageHelper.setText(content, true);// 메일 내용

	        mailSender.send(message);
	        return true;
	    } catch(Exception e){
	        e.printStackTrace();
	        return false;
	    }
	}

	private String randomAuthKey(int size) {
		int min = 0, max = 26 + 26 + 10 + 3 - 1;
		String authKey = "";
		while(authKey.length() < size) {
			int r = (int)(Math.random() * (max-min + 1) + min);
			//r:0~9 => 숫자 0~9
			if(r < 10) {
				authKey += r;
			}
			//r:10~35 => a~z
			else if(r < 36) {
				authKey += (char)('a' + r - 10);
			}
			//r:36~61 => A-Z
			else if(r < 62) {
				authKey += (char)('A' + r - 36);
			}
			//r:62 => !
			else if(r == 62) {
				authKey += '!';
			}
			//r:63 => @
			else if(r == 63) {
				authKey += '@';
			}
			//r:64 => #
			else if(r == 64) {
				authKey += '#';
			}
		}
		return authKey;
	}

	@Override
	public boolean findPwVerify(MeVerifyVO meVerify) {
		/*
		 * 비번 찾기 흐름
		 * 1. 이메일 / 전화번호 입력 후 이메일 인증 진행
		 * 2. 이메일 인증으로 받은 코드를 인증완료할 시 회원의 비밀번호 변경
		 * 2-1. 인증버튼을 누르지 않거나, 인증번호가 틀리다면 회원의 비밀번호는 변경하지 않음.
		 * 3. me_tempPw 속성을 1로 바꿈.
		 * 4. 완료 후 로그인창으로 이동.
		 */
		
		if(meVerify == null || !methods.checkString(meVerify.getMv_code())||
					!methods.checkString(meVerify.getMv_me_id())) {
			return false;
		}
		
		MeVerifyVO dbVerify = memberDao.selectMeVerify(meVerify);
		
		if(dbVerify ==null) {
			return false;
		}
		if(dbVerify.getMv_code().equals(meVerify.getMv_code())) {
			deleteVerify(meVerify.getMv_me_id());
			MemberVO dbMember = memberDao.findMemberById(meVerify.getMv_me_id());
			dbMember.setMe_pw(passwordEncoder.encode(dbVerify.getMv_code()));
			boolean res = memberDao.updateMemberPwToTemp(dbMember);
			if(res) {
				return true;
			}
		}
		return false;
		
	}

	@Override
	public boolean changePwTemp(ChangePwTempDTO cptDTO,String me_id) {
		if(!methods.checkString(cptDTO.getMe_pw()) || !methods.checkString(cptDTO.getMe_id())) {
			return false;
		}
		
		if(!me_id.equals(cptDTO.getMe_id())) {
			return false;
		}
		
		cptDTO.setMe_pw(passwordEncoder.encode(cptDTO.getMe_pw()));
		
		return memberDao.updateMemberPwToNorm(cptDTO);
	}

	@Override
	public boolean sendVerifyMail(String me_id) {
		if(!methods.checkString(me_id)) {
			return false;
		}
		String authKey = randomAuthKey(6);
		String title = "회원가입을 위한 인증키입니다.";
		String content = "회원가입 인증키는 <b>"+ authKey +"</b> 입니다.";
		MeVerifyVO meVerify = new MeVerifyVO();
		meVerify.setMv_me_id(me_id);
		meVerify.setMv_code(authKey);
		
		MemberVO dbMember = memberDao.findMemberById(me_id);
		
		if(dbMember == null) {
			return false;
		}
		
		deleteVerify(me_id);
		boolean res = findMailSend(me_id,title,content) && memberDao.insertMemberVerify(meVerify);
		
		return res;
	}

	@Override
	public boolean signupVerify(MeVerifyVO meVerify) {
		if(meVerify == null || !methods.checkString(meVerify.getMv_code())||
				!methods.checkString(meVerify.getMv_me_id())) {
			
			return false;
		}
		
		MeVerifyVO dbVerify = memberDao.selectMeVerify(meVerify);
		
		if(dbVerify ==null) {
			return false;
		}
		
		if(dbVerify.getMv_code().equals(meVerify.getMv_code())) {
			deleteVerify(meVerify.getMv_me_id());
			MemberVO dbMember = memberDao.findMemberById(meVerify.getMv_me_id());
			dbMember.setMe_verify(1);
			
			boolean res = memberDao.updateMemberVerify(dbMember);
			if(res) {
				return true;
			}
			
		}
		
		return false;
  }
  
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

	@Override
	public ArrayList<MemberVO> getAdminMemberList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 10);
		}
		
		return memberDao.selectAdminMemberList(cri);
	}

	@Override
	public ArrayList<String> getMemberAuthList() {
		return memberDao.selectMemberAuthList();
	}

	@Override
	public boolean updateMember(MemberVO member) {
		if(member == null || !methods.checkString(member.getMe_id())|| !methods.checkString(member.getMe_ma_auth())|| !methods.checkString(member.getMe_ms_state()))
		return false;
		return memberDao.updateMember(member);
	}

	@Override
	public boolean deleteMember(String me_id) {
		if(!methods.checkString(me_id))
			return false;
		return memberDao.deleteMemberVO(me_id);
	}

	@Override
	public int getAdminMemberTotalCount(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 10);
		}
		return memberDao.selectAdminMemberTotalCount(cri);
	}

	@Override
	public MemberVO loginSns(String sns, String id) {
		MemberVO user = memberDao.selectMemberSns(sns,id);
		
		return user;
		
	}

	@Override
	public boolean signupSns(SnsSignupDTO ssd) {
		
		return memberDao.insertMemberSns(ssd);
	}

	@Override
	public int idCheckSns(String email,String sns) {
		
		MemberVO user = memberDao.findMemberById(email);
		
		
		//2 = signup
		if(user == null) {
			return 2;
		}
		//1 = login
		if(user.getMe_type().equals(sns)) {
			return 1;
		}
		//3 = 내가 시도하는 sns로그인 외의 방법으로 만들어진 이메일 계정
		return 3;

  }
  
	public boolean updateMemberDetail(String me_id, SignupDetailDTO signupDetailDto) {
		if(me_id == null) {
			System.out.println("null id");
			return false;
		}
		if(signupDetailDto == null) {
			System.out.println("null detail");
			return false;
		}
		
		return memberDao.updateMemberDetail(me_id, signupDetailDto);
	}
	
}
