package kr.kh.team2.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.kh.team2.model.vo.community.BoardVO;
import kr.kh.team2.service.CommunityService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommunityController {
	
	@Autowired
	CommunityService communityService;
	
	@RequestMapping(value = "/post/insert", method = RequestMethod.GET)
	public String postInsert(Model model) {
		
		ArrayList<BoardVO> boardList = communityService.getBoardList();
		
		System.out.println(boardList);
		log.info("board: "+ boardList);
		
		model.addAttribute("boardList",boardList);
		
		
		return "/community/postinsert";
	}
}
