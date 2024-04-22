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

import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupCalendarVO;
import kr.kh.team2.model.vo.group.GroupPostVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.GroupService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class GroupController {
	
	@Autowired
	GroupService groupService;
	
	// ================================ mygroup ================================

	@GetMapping("/mygroup/list")
	public String grouplist(Model model, HttpSession session){
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		ArrayList<GroupVO> list = groupService.getGroupListById(user.getMe_id());
		
		if(list.size() > 0) {
			model.addAttribute("list", list);
		}
		
		return "/group/mygroup/list";
	}
	
	@GetMapping("/group/home")
	public String grouphome(Model model, HttpSession session, int groupNum){
		int recentBoard = 6;
		int dday = 7;
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(groupService.isGroupMember(user, groupNum)) {
			GroupVO group = groupService.getGroupByGoNum(groupNum);
			model.addAttribute("group", group);
			
			long groupTime = groupService.getGroupTime(groupNum);
			model.addAttribute("time", groupTime);
		}
		
		// 최근 게시글 불러오기
		ArrayList<GroupPostVO> boardlist = groupService.getRecentGroupBoard(groupNum, recentBoard);
		// d-day 불러오기
		ArrayList<GroupCalendarVO> ddaylist = groupService.getDday(groupNum, dday);
		
		// 가장 마지막 일정을 dday 최상단에 표시되도록 하기(의미가 있나? 그룹 시작일로 하는게 낫지 않을지,)
		/*
		if(ddaylist.size() != 0 || ddaylist != null) {
			
		}
		*/
		
		model.addAttribute("ddaylist", ddaylist);
		model.addAttribute("boardlist", boardlist);
		
		return "/group/mygroup/grouphome";
	}
	
	@ResponseBody
	@PostMapping("/group/timerWork")
	public Map<String, Object> 메서드명(@RequestParam("goNum")int goNum){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean isTimeupdated = groupService.updateGoTime(goNum);
		
		if(isTimeupdated) {
			long time = groupService.getGoTimeByGoNum(goNum);
			
			map.put("time", time);
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	// ================================ group ================================
		

	@GetMapping("/group/list")
	public String groupList(Model model) {

		return "/group/list";
	}
	
	@ResponseBody
	@PostMapping("/group/list")
	public Map<String, Object> groupListPost(@RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		cri.setPerPageNum(20);	//20개
		//그룹 리스트 가져오기
		ArrayList<RecruitVO> groupList = groupService.getGroupList(cri);
		System.out.println("cri : " + cri);
		int totalCount = groupService.getGroupTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("list", groupList);
		map.put("pm", pm);
		return map;
	}
	
	@GetMapping("/group/post")
	public String grouppost(Model model, HttpSession session, int groupNum){
		
		return "/group/mygroup/grouppost";
	}

  @GetMapping("/group/detail")
	public String postDetail(Model model, int num) {
		//모집공고를 가져옴
		RecruitVO recruit = groupService.getRecruit(num);
		if(recruit == null) {
			return "redirect:/";
		}
		//모집공고를 올린 그룹장 가져옴
		MemberVO groupKing = groupService.getGroupKing(recruit.getRecu_go_num());
		//모집 공고에 등록된 분야, 언어 가져옴
		String table = "recruit";
		ArrayList<TotalCategoryVO> totalCategory = groupService.getCategory(num, table);
		ArrayList<TotalLanguageVO> totalLanguage = groupService.getLanguage(num, table);
		//화면에 전송
		model.addAttribute("recruit", recruit);
		model.addAttribute("groupKing", groupKing.getMe_nickname());
		model.addAttribute("totalCategory", totalCategory);
		model.addAttribute("totalLanguage", totalLanguage);
		return "/group/detail";
	}
	
}
