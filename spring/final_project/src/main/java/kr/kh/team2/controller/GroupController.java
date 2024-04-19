package kr.kh.team2.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupPostVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.service.GroupService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class GroupController {
	
	@Autowired
	GroupService groupService;
	
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
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(groupService.isGroupMember(user, groupNum)) {
			GroupVO group = groupService.getGroupByGoNum(groupNum);
			model.addAttribute("group", group);
		}
		
		ArrayList<GroupPostVO> boardlist = groupService.getRecentGroupBoard(groupNum, recentBoard);
		
		model.addAttribute("boardlist", boardlist);
		
		return "/group/mygroup/grouphome";
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
