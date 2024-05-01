package kr.kh.team2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LectureController {

	@GetMapping("/lecture/list")
	public String postList(Model model) {
		model.addAttribute("title", "강의글 목록");
		return "/lecture/list";
	}
}
