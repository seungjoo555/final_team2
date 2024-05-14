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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team2.model.dto.MentorInfoDTO;
import kr.kh.team2.model.vo.community.BoardVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.CommunityService;
import kr.kh.team2.service.MentorService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class AdminController {
	
	@Autowired
	MentorService mentorService;
	
	@Autowired
	CommunityService communityService;
	
	@ResponseBody
	@PostMapping("/admin/managementor/list")
	public Map<String, Object> mentorInfoListPost(@RequestBody Criteria cri){
		Map<String,Object> map = new HashMap<String,Object>();
		cri.setPerPageNum(10);
		ArrayList<MentorInfoVO> mentorInfoList = mentorService.getMentorInfoList(cri);
		int totalCount = mentorService.getMentorInfoTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("mentorInfoList", mentorInfoList);
		map.put("pm", pm);
		
		
		return map;
		
		
	}
	
	
	@GetMapping("/admin/managementor")
	public String manageMentor(Model model) {
		ArrayList<MentorJobVO> mentorJobList = mentorService.getJobList();
		model.addAttribute("mentorJobList",mentorJobList);
		return "/admin/managementor";
	}
	
	@ResponseBody
	@PostMapping("/admin/managementor/multirequest")
	public Map<String, Object> multiRequestPost(@RequestBody MentorInfoDTO mentorInfoDTO){
		Map<String,Object> map = new HashMap<String,Object>();
		
		boolean res = mentorService.mentorMultiRequest(mentorInfoDTO);
		
		if(res) {
			map.put("res","true");
		}else {
			map.put("res", "false");
		}
		return map;
	}
	
	@ResponseBody
	@GetMapping("/admin/managementor/detail")
	public Map<String, Object> mentorInfoDetail(@RequestParam String mentIf_me_id){
		Map<String,Object> map = new HashMap<String,Object>();
		
		MentorInfoVO mentorInfo = mentorService.getMentorInfo(mentIf_me_id);
		
		map.put("mentorInfo", mentorInfo);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/admin/managementor/request")
	public Map<String, Object> mentorRequestPost(@RequestParam String mentIf_me_id,
					@RequestParam String btnType){
		Map<String,Object> map = new HashMap<String,Object>();
		
		boolean res = mentorService.mentorRequest(mentIf_me_id,btnType);
		
		if(res) {
			map.put("res", "true");
		}else {
			map.put("res", "false");
		}
		return map;
	}
	
	@GetMapping("/admin/managecommunity")
	public String manageCommunity() {
		
		return "/admin/managecommunity";
	}
	
	
	@ResponseBody
	@PostMapping("/admin/managecommunity/list")
	public Map<String, Object> displayboardList(@RequestBody Criteria cri) {
		Map<String,Object> map = new HashMap<String,Object>();
		cri.setPerPageNum(10);
		
		ArrayList<BoardVO> boardList = communityService.getBoardList(cri);
		int totalCount = communityService.getBoardTotalCount();
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("boardList", boardList);
		map.put("pm", pm);
		
		return map;
		
	}
	
	@ResponseBody
	@PostMapping("/admin/managecommunity/insert")
	public String insertBoard(@RequestParam String board_name) {
		
		int res = communityService.insertBoard(board_name);

		return res +"";
	}
	
	@ResponseBody
	@PostMapping("/admin/managecommunity/update")
	public String updateBoard(@RequestParam int board_num, @RequestParam String board_name) {

		int res = communityService.updateBoard(board_num,board_name);
		return res +"";
	}
	
	@ResponseBody
	@PostMapping("/admin/managecommunity/delete")
	public String deleteBoard(@RequestParam int board_num) {
		
		boolean res = communityService.deleteBoard(board_num);
		
		
		return res + "";
	}
	

}
