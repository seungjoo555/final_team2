package kr.kh.team2.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team2.model.dto.ChangePwTempDTO;
import kr.kh.team2.model.dto.LoginDTO;
import kr.kh.team2.model.vo.member.MeVerifyVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.service.MemberService;

@Controller
public class LoginController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		
		return "/login/login"; 
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(Model model, LoginDTO loginDTO) {
		MemberVO user = memberService.login(loginDTO);
		if(user!= null) {
			if(user.getMe_verify()==0) {
				model.addAttribute("msg","이메일 인증을 완료하셔야 사이트 이용이 정상적으로 가능합니다.");
				model.addAttribute("url","/signup/verify");
			}else {
				model.addAttribute("msg","로그인 되었습니다.");
				model.addAttribute("url","/");
			}
			user.setAutoLogin(loginDTO.isAutoLogin());
			model.addAttribute("user",user);
			return "message"; 
		}
		
		model.addAttribute("msg","로그인 하지 못했습니다.");
		model.addAttribute("url","/login");
		return "message";
	}
	
	@RequestMapping(value ="/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, Model model) {
		//자동로그인 해제
		MemberVO user = (MemberVO) session.getAttribute("user");
		user.setMe_cookie(null);
		user.setMe_cookie_limit(null);
		memberService.updateMemberCookie(user);
		//세션 정보 제거
		session.removeAttribute("user");
		model.addAttribute("msg", "로그아웃 했습니다.");
		model.addAttribute("url", "/");
		return "message";
	}
		
	@RequestMapping(value = "/login/findid", method = RequestMethod.GET)
	public String findId() {
		
		
		return "/login/findid";
	}
	
	@PostMapping("/login/findid")
	public String findIdPost(String me_name,String me_phone,Model model) {
		
		String dbId = memberService.findId(me_name,me_phone);
		
		if(dbId==null || dbId.length()==0) {
			model.addAttribute("msg","입력하신 정보와 일치하는 회원이 존재하지 않습니다.");
			model.addAttribute("url","/login/findid");
			return "message";
		}
		
		model.addAttribute("dbId",dbId);
		return "/login/findidcom";
		
		
		
	}
	
	@RequestMapping(value = "/login/findidcom", method = RequestMethod.GET)
	public String findIdCom() {
		
		return "/login/findidcom";
	}
	

	
	@RequestMapping(value = "/login/findpw", method = RequestMethod.GET)
	public String findPw() {
		
		return "/login/findpw";
	}
	
	@PostMapping("/login/findpw")
	public String findPwPost(String me_id, String me_phone,Model model) {
		
		MemberVO dbMember  = memberService.findPw(me_id,me_phone);
		
		if(dbMember !=null) {
			model.addAttribute("dbMember",dbMember);
			model.addAttribute("event","true");
			return "/login/authentication";
		}
		
		model.addAttribute("msg","입력하신 정보와 일치하는 회원이 존재하지 않습니다.");
		model.addAttribute("url","/login/findpw");
		return "message";
		
	}
	
	@GetMapping("/login/authentication")
	public String authentication(String eventStr,Model model) {
		boolean event = Boolean.parseBoolean(eventStr);
		if(!event) {
			model.addAttribute("msg","잘못된 접근입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		return "/login/authentication";
	}
	
	
	
	@ResponseBody	
	@GetMapping("/login/auth/mailsend")
	public String findMailSend(@RequestParam String me_id) {
		
		boolean res = memberService.findMailForm(me_id);
		
		return res + "";
	}
	
	@ResponseBody
	@PostMapping("/login/auth/verify")
	public Map<String, Object> findPwVerify(@RequestBody MeVerifyVO meVerify) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean res = memberService.findPwVerify(meVerify);
		map.put("res", res+"");
		return map;
		
	}
	
	@GetMapping("/login/changepwtemp")
	public String changePwTemp(HttpSession session, Model model) {
		
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		if(user == null) {
			model.addAttribute("msg","로그인 후 이용해주세요.");
			model.addAttribute("url","/login");
			return "message";
		}
		
		if(user.getMe_temppw()==0) {
			model.addAttribute("msg","잘못된 접근입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		
		return "/login/changepwtemp";
	}
	
	@PostMapping("/login/changepwtemp")
	public String changePwTempPost(ChangePwTempDTO cptDTO, HttpSession session, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		boolean res = memberService.changePwTemp(cptDTO,user.getMe_id());
		
		
		if(res) {
			model.addAttribute("msg","비밀번호가 변경되었습니다. 다시 로그인 해주세요.");
			session.removeAttribute("user");
			model.addAttribute("url","/");
			return "message";
		}
		
		model.addAttribute("msg","비밀번호 변경에 실패하였습니다,");
		model.addAttribute("url","/login/changepwtemp");
		return "message";
	}

	

}
