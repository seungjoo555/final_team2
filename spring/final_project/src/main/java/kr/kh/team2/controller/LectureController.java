package kr.kh.team2.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.ReportContentVO;
import kr.kh.team2.model.vo.common.ReportVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.lecture.LectureFileVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.PageMaker;
import kr.kh.team2.service.LectureService;
import kr.kh.team2.service.ReportService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LectureController {

	@Autowired
	LectureService lectureService;
	@Autowired
	ReportService reportService;
	
	@GetMapping("/lecture/list")
	public String lectureList(Model model, Criteria cri, SearchMenuVO search) {
		cri.setPerPageNum(5);
		ArrayList<LectureVO> list = lectureService.getAllLectureList(cri);
		int lectureCount = lectureService.getLectureCount(cri, search);
		PageMaker pm = new PageMaker(3, cri, lectureCount);
		model.addAttribute("list", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "강의글 목록");
		return "/lecture/list";
	}
	
	//강의 하위메뉴 분야 선택했을때 동작
	@GetMapping("/lecture/list/cate")
	public String lectureListCate(Model model, Criteria cri, SearchMenuVO search) {
		cri.setPerPageNum(5);
		search.setSearchType("cate");
		ArrayList<LectureVO> list = lectureService.getLectureList(cri, search);
		int lectureCount = lectureService.getLectureCount(cri, search);
		PageMaker pm = new PageMaker(3, cri, lectureCount);
		model.addAttribute("list", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "강의글 목록");
		return "/lecture/list";
	}
	
	//강의 하위메뉴 언어 선택했을때 동작
	@GetMapping("/lecture/list/lang")
	public String lectureListLang(Model model, Criteria cri, SearchMenuVO search) {
		cri.setPerPageNum(5);
		search.setSearchType("lang");
		ArrayList<LectureVO> list = lectureService.getLectureList(cri, search);
		int lectureCount = lectureService.getLectureCount(cri, search);
		PageMaker pm = new PageMaker(3, cri, lectureCount);
		model.addAttribute("list", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "강의글 목록");
		return "/lecture/list";
	}
	
	//강의 동록 화면 띄우기
	@GetMapping("/lecture/insert")
	public String lectureInsert(Model model) {
		
		ArrayList<ProgrammingCategoryVO> categoryList = lectureService.getProgrammingCategoryList();
		ArrayList<ProgrammingLanguageVO> languageList = lectureService.getProgrammingLanguageList();
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("languageList", languageList);
		model.addAttribute("title","강의 등록");
		return "/lecture/insert";
	}
	
	//강의 등록하기
	@PostMapping("/lecture/insert")
	public String lectureInsertPost(Model model, String progCtList, String progLangList ,
			LectureVO lecture, HttpSession session, MultipartFile[] file) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.info(lecture);
		log.info(file);
		//강의 글 등록
		boolean res = lectureService.insertLecture(lecture, user, progCtList, progLangList, file);
		
		if(res) {
			model.addAttribute("msg", "강의를 등록했습니다.");
			model.addAttribute("url", "/lecture/list"); 
		} else {
			model.addAttribute("msg", "강의를 등록하지 못했습니다.");
			model.addAttribute("url", "/lecture/insert");
		}
		return "message";
	}
	
	//강의글 상세 조회
	@GetMapping("/lecture/detail")
	public String lectureDetail(Model model, Criteria cri, SearchMenuVO search, int lectNum, HttpSession session) {
		cri.setPerPageNum(5);
		LectureVO lecture = lectureService.getLecture(lectNum);
		//강의를 올린 멘토 아이디 닉네임 가져오기
		MemberVO writer = lectureService.getLecture_Mento(lecture.getLect_mentIf_me_id());
		//모집 공고에 등록된 분야, 언어 가져옴
		String table = "lecture";
		ArrayList<TotalCategoryVO> totalCategory = lectureService.getCategory(lectNum, table);
		ArrayList<TotalLanguageVO> totalLanguage = lectureService.getLanguage(lectNum, table);
		//첨부된 강의파일 가져오기
		ArrayList<LectureFileVO> fileList = lectureService.getFileList(lectNum);
		
		//신고 유형 정보 가져오기
		ArrayList<ReportContentVO> contentList = reportService.getReportContentList();
		//강의 신고 여부 불러오기
		boolean istrue = true;
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			istrue = reportService.getReportIsTrue(Integer.toString(lectNum), "lecture", user.getMe_id());
		}
				
		model.addAttribute("lecture", lecture);
		model.addAttribute("writer", writer);
		model.addAttribute("istrue", istrue);
		model.addAttribute("totalCategory", totalCategory);
		model.addAttribute("totalLanguage", totalLanguage);
		model.addAttribute("fileList", fileList);
		model.addAttribute("contentList", contentList);
		model.addAttribute("title", "강의 상세");
		return "/lecture/detail";
	}
}
