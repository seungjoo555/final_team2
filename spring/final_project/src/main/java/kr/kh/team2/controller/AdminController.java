package kr.kh.team2.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.MentorService;

@Controller
public class AdminController {
	
	@Autowired
	MentorService mentorService;
	
	@ResponseBody
	@PostMapping("/admin/managementor/list")
	public Map<String, Object> mentorInfoListPost(@RequestBody Criteria cri){
		Map<String,Object> map = new HashMap<String,Object>();
		ArrayList<MentorInfoVO> mentorInfoList = mentorService.getMentorInfoList(cri);
		int totalCount = mentorService.getMentorInfoTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("mentorInfoList", mentorInfoList);
		map.put("pm", pm);
		
		return map;
		
		
	}
	
	
	@GetMapping("/admin/managementor")
	public String manageMentor(Model model) {
		
		ArrayList<ProgrammingCategoryVO> progCt = mentorService.getProgrammingCategory();
		model.addAttribute("progCtList",progCt);
		return "/admin/managementor";
	}
	

}
