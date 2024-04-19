package kr.kh.team2.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.MentoService;

@Controller
public class MentoController {
	
	@Autowired
	MentoService mentoService;
	
	@GetMapping("/mento/list")
	public String mentoList() {
		return "/mento/list";
	}
	
	
	@ResponseBody
	@PostMapping("/mento/list")
	public Map<String, Object> mentoListPost(@RequestBody Criteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		cri.setPerPageNum(20);	//default : 20
		//그룹 리스트 가져오기
		ArrayList<MetoringVO> mentoList = mentoService.getMentoList(cri);
		System.out.println("[MentoController] mentoList :: " + mentoList);
		int totalCount = mentoService.getMentoTotalCount(cri);
		PageMaker pm = new PageMaker(10, cri, totalCount);	//default : 10
		map.put("list", mentoList);
		map.put("pm", pm);
		return map;
	}

}
