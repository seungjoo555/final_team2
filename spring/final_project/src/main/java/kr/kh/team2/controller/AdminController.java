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

import kr.kh.team2.model.dto.ReportSimpleDTO;
import kr.kh.team2.model.vo.common.ReportVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.ReportService;

@Controller
public class AdminController {
	
	@Autowired
	ReportService reportService;
	
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
		int totalCount = reportService.gerRepoertSimpleCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);
		model.addAttribute("pm", pm);
		model.addAttribute("rsList", rsList);
		return "/admin/report";
	}
	
	@ResponseBody
	@PostMapping("/admin/report/detail")
	public Map<String, Object> mentorDetailPost(@RequestParam("repo_target")String repo_target, @RequestParam("repo_table")String repo_table) {
		Map<String, Object> map = new HashMap<String, Object>();

		//받아온 테이블,타켓 정보로 신고 리스트 가져오기
		ArrayList<ReportVO> rpList =reportService.getReportList(repo_target, repo_table);
		map.put("rpList", rpList);		
		
		//신고대상 가져오기
		//신고테이블과 대상에 따라 다르게 가져와야함
		
		return map;
	}
	

}
