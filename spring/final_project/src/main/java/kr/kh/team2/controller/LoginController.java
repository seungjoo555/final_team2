package kr.kh.team2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		
		return "/login/login"; 
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
