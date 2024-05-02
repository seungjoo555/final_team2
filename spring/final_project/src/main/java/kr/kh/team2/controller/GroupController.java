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

import kr.kh.team2.model.vo.common.ReportContentVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupCalendarVO;
import kr.kh.team2.model.vo.group.GroupPostVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.GroupService;
import kr.kh.team2.service.ReportService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class GroupController {
	
	@Autowired
	GroupService groupService;
	@Autowired
	ReportService reportService;
	
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
	
	@GetMapping("/group/manage/applicant")
	public String groupmanageapplicant(Model model, HttpSession session, int num){
		MemberVO user = (MemberVO)session.getAttribute("user");
		GroupVO group = groupService.getGroupByGoNum(num);
		
		if(group.getLeader().equals(user.getMe_id())) {
			model.addAttribute("group", group);
		}
		
		return "/group/mygroup/manageapplicant";
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
		System.out.println("cri : " + cri);
		int totalCount = groupService.getGroupTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		map.put("list", groupList);
		map.put("pm", pm);
		return map;
	}
	
  @GetMapping("/group/detail")
	public String postDetail(Model model, int num) {
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
		//화면에 전송
		model.addAttribute("recruit", recruit);
		model.addAttribute("groupKing", groupKing.getMe_nickname());
		model.addAttribute("groupKing_me_id", groupKing.getMe_id());
		model.addAttribute("totalCategory", totalCategory);
		model.addAttribute("totalLanguage", totalLanguage);
		model.addAttribute("contentList", contentList);
		return "/group/detail";
	}
	
 
}
