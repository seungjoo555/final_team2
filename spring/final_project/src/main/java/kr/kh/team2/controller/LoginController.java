package kr.kh.team2.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.kh.team2.model.dto.LoginDTO;
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
			model.addAttribute("user",user);
			model.addAttribute("msg","로그인 되었습니다.");
			model.addAttribute("url","/");
			return "message"; 
		}
		
		model.addAttribute("msg","로그인 하지 못했습니다.");
		model.addAttribute("url","/login");
		return "message";
	}
	
	@RequestMapping(value ="/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, Model model) {
		session.removeAttribute("user");
		
		model.addAttribute("msg", "로그아웃 했습니다.");
		model.addAttribute("url", "/");
		return "message";
	}
		
	@RequestMapping(value = "/login/findid", method = RequestMethod.GET)
	public String findId() {
		
		
		return "/login/findid";
	}
	
	@RequestMapping(value = "/login/findidcom", method = RequestMethod.GET)
	public String findIdCom() {
		
		return "/login/findidcom";
	}
	
	@RequestMapping(value = "/login/findpw", method = RequestMethod.GET)
	public String findPw() {
		
		return "/login/findpw";
	}
	

}
