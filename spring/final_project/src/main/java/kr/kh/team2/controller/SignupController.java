package kr.kh.team2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class SignupController {
	
	@GetMapping("/signup")
	public String signup(){
		
		return "/signup/signup";
	}
	
	@PostMapping("/signup")
	public String signupPost(){
		return "/signup/verify";
		
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
