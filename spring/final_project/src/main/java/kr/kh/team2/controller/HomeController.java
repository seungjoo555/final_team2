package kr.kh.team2.controller;

import java.util.ArrayList;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.CriteriaMentor;
import kr.kh.team2.service.GroupService;
import kr.kh.team2.service.LectureService;
import kr.kh.team2.service.MentorService;

@Controller
public class HomeController {
	
	@Autowired
	GroupService groupService;
	@Autowired
	MentorService mentorService;
	@Autowired
	LectureService lectureService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Criteria cri = new Criteria(1, 4);
		CriteriaMentor criM = new CriteriaMentor(1, 4);
		
		//추천순 그룹모집공고 리스트 
		ArrayList<RecruitVO> hotGroupList = groupService.getHotGroupList();
		
		//추천순 멘토링 리스트
		ArrayList<MetoringVO> hotMentoingList = mentorService.getHotMentorList();
		//추천순 강의 리스트
		ArrayList<LectureVO> hotLectureList = lectureService.getHotLectureList();
		
		//모임 - 모집분야, 사용언어
		String table1 = "recruit";
		ArrayList<TotalCategoryVO> totalCategory = new ArrayList<TotalCategoryVO>();
		ArrayList<TotalLanguageVO> totalLanguage = new ArrayList<TotalLanguageVO>();
		
		if(hotGroupList != null) {
			for(RecruitVO group : hotGroupList) {
				int recu_num = group.getRecu_num();
				
				ArrayList<TotalCategoryVO> Category = groupService.getCategory(recu_num, table1);
				ArrayList<TotalLanguageVO> Language = groupService.getLanguage(recu_num, table1);
				
				if(Category != null) {
					totalCategory.addAll(Category);
				}
				if(Language != null) {
					totalLanguage.addAll(Language);			
				}
				
			}
		}
	
		model.addAttribute("totalCategory", totalCategory);
		model.addAttribute("totalLanguage", totalLanguage);
		model.addAttribute("hotGroupList", hotGroupList );
		model.addAttribute("hotMentoingList", hotMentoingList );
		model.addAttribute("hotLectureList", hotLectureList );
		return "/main/home";
	}
	
}
