package kr.kh.team2.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupApplyVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.MutualReviewVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.service.GroupService;
import kr.kh.team2.service.MemberService;
import kr.kh.team2.service.MentorService;
import kr.kh.team2.service.RecruitService;
import kr.kh.team2.service.ReviewService;

@Controller
public class MypageController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	RecruitService recruitService;
	
	@Autowired
	GroupService groupService;
	
	@Autowired
	MentorService mentorService;
	
	@GetMapping("/mypage/profile")
	public String mypageProfile(Model model, String me_id) {
		MemberVO member = memberService.getMember(me_id);
		model.addAttribute("member", member);
		return "/mypage/profile";
	}
	
	@GetMapping("mypage/mygroup")
	public String groupListPost(Model model, String me_id) {
		// 멤버 가져오기
		MemberVO member = memberService.getMember(me_id);
		model.addAttribute("member", member);
		
		// 상호평가 리스트 가져오기
		ArrayList<MutualReviewVO> mutualReviewList = reviewService.getMutualReviewList(me_id);
		model.addAttribute("mutualReviewList", mutualReviewList);
		
		// 내가 만든 스터디 리스트 가져오기
		ArrayList<GroupVO> groupList = groupService.getStudyGroupList(me_id);
		model.addAttribute("groupList", groupList);
		
		// groupList에서 recu_num 가져오기
		// 모집 공고에 등록된 분야 가져오기
		String table1 = "recruit";
		
		ArrayList<TotalCategoryVO> totalCategory1 = new ArrayList<TotalCategoryVO>();
		ArrayList<TotalLanguageVO> totalLanguage1 = new ArrayList<TotalLanguageVO>();
		
		for(GroupVO group : groupList) {
			int recu_num = group.getRecu_num();
			
			ArrayList<TotalCategoryVO> Category = groupService.getCategory(recu_num, table1);
			ArrayList<TotalLanguageVO> Language = groupService.getLanguage(recu_num, table1);
			
			totalCategory1.addAll(Category);
			totalLanguage1.addAll(Language);			
		}
		model.addAttribute("totalCategory1", totalCategory1);
		model.addAttribute("totalLanguage1", totalLanguage1);
		
		// 내가 지원한 스터디 리스트 가져오기
		ArrayList<GroupVO> groupApplyList = groupService.getStudyApplyList(me_id);
		model.addAttribute("groupApplyList", groupApplyList);
		
		// groupList에서 recu_num 가져오기
		// 모집 공고에 등록된 분야 가져오기
		// 내가 지원한 스터디 모집 공고 올린 그룹장 가져오기
		ArrayList<TotalCategoryVO> totalCategory2 = new ArrayList<TotalCategoryVO>();
		ArrayList<TotalLanguageVO> totalLanguage2 = new ArrayList<TotalLanguageVO>();
		for(GroupVO group : groupApplyList) {
			int recu_num = group.getRecu_num();
			
			MemberVO groupKing = groupService.getGroupKing(recu_num);
			model.addAttribute("groupKing", groupKing.getMe_nickname());
			
			ArrayList<TotalCategoryVO> Category = groupService.getCategory(recu_num, table1);
			ArrayList<TotalLanguageVO> Language = groupService.getLanguage(recu_num, table1);

			totalCategory2.addAll(Category);
			totalLanguage2.addAll(Language);			
		}
		model.addAttribute("totalCategory2", totalCategory2);
		model.addAttribute("totalLanguage2", totalLanguage2);
		
		// 그룹 회원 수 count
		ArrayList<GroupVO> memberCount = groupService.countGroupListById(me_id);
		model.addAttribute("memberCount", memberCount);
		
		
		// 멘토링 가져오기
		ArrayList<MetoringVO> mentoringList = mentorService.getMentoringList(me_id);
		model.addAttribute("mentoringList", mentoringList);
		
		// mentoringList에서 ment_num 가져오기
		// 멘토링 공고에 등록된 분야 가져오기
		
		String table2 = "mentoring";
		ArrayList<TotalCategoryVO> mentoCategory = new ArrayList<TotalCategoryVO>();
		
		for (MetoringVO mentoring : mentoringList) {
		    int ment_num = mentoring.getMent_num();
		    
		    ArrayList<TotalCategoryVO> Category = mentorService.getMentoCategory(ment_num, table2);
		    mentoCategory.addAll(Category);
		}
		model.addAttribute("mentoCategory", mentoCategory);
		
		return "/mypage/mygroup";
	}
	
	@PostMapping("/profile/update")
	public String profileUpdate(Model model, MemberVO memberVo, String me_id) {
		
		MemberVO member = memberService.getMember(me_id);
		model.addAttribute("member", member);
		boolean res = memberService.updateProfile(member.getMe_id(), memberVo);
		
		if(res) {
			model.addAttribute("msg", "프로필을 수정했습니다.");
			model.addAttribute("url", "/mypage/profile?me_id="+me_id); 
		} else {
			model.addAttribute("msg", "프로필을 수정하지 못했습니다.");
			model.addAttribute("url", "/mypage/profile?me_id="+me_id); 
		}
		return "message";
	}

	@ResponseBody
	@GetMapping("/applyList/detail")
	public Map<String, Object> applyListDetail(@RequestParam("recu_num")int recu_num) {
	Map<String, Object> map = new HashMap<String, Object>();
		// 공고 정보 받아오기
		RecruitVO recruit = recruitService.getRecruit(recu_num);
		System.out.println(recruit);
		System.out.println("마페컨트롤러 레큐넘 : " + recruit.getRecu_num());
		// 공고 번호에 맞는 지원자 정보 받아오기
		ArrayList<GroupApplyVO> groupApply = groupService.getGroupApply(recruit.getRecu_num());
		System.out.println(groupApply);
		
		map.put("recruit", recruit);
        map.put("groupApply", groupApply);
		
		return map;
	}
}
