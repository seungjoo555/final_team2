package kr.kh.team2.controller;

import java.util.ArrayList;
import java.util.Date;
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

import kr.kh.team2.model.vo.common.ReportContentVO;
import kr.kh.team2.model.vo.common.ReportVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.service.MentorService;
import kr.kh.team2.service.ReportService;

@Controller
public class ReportController {
	
	@Autowired
	ReportService reportService;
	@Autowired
	MentorService mentorService;
	
	
	/** 멘토 */
	@ResponseBody
	@GetMapping("/report/mentor")
	public Map<String, Object> reportMentor(@RequestParam("ment_num")int ment_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		//멘토링 정보 받아오기
		MetoringVO mentoring = mentorService.getMentoring(ment_num);
		//신고 유형 정보 가져오기
		ArrayList<ReportContentVO> contentList = reportService.getReportContentList();
		map.put("mentoring",mentoring);
		map.put("contentList",contentList);
		
		return map;
	}
	
	/* 비동기 신고(그룹 모집글 활용 예시 참고) */
	@ResponseBody
	@PostMapping("/report")
	public Map<String, Object> reportPost(HttpSession session,@RequestBody ReportVO reportVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		//로그인 정보 가져오기
		MemberVO user = (MemberVO)session.getAttribute("user");
		//신고하기
		boolean res = reportService.insertReport(reportVO, user);
		//페이지 이동하기
		map.put("result", res);
		map.put("reportVO", reportVO);
		return map;
	}
	
}
