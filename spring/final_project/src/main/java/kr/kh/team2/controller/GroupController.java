package kr.kh.team2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.team2.service.GroupService;

@Controller
public class GroupController {
	
	@Autowired
	GroupService groupService;
	
	@GetMapping("/group/list")
	public String signup(){
		
		return "/group/grouplist";
	}
	
}
