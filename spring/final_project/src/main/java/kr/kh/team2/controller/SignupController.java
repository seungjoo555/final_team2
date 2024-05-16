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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team2.model.dto.SignupDTO;
import kr.kh.team2.model.dto.SignupDetailDTO;
import kr.kh.team2.model.vo.member.MeVerifyVO;
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
	public String signupPost(Model model, SignupDTO signupDto, HttpSession session){
//		System.out.println("signupDto: "+signupDto);
		MemberVO user = memberService.signUp(signupDto);
		if(user!=null) {
			session.setAttribute("user", user);
			model.addAttribute("msg", "회원가입을 완료했습니다. 이메일 인증을 완료하셔야 사이트 이용이 정상적으로 가능합니다.");
			model.addAttribute("url", "/signup/verify");
		}else {
			model.addAttribute("msg", "회원가입을 하지 못했습니다");
			model.addAttribute("url", "/signup");
		}
		return "message";
		
	}
	
	@GetMapping("/signup/verify")
	public String signupVerify(HttpSession session, Model model){
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		if(user==null) {
			model.addAttribute("msg","로그인 후 진행해주세요.");
			model.addAttribute("url","/login");
			return "message";
		}
		
		if(user.getMe_verify()==1) {
			model.addAttribute("msg","이미 이메일인증을 완료한 계정입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		
		return "/signup/verify";
	}
	
	@ResponseBody
	@GetMapping("/signup/sendAuth")
	public String sendVerifyMail(@RequestParam String me_id,HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		boolean res;
		
		if(user == null) {
			return "-1";
		}
		
		if(!user.getMe_id().equals(me_id)) {
			return "-2";
		}
		
		if(user.getMe_verify()==1) {
			return "-3";
			
		}
		
		
		res = memberService.sendVerifyMail(me_id);
		
		return res + "";
	}
	
	@ResponseBody
	@PostMapping("/signup/checkverify")
	public Map<String, Object> checkVerify(@RequestBody MeVerifyVO meVerify, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean res = memberService.signupVerify(meVerify);
		
		if(res) {
			MemberVO user = memberService.getMember(meVerify.getMv_me_id());
			if(user!=null) {
				session.setAttribute("user", user);
			}
		}
		
		map.put("res", res+"");
		
		
		return map;
	}
	
	@PostMapping("/signup/verify")
	public String signupVerifyPost(){
		
		return "/signup/detail";
	}
	
	@GetMapping("/signup/detail")
	public String signUpDetail() {
		
		return "/signup/detail";
	}
	
	@PostMapping("/signup/detail")
	public String signUpDetailPost(HttpSession session, Model model, SignupDetailDTO signupDetailDto) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		if(memberService.updateMemberDetail(user.getMe_id(), signupDetailDto)) {
			session.setAttribute("user", user);
			model.addAttribute("msg", "상세 정보를 저장했습니다.");
			model.addAttribute("url", "/mypage/profile/?me_id=" + user.getMe_id());
		}else {
			model.addAttribute("msg", "상세 정보를 저장 하지 못했습니다");
			model.addAttribute("url", "/signup/detail");
		}
		return "message";
	}
}
