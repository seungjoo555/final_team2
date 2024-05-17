package kr.kh.team2.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team2.model.dto.SnsSignupDTO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.service.MemberService;

@Controller
public class SnsController {
	
	@Autowired
	MemberService memberService;
	
	
	//이메일과 sns 타입이 동일하면 있는회원
	@ResponseBody
	@PostMapping("/sns/{sns}/check/id")
	public int snsCheckId(@PathVariable("sns")String sns, @RequestParam("email")String email) {
		System.out.println(email);
		
		int res = memberService.idCheckSns(email,sns);
		
		return res;
		
		// return : 
		
		// 있어서 로그인 하는경우(본인인경우)
		// 없어서 회원가입해야하는경우
		// 다른 sns로 이미 회원가입되어있는경우 
		
		
	}
	

	
	@ResponseBody
	@PostMapping("/sns/{sns}/signup")
	public boolean snsSignup(@PathVariable("sns")String sns, 
			@RequestBody SnsSignupDTO ssd,HttpSession session) {
			
		ssd.setMe_pw("");
		
		boolean res = memberService.signupSns(ssd);
		
		if(res) {
			MemberVO user = memberService.getMember(ssd.getEmail());
			session.setAttribute("user", user);
		}
		
		
		return res;
	}
	
	@ResponseBody
	@PostMapping("/sns/{sns}/login")
	public boolean snsLogin(@PathVariable("sns")String sns, @RequestParam("email")String email, HttpSession session) {
		MemberVO user = memberService.loginSns(sns, email); 
		session.setAttribute("user", user);
		return user != null;
	}
	
	
}
