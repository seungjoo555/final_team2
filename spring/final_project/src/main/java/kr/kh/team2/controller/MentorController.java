package kr.kh.team2.controller;

import java.util.ArrayList;
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

import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.service.MentorService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MentorController {
	
	@Autowired
	MentorService mentorService;
	
	@GetMapping("/mentor/apply")
	public String mentorApply() {
		
		return "/mentor/mentorapply";
	}
	
	@GetMapping("/mentor/check")
	@ResponseBody
	public String mentorCheck(HttpSession session) {
		try{
			MemberVO user = (MemberVO)session.getAttribute("user");
			boolean res = mentorService.checkMentor(user.getMe_id());
			if(res) {
				return "true";
			}
		}catch(NullPointerException e){
			return "null";
		}
		return "false";

	}
	
	@GetMapping("/mentor/insert")
	public String mentorInsert(Model model) {
		
		ArrayList<MentorJobVO> jobList = mentorService.getJobList();
		model.addAttribute("jobList",jobList);
	
		return "/mentor/mentorinsert";
	}
	
	@PostMapping("/mentor/insert")
	public String mentorInsertPost(MentorInfoVO mentorInfoVO) {
		
		boolean res = mentorService.insertMentorInfo(mentorInfoVO);
		
		if(res) {
			return "/mentor/mentorcom";
		}
		return "";
	}
	
	@GetMapping("/mentor/complete")
	public String mentorComplete() {
		
		return "/mentor/mentorcom";
	}

}
