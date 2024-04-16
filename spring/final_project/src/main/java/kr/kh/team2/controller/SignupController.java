package kr.kh.team2.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.service.MemberService;

@Controller
public class SignupController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/signup")
	public String signup(){
		
		return "/signup/signup";
	}
	
	@ResponseBody
	@GetMapping("/id/check")	
	public Map<String, Object> idCheckDup(@RequestParam("id") String id){
		Map<String, Object> map = new HashMap<String, Object>();
		
//		System.out.println("id="+id);
		boolean res = memberService.idCheck(id);
		
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@GetMapping("/nickname/check")	
	public Map<String, Object> idNicknameDup(@RequestParam("nickname") String nickname){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean res = memberService.nicknameCheck(nickname);
		
		map.put("result", res);
		return map;
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
