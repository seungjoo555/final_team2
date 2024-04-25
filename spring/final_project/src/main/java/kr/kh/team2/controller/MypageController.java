package kr.kh.team2.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
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
		System.out.println(member);
		model.addAttribute("member", member);
		return "/mypage/profile";
	}
	
	@GetMapping("mypage/mygroup")
	public String groupListPost(Model model, String me_id) {
		// 멤버 가져오기
		MemberVO member = memberService.getMember(me_id);
		System.out.println(member);
		model.addAttribute("member", member);
		
		// 상호평가 리스트 가져오기
		ArrayList<MutualReviewVO> mutualReviewList = reviewService.getMutualReviewList(me_id);
		model.addAttribute("mutualReviewList", mutualReviewList);
		System.out.println(mutualReviewList);
		
		// 내가 만든 스터디 리스트 가져오기
		ArrayList<GroupVO> groupList = groupService.getStudyGroupList(me_id);
		model.addAttribute("groupList", groupList);
		System.out.println(groupList);
		
		// groupList에서 recu_num 가져오기
		// 모집 공고에 등록된 분야 가져오기
		String table1 = "recruit";
		
		for(GroupVO group : groupList) {
			int recu_num = group.getRecu_num();
			System.out.println("recu_num : " + recu_num);
			
			ArrayList<TotalCategoryVO> totalCategory = groupService.getCategory(recu_num, table1);
			ArrayList<TotalLanguageVO> totalLanguage = groupService.getLanguage(recu_num, table1);
			model.addAttribute("totalCategory", totalCategory);
			model.addAttribute("totalLanguage", totalLanguage);
		}
		
		// 내가 지원한 스터디 리스트 가져오기
		ArrayList<GroupVO> groupApplyList = groupService.getStudyApplyList(me_id);
		model.addAttribute("groupApplyList", groupApplyList);
		System.out.println(groupApplyList);
		
		// groupList에서 recu_num 가져오기
		// 모집 공고에 등록된 분야 가져오기
		// 내가 지원한 스터디 모집 공고 올린 그룹장 가져오기
		for(GroupVO group : groupApplyList) {
			int recu_num = group.getRecu_num();
			System.out.println("recu_num : " + recu_num);
			
			MemberVO groupKing = groupService.getGroupKing(recu_num);
			model.addAttribute("groupKing", groupKing.getMe_nickname());
			
			ArrayList<TotalCategoryVO> totalCategory = groupService.getCategory(recu_num, table1);
			ArrayList<TotalLanguageVO> totalLanguage = groupService.getLanguage(recu_num, table1);
			model.addAttribute("totalCategory", totalCategory);
			model.addAttribute("totalLanguage", totalLanguage);
		}
		
		
		// 멘토링 가져오기
		ArrayList<MetoringVO> mentoringList = mentorService.getMentoringList(me_id);
		model.addAttribute("mentoringList", mentoringList);
		System.out.println(mentoringList);
		
		// mentoringList에서 ment_num 가져오기
		// 멘토링 공고에 등록된 분야 가져오기
		
		String table2 = "mentoring";
		
		for (MetoringVO mentoring : mentoringList) {
		    int ment_num = mentoring.getMent_num();
		    System.out.println("ment_num: " + ment_num);
		    
		    ArrayList<TotalCategoryVO> mentoCategory = mentorService.getMentoCategory(ment_num, table2);
		    model.addAttribute("mentoCategory", mentoCategory);
		}
		
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

	
}
