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
		
		
		System.out.println(hotGroupList);
		System.out.println(mentoingList);
		System.out.println(lectureList);
		
		model.addAttribute("hotGroupList", hotGroupList );
		model.addAttribute("mentoingList", mentoingList );
		model.addAttribute("lectureList", lectureList );
		
		return "/main/home";
	}
	
}
