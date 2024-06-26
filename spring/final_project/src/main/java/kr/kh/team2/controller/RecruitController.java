package kr.kh.team2.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
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
	
	@GetMapping("/group/grouplist")
	public String GroupHome(Model model) {
		return "/group/grouplist";
	}
	
	@GetMapping("/group/grouprecruit") 
	public String RecruitInsert(Model model) {
		model.addAttribute("title","스터디·프로젝트 모집");
		
		ArrayList<ProgrammingCategoryVO> categoryList = recruitService.getProgrammingCategoryList();
		ArrayList<ProgrammingLanguageVO> languageList = recruitService.getProgrammingLanguageList();
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("languageList", languageList);
		
		return "/group/grouprecruit";
	}
	
	@PostMapping("/group/grouprecruit")
	public String RecruitInsertPost(Model model, String progCtList, String progLangList, GroupVO group ,RecruitVO recruit, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		// 그룹 생성
		boolean res1 = recruitService.insertRecruit(group, recruit, user);
		// 모집 분야 insert
		boolean res2 = recruitService.insertTotalCate(progCtList, recruit.getRecu_num());
		// 사용 언어 insert
		boolean res3 = recruitService.insertTotalLang(progLangList, recruit.getRecu_num());
		
		
		if(res1 && res2 && res3) {
			model.addAttribute("msg", "모집공고를 등록했습니다.");
			model.addAttribute("url", "/group/list"); 
		} else {
			model.addAttribute("msg", "모집공고를 등록하지 못했습니다.");
			model.addAttribute("url", "/group/grouprecruit");
		}
		
		return "message";
	}
}
