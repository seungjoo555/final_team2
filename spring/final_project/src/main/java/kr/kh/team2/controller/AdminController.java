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

import kr.kh.team2.model.dto.ReportSimpleDTO;
import kr.kh.team2.model.dto.ReportUpdateAllDTO;
import kr.kh.team2.model.vo.common.ReportVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.GroupService;
import kr.kh.team2.service.MemberService;
import kr.kh.team2.service.MentorService;
import kr.kh.team2.service.RecruitService;
import kr.kh.team2.service.ReportService;

@Controller
public class AdminController {
	
	@Autowired
	ReportService reportService;
	@Autowired
	MemberService memberService;
	@Autowired
	RecruitService recruitService;
	@Autowired
	GroupService groupService;
	@Autowired
	MentorService mentorService;
	
	@GetMapping("/admin/report")
	public String adminReport(Model model, Criteria cri){
		
		cri.setPerPageNum(10);
		//신고테이블과 타켓이 동일한 신고 리스트
		ArrayList<ReportSimpleDTO> rsList = reportService.gerRepoertSimple(cri);
		for(int i=0; i<rsList.size(); i++) {
			//신고 테이블 명 지정
			rsList.get(i).setRepo_table_str(reportService.setRepoTableStr(rsList.get(i).getRepo_table()));
			//신고 대상 명 지정
			rsList.get(i).setRepo_target_str(reportService.setTargetStr(rsList.get(i)));
		}
		//멤버 상태 리스트 가져오기
		ArrayList<String> stateList = memberService.getMemberStateList();
		model.addAttribute("stateList", stateList);		
		int totalCount = reportService.gerRepoertSimpleCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		model.addAttribute("pm", pm);
		model.addAttribute("rsList", rsList);
		return "/admin/report";
	}
	
	@ResponseBody
	@PostMapping("/admin/report/detail")
	public Map<String, Object> adminReportPost(@RequestParam("repo_target")String repo_target, @RequestParam("repo_table")String repo_table) {
		Map<String, Object> map = new HashMap<String, Object>();

		//받아온 테이블,타켓 정보로 신고 리스트 가져오기
		ArrayList<ReportVO> rpList =reportService.getReportList(repo_target, repo_table);
		map.put("rpList", rpList);		
		
		//멤버 상태 리스트 가져오기
		ArrayList<String> stateList = memberService.getMemberStateList();
		map.put("stateList", stateList);		
		
		//신고대상 가져오기
		String me_id = "", link = "";
		if(repo_table.equals("recruit")) {	//모집공고
			me_id = groupService.getGroupLeaderID(Integer.parseInt(repo_target));
			link = "/team2/group/detail?num="+repo_target;
		}else if(repo_table.equals("member")) {		//유저
			me_id = repo_target;
			link = "/team2/mypage/profile?me_id="+repo_target;
		}else if(repo_table.equals("mentoring")) {		//멘토링
			me_id = mentorService.getMentoring(Integer.parseInt(repo_target)).getMent_me_id();
			link = "/team2/mentor/list"; //아...이거 주소 어카지...
		}else if(repo_table.equals("lecture")) {		//강의
			
		}else if(repo_table.equals("post")) {		//게시글
			
		}else if(repo_table.equals("comment")) {		//댓글
			
		}
		//멤버 찾기
		MemberVO member = memberService.getMember(me_id);
		map.put("member", member);
		map.put("link", link);
		
		//신고대상 링크 정보
		//신고테이블과 대상에 따라 다르게 가져와야함
		
		return map;
	}
	@ResponseBody
	@PostMapping("/admin/report/update")
	public Map<String, Object> adminReportUpdate(@RequestParam("set_me_id")String set_me_id, @RequestParam("set_state") String set_state
												, @RequestParam("repo_target")String repo_target, @RequestParam("repo_table")String repo_table) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		//멤버 상태 변경하기
		boolean res = memberService.updateMemberState(set_me_id, set_state);
		//신고 처리여부 변경(대기중, 반려, 승인)
		String state = "처리완료";
		
		if(res) {
			if(memberService.getMember(set_me_id).getMe_ms_state().equals("이용중")) {
				state = "반려";
			}
			reportService.reportStateProcess(repo_target, repo_table, state);
		}
		map.put("result", res);
		map.put("state", state);
		return map;
	}
	@ResponseBody
	@PostMapping("/admin/report/update/all")
	public Map<String, Object> adminReportUpdateAll(@RequestBody ReportUpdateAllDTO updateDto) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<String> meIdList = new ArrayList<String>();
		for(ReportSimpleDTO i: updateDto.getTdList()) {
			//회원 아이디 가져오기
			if(i.getRepo_table().equals("recruit")) {	//모집공고
				meIdList.add(groupService.getGroupLeaderID(Integer.parseInt(i.getRepo_target())));
			}else if(i.getRepo_table().equals("member")) {		//유저
				meIdList.add(i.getRepo_target());
			}else if(i.getRepo_table().equals("mentoring")) {		//멘토링
				meIdList.add(mentorService.getMentoring(Integer.parseInt(i.getRepo_target())).getMent_me_id());
			}else if(i.getRepo_table().equals("lecture")) {		//강의
				
			}else if(i.getRepo_table().equals("post")) {		//게시글
				
			}else if(i.getRepo_table().equals("comment")) {		//댓글
				
			}
		}
		
		//회원 정보 처리
		boolean res = false;
		for(String set_me_id : meIdList) {
			res = memberService.updateMemberState(set_me_id, updateDto.getSet_state());
		}
		//신고처리여부 변경
		String state = "처리완료";
		
		if(res) {
			if(updateDto.getSet_state().equals("이용중")) {
				state = "반려";
			}
			for(ReportSimpleDTO i: updateDto.getTdList()) {
				reportService.reportStateProcess(i.getRepo_target(), i.getRepo_table(), state);
			}
		}
		map.put("result", res);
		map.put("state", state);
		return map;
	}
}
