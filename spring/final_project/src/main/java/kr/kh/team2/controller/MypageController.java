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
		
		// 그룹 리스트 가져오기
		ArrayList<MutualReviewVO> mutualReviewList = reviewService.getMutualReviewList(me_id);
		model.addAttribute("mutualReviewList", mutualReviewList);
		System.out.println(mutualReviewList);
		
		// 스터디 리스트 가져오기
		ArrayList<GroupVO> groupList = groupService.getStudyGroupList(me_id);
		model.addAttribute("groupList", groupList);
		System.out.println(groupList);
		
		// 모집 공고에 등록된 분야 가져오기
		String table = "recruit";
		//ArrayList<TotalCategoryVO> totalCategory = groupService.getCategory(num, table);
		//ArrayList<TotalLanguageVO> totalLanguage = groupService.getLanguage(num, table);
		
		//model.addAttribute("totalCategory", totalCategory);
		//model.addAttribute("totalLanguage", totalLanguage);
		//System.out.println(num);
		//System.out.println(totalCategory);
		//System.out.println(totalLanguage);
		
		// 멘토링 가져오기
		ArrayList<MetoringVO> mentoringList = mentorService.getMentoringList(me_id);
		model.addAttribute("mentoringList", mentoringList);
		System.out.println(mentoringList);
		
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
