package kr.kh.team2.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
		
		cri.setPerPageNum(5);
		ArrayList<ReportVO> list = reportService.getReport(cri);
		int totalCount = reportService.getBoardTotalCount(cri);
		PageMaker pm = new PageMaker(3, cri, totalCount);
		model.addAttribute("pm", pm);
		return "/admin/report";
	}
}
