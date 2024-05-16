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
import kr.kh.team2.model.vo.common.RecommendVO;
import kr.kh.team2.model.vo.common.ReportVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.model.vo.member.MentoringApplyVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.CriteriaMentor;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.MentorService;
import kr.kh.team2.service.RecommendService;
import kr.kh.team2.service.ReportService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MentorController {
	
	@Autowired
	MentorService mentorService;
	
	@Autowired
	RecommendService recommendService;
	@Autowired
	ReportService reportService;
	
	@GetMapping("/mentor/list")
	public String mentorList(Model model) {
		
		ArrayList<MentorJobVO> jobList = mentorService.getJobList();
		model.addAttribute("jobList",jobList);
		model.addAttribute("title", "멘토");
		
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
	public Map<String, Object> mentorDetailPost(@RequestParam("ment_num")int ment_num, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		//멘토링 정보 받아오기
		MetoringVO mentoring = mentorService.getMentoring(ment_num);
		//멘토 정보 받아오기
		MentorInfoVO mentorInfo = mentorService.getMentor(mentoring.getMent_me_id());
		//멘토링 신고 여부 불러오기

		boolean istrue = true;
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			istrue = reportService.getReportIsTrue(Integer.toString(ment_num), "mentoring", user.getMe_id());
		}


		//멘토링 신청 정보 받아오기
		MentoringApplyVO mentoringAp = mentorService.getMentoringApply(ment_num, user);
		System.out.println(mentoringAp);

		
		// 좋아요수 
		Integer mentNum = ment_num;
		RecommendVO reco_ment_count = recommendService.getRecoMentoringCount(mentNum);
    
		map.put("istrue",istrue);
		map.put("mentoring",mentoring);
		map.put("mentor", mentorInfo);
		map.put("reco_ment_count", reco_ment_count);
		map.put("mentoringAp", mentoringAp);
		
		return map;
	}
	
	@ResponseBody
	@GetMapping("/mentoring/apply")
	public Map<String, Object> mentorApply(@RequestParam("ment_num")int ment_num) {
		Map<String, Object> map = new HashMap<String, Object>();
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
	
	@GetMapping("/mentoring/apply/detail")
	public String mentoringApplyDetail(Model model, HttpSession session, int num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//멘토링 정보 받아오기
		MetoringVO mentoring = mentorService.getMentoring(num);
		if(mentoring == null) {
			return "redirect:/";
		}
		
		// 멘토링 지원 정보 받아오기
		// 멘토링 지원 정보 받을 때 - 멘토링지원 멘토링 번호(mentAp_ment_num) = num 인 것과 멘토링 지원자 아이디 : user.getMe_id();
		// 멘토링 지원 정보 받을 때 - 멘토링지원 번호(mentAp_num) = num 인 것과 멘토링 지원자 아이디 : user.getMe_id();
		MentoringApplyVO mentoringAp = mentorService.getMentoringApply(num, user);
		
		model.addAttribute("mentoring", mentoring);
		model.addAttribute("mentoringAp", mentoringAp);
		
		return "/mentor/mentoringapplydetail";
	}
	
	@GetMapping("/mentor/apply")
	public String mentorApply() {
		
		return "/mentor/mentorapply";
	}
	
	
	@GetMapping("/mentor/check")
	@ResponseBody
	public String mentorCheck(HttpSession session) {

		MemberVO user = (MemberVO)session.getAttribute("user");
		MentorInfoVO mentorInfo = mentorService.checkMentor(user.getMe_id());
		if(mentorInfo == null) {
			return "true";
		}
		if(mentorInfo.getMentIf_state()==0 || mentorInfo.getMentIf_state() ==1) {
			return "duplicate";
		}
		if(mentorInfo.getMentIf_state()==-1) {
			return "denied";
		}
		if(user.getMe_temppw()==1) {
			return "needchange";
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
		
		MentorInfoVO mentorInfo = mentorService.getMentorInfo(user.getMe_id());
		
		if(mentorInfo==null) {
			ArrayList<MentorJobVO> jobList = mentorService.getJobList();
			model.addAttribute("jobList",jobList);
		
			return "/mentor/mentorinsert";
			
		}
		
		if(mentorInfo.getMentIf_state()==0 || mentorInfo.getMentIf_state() == 1) {
			model.addAttribute("msg","이미 멘토 신청을 완료한 계정입니다.");
			model.addAttribute("url","/");
			
		}
		else if(mentorInfo.getMentIf_state()==-1) {
				model.addAttribute("msg","멘토 신청 거절 이력이 있습니다.");
				model.addAttribute("url","/mentor/insert");
				model.addAttribute("confirm", true);
				model.addAttribute("confirmMsg","멘토신청을 다시 하시겠습니까?");
				model.addAttribute("confirmUrl","/mentor/update");
			}
		
		return "message";
	}

	
	@PostMapping("/mentor/insert")
	public String mentorInsertPost(Model model, HttpSession session, MentorInfoVO mentorInfoVO) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		MentorInfoVO dbMentor = mentorService.getMentorInfo(user.getMe_id());
		
		boolean res = false;
		
		if(dbMentor == null) {
			res = mentorService.insertMentorInfo(mentorInfoVO);
		}else {
			res = false;
		}
		if(res) {
			model.addAttribute("msg","멘토 신청을 완료하였습니다.");
			model.addAttribute("url","/mentor/complete");
		}else {
			model.addAttribute("msg","멘토 신청을 완료하지 못했습니다.");
			model.addAttribute("url","/");
		}
		return "message";
	}
	
	@GetMapping("/mentor/update")
	public String mentorUpdate(HttpSession session, Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		MentorInfoVO dbMentor = mentorService.getMentorInfo(user.getMe_id());
		if(!user.getMe_id().equals(dbMentor.getMentIf_me_id())) {
		
			return "message";
		}
		ArrayList<MentorJobVO> jobList = mentorService.getJobList();
		model.addAttribute("dbMentor",dbMentor);
		model.addAttribute("jobList",jobList);
		
		
		return "/mentor/mentorupdate";
	}
	
	@PostMapping("/mentor/update")
	public String mentorUpdatePost(HttpSession session, Model model,MentorInfoVO mentorInfoVO) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String me_id = user.getMe_id();
		MentorInfoVO dbMentor = mentorService.getMentorInfo(me_id);
		
		if(!user.getMe_id().equals(dbMentor.getMentIf_me_id())) {
			model.addAttribute("msg","권한 외 접근입니다.");
			model.addAttribute("url","/");
			return "message";
		}
		
		boolean res = mentorService.updateMentorInfoForDenied(mentorInfoVO,me_id);
		
		if(res) {
			model.addAttribute("msg","멘토 신청을 완료하였습니다.");
			model.addAttribute("url","/mentor/complete");
		}else {
			model.addAttribute("msg","멘토 신청을 완료하지 못했습니다.");
			model.addAttribute("url","/");
		}
		return "message";
		
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
	
	@GetMapping("/mentor/mentoring/update")
	public String mentoringUpdate(Model model, Integer mentNum,  HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");
		MentorInfoVO mentIf = mentorService.getMentorInfo(user.getMe_id());
		ArrayList<ProgrammingCategoryVO> progCt = mentorService.getProgrammingCategory();
		
		MetoringVO mentoring = mentorService.getMentoring(mentNum);
		
		
		model.addAttribute("progCtList",progCt);
		model.addAttribute("mentIf",mentIf);
		model.addAttribute("mentoring",mentoring);
		
		
		return "/mentor/mentoringupdate";
	}
	
	@PostMapping("/mentor/mentoring/update")
	public String mentoringUpdatetPost(Model model, HttpSession session, MetoringVO mentoring, TotalCategoryVO toCt) {
		
		toCt.setToCt_table_name("mentoring");
		System.out.println(mentoring);
		boolean res = mentorService.updateMentoring(mentoring,toCt);
		
		if(res) {
			model.addAttribute("msg","멘토링 글을 수정했습니다.");
			model.addAttribute("url","/mentor/list");
			return "message";
		}
		
		
		model.addAttribute("msg","멘토링 글을 수정하지 못했습니다.");
		model.addAttribute("url","");
		return "message";
	}
	
	@GetMapping("/mentor/mentoring/delete")
	public String mentoringDelete(Model model, Integer mentNum,  HttpSession session) {
		
		
		boolean res = mentorService.deleteMentoring(mentNum);
		
		if(res) {
			model.addAttribute("msg","멘토링 글을 삭제했습니다.");
			model.addAttribute("url","/mentor/list");
			return "message";
		}
		
		
		model.addAttribute("msg","멘토링 글을 삭제하지 못했습니다.");
		model.addAttribute("url","/mentor/list");
		return "message";
	}

}