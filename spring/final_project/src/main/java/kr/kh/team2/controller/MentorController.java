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

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.model.vo.member.MentoringApplyVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.CriteriaMentor;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.MentorService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MentorController {
	
	@Autowired
	MentorService mentorService;
	
	@GetMapping("/mentor/list")
	public String mentorList(Model model) {
		
		ArrayList<MentorJobVO> jobList = mentorService.getJobList();
		model.addAttribute("jobList",jobList);
		
		return "/mentor/list";
	}
	
	@ResponseBody
	@PostMapping("/mentor/list")
	public Map<String, Object> mentorListPost(@RequestBody CriteriaMentor cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		cri.setPerPageNum(20);	//default : 20
		//그룹 리스트 가져오기
		ArrayList<MetoringVO> mentoList = mentorService.getMentorList(cri);
		int totalCount = mentorService.getMentorTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);	//default : 10
		ArrayList<MentorJobVO> JobList = mentorService.getJobList();
		map.put("jobList",JobList);
		map.put("list", mentoList);
		map.put("pm", pm);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/mentor/detail")
	public Map<String, Object> mentorDetailPost(@RequestParam("ment_num")int ment_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		//멘토링 정보 받아오기
		MetoringVO mentoring = mentorService.getMentoring(ment_num);
		//멘토 정보 받아오기
		MentorInfoVO mentorInfo = mentorService.getMentor(mentoring.getMent_me_id());
		
		map.put("mentoring",mentoring);
		map.put("mentor", mentorInfo);
		
		return map;
	}
	
	@ResponseBody
	@GetMapping("/mentoring/apply")
	public Map<String, Object> mentorApply(@RequestParam("ment_num")int ment_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("ment_num :: "+ment_num);
		MetoringVO mentoring = mentorService.getMentoring(ment_num);
		map.put("mentoring",mentoring);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/mentoring/apply")
	public Map<String, Object> mentorApplyPost(HttpSession session,@RequestBody MentoringApplyVO mentoApVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		//로그인 정보 가져오기
		MemberVO user = (MemberVO)session.getAttribute("user");
		//신청하기
		boolean res = mentorService.insertMentoringApply(mentoApVO, user);
		//페이지 이동하기
		map.put("result", res);
		return map;
	}
	
	@GetMapping("/mentor/apply")
	public String mentorApply() {
		
		return "/mentor/mentorapply";
	}
	
	
	@GetMapping("/mentor/check")
	@ResponseBody
	public String mentorCheck(HttpSession session) {

		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = mentorService.checkMentor(user.getMe_id());
		if(res) {
			return "true";
		}

		return "false";
	}
	
	@GetMapping("/mentor/insert")
	public String mentorInsert(Model model, HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user.getMe_ma_auth().equals("멘토")) {
			model.addAttribute("msg","이미 멘토 신청을 완료한 계정입니다.");
			model.addAttribute("url","/mentor/apply");
			return "message";
		}
		
		if(mentorService.getMentorInfo(user.getMe_id())!=null) {
			model.addAttribute("msg","이미 멘토 신청을 완료한 계정입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		
		ArrayList<MentorJobVO> jobList = mentorService.getJobList();
		model.addAttribute("jobList",jobList);
	
		return "/mentor/mentorinsert";
	}
	
	@PostMapping("/mentor/insert")
	public String mentorInsertPost(MentorInfoVO mentorInfoVO) {
		
		boolean res = mentorService.insertMentorInfo(mentorInfoVO);
		
		if(res) {
			return "/mentor/mentorcom";
		}
		return "";
	}
	
	@GetMapping("/mentor/complete")
	public String mentorComplete() {
		
		return "/mentor/mentorcom";
	}
	
	@GetMapping("/mentor/mentoring/insert")
	public String mentoringInsert(Model model, HttpSession session) {
		
		MemberVO user = (MemberVO) session.getAttribute("user");
		String me_id = user.getMe_id();
		
		if(!user.getMe_ma_auth().equals("멘토")) {
			model.addAttribute("msg","멘토링 클래스는 오직 멘토만 등록할 수 있습니다.");
			model.addAttribute("url","/mentor/apply");
			return "message";
		}
		
		if(mentorService.getMetoring(me_id)!=null) {
			model.addAttribute("msg","이미 멘토링 클래스 개설을 완료한 계정입니다.");
			model.addAttribute("url","/mentor/list");
			return "message";
		}
		
		
		MentorInfoVO mentIf = mentorService.getMentorInfo(me_id);
		ArrayList<ProgrammingCategoryVO> progCt = mentorService.getProgrammingCategory();
		System.out.println(progCt);
		
		model.addAttribute("progCtList",progCt);
		model.addAttribute("mentIf",mentIf);
		
		
		return "/mentor/mentoringinsert";
	}
	
	@PostMapping("/mentor/mentoring/insert")
	public String mentoringInsertPost(Model model, HttpSession session, MetoringVO mentoring, TotalCategoryVO toCt) {
		
		MemberVO user = (MemberVO) session.getAttribute("user");
		mentoring.setMent_me_id(user.getMe_id());
		toCt.setToCt_table_name("mentoring");
		
		boolean res = mentorService.insertMentoring(mentoring,toCt);
	
		
		if(res) {
			return "/mentor/list";
		}
		
		
		return "";
	}

}
