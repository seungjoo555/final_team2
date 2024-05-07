package kr.kh.team2.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.service.LectureService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LectureController {

	@Autowired
	LectureService lectureService;
	
	@GetMapping("/lecture/list")
	public String lectureList(Model model, Criteria cri) {
		cri.setPerPageNum(5);
		ArrayList<LectureVO> list = lectureService.getLectureList(cri);
		log.info(cri);
		model.addAttribute("list", list);
		model.addAttribute("title", "강의글 목록");
		return "/lecture/list";
	}
	
	//강의 하위메뉴 분야 선택했을때 동작
	@GetMapping("/lecture/list/cate")
	public String lectureListCate(Model model, Criteria cri, SearchMenuVO search) {
		cri.setPerPageNum(5);
		ArrayList<LectureVO> list = lectureService.getLectureList(cri);
		log.info(search);
		
		model.addAttribute("list", list);
		model.addAttribute("title", "강의글 목록");
		return "/lecture/list";
	}
	
	//강의 하위메뉴 언어 선택했을때 동작
	@GetMapping("/lecture/list/lang")
	public String lectureListLang(Model model, Criteria cri, SearchMenuVO search) {
		cri.setPerPageNum(5);
		ArrayList<LectureVO> list = lectureService.getLectureList(cri);
		log.info(search);
		
		model.addAttribute("list", list);
		model.addAttribute("title", "강의글 목록");
		return "/lecture/list";
	}
}
