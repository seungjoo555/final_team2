package kr.kh.team2.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.service.RecruitService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class RecruitController {
	@Autowired
	RecruitService recruitService;
	
	@GetMapping("/group/home")
	public String GroupHome(Model model) {
		
		return "/group/home";
	}
	
	@GetMapping("/recruit/insert") 
	public String RecruitInsert(Model model) {
		model.addAttribute("title","스터디·프로젝트 모집");
		return "/recruit/insert";
	}
	
	@PostMapping("/recruit/insert")
	public String RecruitInsertPost(Model model, GroupVO group ,RecruitVO recruit, HttpSession session) {
		// MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO user = new MemberVO();
		user.setMe_id("abc");
		
		boolean res = recruitService.insertRecruit(group, recruit, user);
		
		if(res) {
			model.addAttribute("msg", "게시글을 등록했습니다.");
			model.addAttribute("url", "/group/home"); 
		} else {
			// System.out.println("컨트롤러유저 : " + user);
			System.out.println("컨트롤러그룹 : " + group);
			System.out.println("컨트롤러리크루잇 : " + recruit);
			// log.info(user);
			log.info(group);
			log.info(recruit);
			model.addAttribute("msg", "게시글을 등록하지 못했습니다.");
			model.addAttribute("url", "/recruit/insert");
		}
		
		return "message";
	}
}
