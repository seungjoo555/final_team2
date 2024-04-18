package kr.kh.team2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
}
