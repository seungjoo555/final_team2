package kr.kh.team2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RecruitController {
	@GetMapping("group/home")
	public String GroupHome(Model model) {
		
		return "/recruit/insert";
	}
}
