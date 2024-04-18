package kr.kh.team2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.service.MemberService;

@Controller
public class MypageController {
	@Autowired
	MemberService memberService;
	
	@GetMapping("/mypage/profile")
	public String mypageProfile(Model model, String me_id) {
		MemberVO member = memberService.getMember(me_id);
		System.out.println(member);
		model.addAttribute("member", member);
		return "/mypage/profile";
	}
	
	@GetMapping("mypage/mygroup")
	public String mypageMygroup(Model model, String me_id) {
		
		return "/mypage/mygroup";
	}
	
	@PostMapping("/profile/update")
	public String profileUpdate(Model model, MemberVO memberVo, String me_id) {
		
		MemberVO member = memberService.getMember(me_id);
		model.addAttribute("member", member);
		boolean res = memberService.updateProfile(member.getMe_id(), memberVo);
		
		if(res) {
			model.addAttribute("msg", "프로필을 수정했습니다.");
			model.addAttribute("url", "/mypage/profile?me_id="+me_id); 
		} else {
			model.addAttribute("msg", "프로필을 수정하지 못했습니다.");
			model.addAttribute("url", "/mypage/profile?me_id="+me_id); 
		}
		return "message";
	}
}
