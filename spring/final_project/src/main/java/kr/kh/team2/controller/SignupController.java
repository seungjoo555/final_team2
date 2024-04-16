package kr.kh.team2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.service.MemberService;

@Controller
public class SignupController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/signup")
	public String signup(){
		
		return "/signup/signup";
	}
	
	@PostMapping("/signup")
	public String signupPost(Model model, SignupDTO signupDto){
//		System.out.println("signupDto: "+signupDto);
		
		if(memberService.signUp(signupDto)) {
			model.addAttribute("msg", "회원가입을 완료했습니다");
			model.addAttribute("url", "/");
		}else {
			model.addAttribute("msg", "회원가입을 하지 못했습니다");
			model.addAttribute("url", "/signup");
		}
		return "message";
		
	}
	
	@PostMapping("/signup/verify")
	public String signupVerifyPost(){
		
		return "/signup/detail";
	}
	
	@PostMapping("/signup/detail")
	public String signupDetailPost(){
		
		return "/signup/complete";
	}
}
