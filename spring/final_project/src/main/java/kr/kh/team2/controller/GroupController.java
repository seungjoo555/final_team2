package kr.kh.team2.controller;

import java.util.ArrayList;
import java.util.Calendar;
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

import kr.kh.team2.model.dto.MutualReviewDTO;
import kr.kh.team2.model.vo.common.RecommendVO;
import kr.kh.team2.model.vo.common.ReportContentVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupApplyVO;
import kr.kh.team2.model.vo.group.GroupCalendarVO;
import kr.kh.team2.model.vo.group.GroupMemberVO;
import kr.kh.team2.model.vo.group.GroupPostVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.MutualReviewVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.GroupService;
import kr.kh.team2.service.RecommendService;
import kr.kh.team2.service.ReportService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class GroupController {
	
	@Autowired
	GroupService groupService;
	@Autowired
	ReportService reportService;
	@Autowired
	RecommendService recommendService;
	
	// ================================ mygroup ================================

	@GetMapping("/mygroup/list")
	public String grouplist(Model model){
		
		return "/group/mygroup/list";
	}
	
	@ResponseBody
	@PostMapping("/mygroup/list")
	public Map<String, Object> mygrouplistPost(HttpSession session, @RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		cri.setPerPageNum(5);
		
		//그룹 리스트 가져오기
		ArrayList<GroupVO> list = groupService.getGroupListById(user.getMe_id(), cri);
		
		int totalCount = groupService.getMyGroupTotalCount(user.getMe_id());
		PageMaker pm = new PageMaker(10, cri, totalCount);

		map.put("list", list);
		map.put("pm", pm);
		
		return map;
	}
	
	@GetMapping("/group/home")
	public String grouphome(Model model, HttpSession session, int num){
		int recentBoard = 6;
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<GroupCalendarVO> ddaylist = new ArrayList<GroupCalendarVO>();
		
		// 해당 그룹 가입 유저가 아니라면
		if(!groupService.isGroupMember(user, num)) {
			return "/group/mygroup/home";
		}
		
		GroupVO group = groupService.getGroupByGoNum(num);
		model.addAttribute("group", group);
		
		long groupTime = groupService.getGroupTime(num);
		model.addAttribute("time", groupTime);
		
		// 최근 게시글 불러오기
		ArrayList<GroupPostVO> boardlist = groupService.getRecentGroupBoard(num, recentBoard);
		// 전체 그룹 일정 불러오기
		ArrayList<GroupCalendarVO> calendarlist = groupService.getCalendar(num);
		
		if(calendarlist != null || calendarlist.size() != 0) {
			Calendar today = Calendar.getInstance();
			Calendar calDate = Calendar.getInstance();
			
			for(GroupCalendarVO tmp : calendarlist) {
				 calDate.setTime(tmp.getGocal_startdate()); 
				 
				 long calMs = calDate.getTimeInMillis();
				 long todayMs = today.getTimeInMillis();
				 long res = (calMs - todayMs)/(60*60*1000*24);
				 
				if(res >= 0) {
					ddaylist.add(tmp);
				}
			}
		}
		
		model.addAttribute("calendarlist", calendarlist);
		model.addAttribute("ddaylist", ddaylist);
		model.addAttribute("boardlist", boardlist);
		
		return "/group/mygroup/home";
	}
	
	@ResponseBody
	@PostMapping("/group/timerWork")
	public Map<String, Object> groupTimerWork(@RequestParam("num")int num){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean isTimeupdated = groupService.updateGoTime(num);
		
		if(isTimeupdated) {
			long time = groupService.getGoTimeByGoNum(num);
			
			map.put("time", time);
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@GetMapping("/group/post")
	public String grouppost(Model model, HttpSession session, int num){
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		// 가입하지 않은 그룹 게시판에 접근했을 경우
		if(!groupService.isGroupMember(user, num)) {
			return "/group/mygroup/grouppost";
		}
		
		GroupVO group = groupService.getGroupByGoNum(num);
		model.addAttribute("group", group);
		
		
		
		return "/group/mygroup/grouppost";
	}
	
	@ResponseBody
	@PostMapping("/group/post/list")
	public Map<String, Object> getGroupPostList(@RequestBody Criteria cri){
		Map<String, Object> map = new HashMap<String, Object>();
		int goNum = -1;
		
		try {
			goNum = Integer.parseInt(cri.getSearch());
		}catch(Exception e) {
			System.out.println("error ParseInt: " + cri.getSearch());
		}
		
		cri.setPerPageNum(5); 
		
		ArrayList<GroupPostVO> postList = groupService.getGroupPostByGoNum(goNum, cri);
		
		int totalCount = groupService.getGroupPostTotalCount(goNum);
		
		PageMaker pm = new PageMaker(1, cri, totalCount);
		
		map.put("list", postList);
		map.put("pm", pm);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/post/insert")
	public Map<String, Object> groupPostInsert(@RequestParam("num")int num, @RequestParam("content")String content, @RequestParam("writer")String writer){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean result = groupService.insertGroupPost(num, writer, content);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/post/delete")
	public Map<String, Object> groupPostDelete( HttpSession session, @RequestParam("num")int num){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		boolean result = groupService.deleteGroupPost(num, user);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/post/update")
	public Map<String, Object> groupPostUpdate(HttpSession session, @RequestParam("num")int num, @RequestParam("content")String content){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");

		boolean result = groupService.updateGroupPost(num, content, user);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@GetMapping("/group/manage/info")
	public String groupmanageinfo(Model model, HttpSession session, int num){
		MemberVO user = (MemberVO)session.getAttribute("user");
		GroupVO group = groupService.getGroupByGoNum(num);
		
		if(group.getLeader().equals(user.getMe_id())) {
			Criteria cri = new Criteria();
			
			cri.setPerPageNum(0); // 모든 내역을 보기 위해서(Mapper에서 관련 조건 설정함)
			
			ArrayList<GroupMemberVO> list = groupService.getGroupMember(num, cri);
			
			model.addAttribute("list", list);
			model.addAttribute("group", group);
		}
		
		
		return "/group/mygroup/manageinfo";
	}
	
	@ResponseBody
	@PostMapping("/group/manage/info/update")
	public Map<String, Object> groupManageUpdate(HttpSession session, @RequestParam("num")int num, @RequestParam("name")String name){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		boolean result = groupService.updateGroupName(num, name, user);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/manage/info/timereset")
	public Map<String, Object> groupManagetimereset(HttpSession session, @RequestParam("num")int num){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		boolean result = groupService.updateGroupTimer(num, user);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/manage/info/freeze")
	public Map<String, Object> groupManagefreeze(HttpSession session, @RequestParam("num")int num, @RequestParam("freeze")boolean freeze){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		boolean result = groupService.updateGoUpdate(num, freeze, user);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/manage/info/changeleader")
	public Map<String, Object> groupManagechangeleader(HttpSession session, @RequestParam("num")int num, @RequestParam("id")String id){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		boolean result = groupService.changeGroupLeader(num, id, user);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/manage/info/deletegroup")
	public Map<String, Object> groupManagedeletegroup(HttpSession session, @RequestParam("num")int num){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		boolean result = groupService.deleteGroupByGoNum(num, user);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	
	@GetMapping("/group/manage/applicant")
	public String groupmanageapplicant(Model model, HttpSession session, int num){
		MemberVO user = (MemberVO)session.getAttribute("user");
		GroupVO group = groupService.getGroupByGoNum(num);
		
		if(group.getLeader().equals(user.getMe_id())) {
			
			
			model.addAttribute("group", group);		// 그룹 정보
		}
		
		return "/group/mygroup/manageapplicant";
	}
	
	@ResponseBody
	@PostMapping("/group/manage/applicant/list")
	public Map<String, Object> groupmanageapplicantlist(@RequestBody Criteria cri){
		Map<String, Object> map = new HashMap<String, Object>();
		int num = -1;
		
		try {
			num = Integer.parseInt(cri.getSearch());
		}catch(Exception e) {
			System.out.println("error ParseInt: " + cri.getSearch());
		}
		
		cri.setPerPageNum(10);
		
		ArrayList<GroupApplyVO> applyList = groupService.getApplyListByGoNum(num, cri);
		int totalCount = groupService.getApplicantTotalCount(num);
		
		PageMaker pm = new PageMaker(10, cri, totalCount);
		
		map.put("list", applyList);
		map.put("pm", pm);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/manage/applicant/insert")
	public Map<String, Object> groupmanageapplicantinsert(HttpSession session, @RequestParam("num")int num, @RequestParam("apNum")int apNum){
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean result = groupService.insertGroupMember(user, num, apNum);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/manage/applicant/cancel")
	public Map<String, Object> groupmanageapplicantcancel(HttpSession session, @RequestParam("num")int num, @RequestParam("apNum")int apNum){
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean result = groupService.cancelApply(user, num, apNum);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@GetMapping("/group/manage/member")
	public String groupmanagemember(Model model, HttpSession session, int num){
		MemberVO user = (MemberVO)session.getAttribute("user");
		GroupVO group = groupService.getGroupByGoNum(num);
		
		if(group.getLeader().equals(user.getMe_id())) {
			model.addAttribute("group", group);
		}
		
		return "/group/mygroup/managemember";
	}
	
	@ResponseBody
	@PostMapping("/group/manage/member/list")
	public Map<String, Object> groupmanagememberlist(@RequestBody Criteria cri){
		Map<String, Object> map = new HashMap<String, Object>();
		int num = -1;
		
		try {
			num = Integer.parseInt(cri.getSearch());
		}catch(Exception e) {
			System.out.println("error ParseInt: " + cri.getSearch());
		}
		
		cri.setPerPageNum(5);
		
		ArrayList<GroupMemberVO> list = groupService.getGroupMember(num, cri);
		
		int totalCount = groupService.getGroupMemberTotalCount(num);
		
		PageMaker pm = new PageMaker(10, cri, totalCount);
		
		map.put("list", list);
		map.put("pm", pm);
		
		return map;
		
	}
	
	@ResponseBody
	@PostMapping("/group/manage/member/warn")
	public Map<String, Object> groupmanagememberwarn(@RequestParam("num")int num, @RequestParam("id")String id){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean result = groupService.updateGroupMemberGome_warn(num, id);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/manage/applicant/ban")
	public Map<String, Object> groupmanagememberban(@RequestParam("num")int num, @RequestParam("id")String id){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean result = groupService.deleteGroupMember(num, id);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/group/calendar/insert")
	public Map<String, Object> groupCalendarInsert(HttpSession session, @RequestParam("num")int num, 
			@RequestParam("title")String title, @RequestParam("startdt")Date startdt, @RequestParam("enddt")Date enddt, 
			@RequestParam("memo")String memo){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		GroupCalendarVO newSch = new GroupCalendarVO(title, startdt, enddt, memo);
		
		boolean result = groupService.insertGroupCal(num, newSch, user);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/calendar/delete")
	public Map<String, Object> groupCalendarDelete(HttpSession session, @RequestParam("num")int num, @RequestParam("calNum")int calNum){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		boolean result = groupService.deleteGroupCal(num, calNum, user);
		
		if(result) {
			map.put("data", "ok");
		}else {
			map.put("data", "");
		}
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/quit")
	public Map<String, Object> groupQuit(HttpSession session, @RequestParam("num")int num){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		
		boolean res = groupService.quitGroup(num, user);
		
		if (res) {
			map.put("data", "ok");
		}else {
			map.put("data", null);
		}
		
		return map;
	}
	
	@GetMapping("/group/review")
	public String groupmutualreview(Model model, HttpSession session, int num){
		MemberVO user = (MemberVO)session.getAttribute("user");
		GroupVO group = groupService.getGroupByGoNum(num);
		
		model.addAttribute("user", user);

		if(groupService.isGroupMember(user, num)) {
			model.addAttribute("group", group);
		}
		
		return "/group/mygroup/mutualreview";
	}
	
	@ResponseBody
	@PostMapping("/group/noreview/list")
	public Map<String, Object> groupmutualreviewnolist(@RequestBody Criteria cri){
		Map<String, Object> map = new HashMap<String, Object>();
		int num = -1;
		
		try {
			num = Integer.parseInt(cri.getSearch());
		}catch(Exception e) {
			System.out.println("error ParseInt: " + cri.getSearch());
		}
		
		cri.setPerPageNum(2);
		
		ArrayList<GroupMemberVO> list = groupService.getNotReviewedMember(num, cri);
		
		int totalCount = groupService.getNotReviewedMemberTotalCount(num, cri.getType());
		
		PageMaker pm = new PageMaker(10, cri, totalCount);
		
		map.put("list", list);
		map.put("pm", pm);
		
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/reviewed/list")
	public Map<String, Object> groupmutualreviewedlist(@RequestBody Criteria cri){
		Map<String, Object> map = new HashMap<String, Object>();
		int num = -1;
		
		try {
			num = Integer.parseInt(cri.getSearch());
		}catch(Exception e) {
			System.out.println("error ParseInt: " + cri.getSearch());
		}
		
		cri.setPerPageNum(2);
		
		ArrayList<MutualReviewVO> list = groupService.getReviewedMember(num, cri);
		
		int totalCount = groupService.getReviewedMemberTotalCount(num, cri.getType());
		
		PageMaker pm = new PageMaker(10, cri, totalCount);
		
		map.put("list", list);
		map.put("pm", pm);
		
		
		return map;
	}
	
	@PostMapping("/group/review/insert")
	public String mutualreviewinsert(HttpSession session, Model model, MutualReviewDTO mutualReviewDto){
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(groupService.isReviewedMember(mutualReviewDto) != null) {
			model.addAttribute("msg", "이미 평가한 멤버입니다.");
		}
		else if(groupService.insertMutualReview(mutualReviewDto, user)) {
			model.addAttribute("msg", "상호평가를 저장했습니다");
		}else {
			model.addAttribute("msg", "작성된 상호평가를 저장하지 못했습니다");
		}
		
		model.addAttribute("url", "/group/review?num="+mutualReviewDto.getNum());

		return "message";
	}
	
	// ================================ group ================================
		

	@GetMapping("/group/list")
	public String groupList(Model model) {
		return "/group/list";
	}
	
	@ResponseBody
	@PostMapping("/group/list")
	public Map<String, Object> groupListPost(@RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		cri.setPerPageNum(20);	//20개
		//그룹 리스트 가져오기
		ArrayList<RecruitVO> groupList = groupService.getGroupList(cri);
		int totalCount = groupService.getGroupTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		
		//그룹 세부 정보 가져오기
		String table_name = "recruit";
		
		//모집분야
		ArrayList<TotalCategoryVO> totalCategory = new ArrayList<TotalCategoryVO>();
		//사용언어
		ArrayList<TotalLanguageVO> totalLanguage = new ArrayList<TotalLanguageVO>();

		System.out.println("totalCategory : " + totalCategory);
		for(RecruitVO group : groupList) {
			//그룹 번호
			int recu_num = group.getRecu_num();
			
			ArrayList<TotalCategoryVO> Category = groupService.getCategory(recu_num, table_name);
			ArrayList<TotalLanguageVO> Language = groupService.getLanguage(recu_num, table_name);
			
			totalCategory.addAll(Category);
			totalLanguage.addAll(Language);			
		}
		
		
		map.put("totalCategory", totalCategory);
		map.put("totalLanguage", totalLanguage);
		map.put("list", groupList);
		map.put("pm", pm);
		return map;
	}
	
  @GetMapping("/group/detail")
	public String postDetail(HttpSession session, Model model, int num) {
		//모집공고를 가져옴
		RecruitVO recruit = groupService.getRecruit(num);
		if(recruit == null) {
			return "redirect:/";
		}
		//모집공고를 올린 그룹장 가져옴
		MemberVO groupKing = groupService.getGroupKing(recruit.getRecu_go_num());
		//모집 공고에 등록된 분야, 언어 가져옴
		String table = "recruit";
		ArrayList<TotalCategoryVO> totalCategory = groupService.getCategory(num, table);
		ArrayList<TotalLanguageVO> totalLanguage = groupService.getLanguage(num, table);
		//신고 유형 정보 가져오기
		ArrayList<ReportContentVO> contentList = reportService.getReportContentList();
		
		//그룹 신고 여부 불러오기
		boolean istrue = true;
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			istrue = reportService.getReportIsTrue(Integer.toString(num), "recruit", user.getMe_id());
		}
		
		// 좋아요수 
		Integer recu_num = num;
		RecommendVO reco_recu_count = recommendService.getRecuRecoCount(recu_num);
		
		//화면에 전송
		model.addAttribute("recruit", recruit);
		model.addAttribute("istrue", istrue);
		model.addAttribute("groupKing", groupKing.getMe_nickname());
		model.addAttribute("groupKing_me_id", groupKing.getMe_id());
		model.addAttribute("totalCategory", totalCategory);
		model.addAttribute("totalLanguage", totalLanguage);
		model.addAttribute("contentList", contentList);
		model.addAttribute("reco_recu_count", reco_recu_count);
		return "/group/detail";
	}
  
  @GetMapping("/group/apply")
  public String groupApply(Model model, int num) {
	  RecruitVO recruit = groupService.getRecruit(num);
	  if(recruit == null) {
		  return "redirect:/";
	  }
	  
	  model.addAttribute("recruit", recruit);
	  
	  return "/group/apply";
  }
  
  @PostMapping("/group/apply")
  public String groupApplyPost(Model model, HttpSession session, @RequestParam("num") Integer num, GroupApplyVO goapVo) {
	  
	  MemberVO user = (MemberVO)session.getAttribute("user");
	  
	  RecruitVO recruit = groupService.getRecruit(num);
	  if(recruit == null) {
		  return "redirect:/";
	  }
	  
	  GroupApplyVO goap = groupService.getGroupApply(num, user);
	  
	  // 그룹 번호랑 공고의 그룹 번호가 같은 거 select
	  ArrayList<GroupVO> groups = groupService.getGroupListByRecuNum(recruit.getRecu_go_num());
	  boolean apply = false;
	  
	  for (GroupVO group : groups) {
		  // 그룹 번호와 공고 그룹 번호 같은 경우
		  if (group.getGo_num() == recruit.getRecu_go_num()) {
			  
			  if(goap == null || goap.getGoap_me_id() == null) {
				  boolean res = groupService.insertGroupApply(group, recruit.getRecu_num(), goapVo, user);
				  if(res) {
					  apply = true;
					  break;
				  }
			  } else {
				  String[] applyUserIds = goap.getGoap_me_id().split(",");
				  boolean alreadyApply = false;
				  
				  for(String applyUserId : applyUserIds) {
					  if(applyUserId.trim().equals(user.getMe_id())) {
						  alreadyApply = true;
						  break;
					  }
				  }
				  if(alreadyApply) {
					  model.addAttribute("msg", "이미 지원한 그룹입니다.");
					  model.addAttribute("url", "/group/detail?num=" + num);
					  return "message";
				  } else {
					  boolean res = groupService.insertGroupApply(group, recruit.getRecu_num(), goapVo, user);
				  }
			  }
		  }
	  }
	  
	  if(apply) {
		  model.addAttribute("msg", "지원서를 제출했습니다.");
		  model.addAttribute("url", "/group/applydetail?num=" + num);
	  } else {
		  model.addAttribute("msg", "지원서를 제출하지 못했습니다.");
		  model.addAttribute("url", "/group/apply?num=" + num ); 
	  }
	  
	  return "message";
  }

  
  @GetMapping("/group/apply/detail")
  public String grouopApplyDetail(Model model, HttpSession session,Integer num) {
	  MemberVO user = (MemberVO)session.getAttribute("user");
	  
	  RecruitVO recruit = groupService.getRecruit(num);
	  if(recruit == null) {
		  return "redirect:/";
	  }
	  
	  GroupApplyVO goapVo = groupService.getGroupApply(num, user);
	  if(goapVo == null) {
		  return "redirect:/";
	  }
	  
	  model.addAttribute("recruit", recruit);
	  model.addAttribute("goap", goapVo);
	  
	  return "/group/applydetail";
  }
 
  @GetMapping("/group/apply/update")
  public String groupApplyUpdate(Model model, HttpSession session, Integer num) {
	  MemberVO user = (MemberVO)session.getAttribute("user");
	  
	  RecruitVO recruit = groupService.getRecruit(num);
	  if(recruit == null) {
		  return "redirect:/";
	  }
	  
	  GroupApplyVO goapVo = groupService.getGroupApply(num, user);
	  if(goapVo == null) {
		  return "redirect:/";
	  }
	  
	  model.addAttribute("recruit", recruit);
	  model.addAttribute("goap", goapVo);
	  
	  return "/group/applyupdate";
  }
  
  @PostMapping("/group/applyupdate")
  public String groupApplyUpdatePost(Model model, HttpSession session, GroupApplyVO goapVo, Integer num) {
	  MemberVO user = (MemberVO)session.getAttribute("user");
	  
	  RecruitVO recruit = groupService.getRecruit(num);
	  if(recruit == null) {
		  return "redirect:/";
	  }
	  
	  // 그룹 번호랑 공고의 그룹 번호가 같은 거 select
	  ArrayList<GroupVO> groups = groupService.getGroupListByRecuNum(recruit.getRecu_go_num());
	  
	  boolean updateapply = false;
  
	  for (GroupVO group : groups) {
		  // 그룹 번호와 공고 그룹 번호 같은 경우
		  if (group.getGo_num() == recruit.getRecu_go_num()) {
			  boolean res = groupService.updateGroupApply(group, recruit.getRecu_num(), goapVo, user);	
			  if(res) {
				  updateapply = true;
			  }
		  }
		  
	  }
  
	  if(updateapply) {
	  	model.addAttribute("msg", "지원서를 수정했습니다.");
	  	model.addAttribute("url", "/group/applydetail?num=" + num);
	  } else {
		model.addAttribute("msg", "지원서를 수정하지 못했습니다.");
		model.addAttribute("url", "/group/apply?num=" + num ); 
	  }
	  return "message";
  }
  

}
