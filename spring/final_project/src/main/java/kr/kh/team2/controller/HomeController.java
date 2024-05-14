package kr.kh.team2.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupVO;
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
		
		//추천순 리스트 
		ArrayList<RecruitVO> hotGroupList = groupService.getGroupList(cri);
		//추천순 멘토링 리스트
		ArrayList<MetoringVO> mentoingList = mentorService.getMentorList(criM);
		//추천순 강의 리스트
		ArrayList<LectureVO> lectureList = lectureService.getAllLectureList(cri);
		
		//모임 - 모집분야, 사용언어
		String table1 = "recruit";
		ArrayList<TotalCategoryVO> totalCategory = new ArrayList<TotalCategoryVO>();
		ArrayList<TotalLanguageVO> totalLanguage = new ArrayList<TotalLanguageVO>();
		
		for(RecruitVO group : hotGroupList) {
			int recu_num = group.getRecu_num();
			System.out.println("recu_num : " + recu_num);
			
			ArrayList<TotalCategoryVO> Category = groupService.getCategory(recu_num, table1);
			ArrayList<TotalLanguageVO> Language = groupService.getLanguage(recu_num, table1);
			
			totalCategory.addAll(Category);
			totalLanguage.addAll(Language);			
		}
		model.addAttribute("totalCategory", totalCategory);
		model.addAttribute("totalLanguage", totalLanguage);
		model.addAttribute("hotGroupList", hotGroupList );
		model.addAttribute("mentoingList", mentoingList );
		model.addAttribute("lectureList", lectureList );
		
		return "/main/home";
	}
	
}
