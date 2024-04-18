package kr.kh.team2.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.service.GroupService;

@Controller
public class GroupController {
	
	@Autowired
	GroupService groupService;
	
	@GetMapping("/group/mylist")
	public String grouplist(Model model, HttpSession session){
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		ArrayList<GroupVO> list = groupService.getGroupListById(user.getMe_id());
		
		if(list.size() > 0) {
			model.addAttribute("list", list);
		}
		
		return "/group/mygrouplist";
	}
	
	@GetMapping("/group/home")
	public String grouphome(Model model, HttpSession session, int groupNum){

		
		return "/group/grouphome";
	}

	
}
