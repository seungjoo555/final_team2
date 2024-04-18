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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team2.model.vo.community.BoardVO;
import kr.kh.team2.model.vo.community.PostVO;
import kr.kh.team2.model.vo.member.MemberVO;
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
		
		
		model.addAttribute("boardList",boardList);
		
		
		return "/community/postinsert";
	}
	
	@PostMapping("/post/insert")
	public String postInsertPost(HttpSession session, PostVO post, Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		String post_me_id = user.getMe_id();
		
		post.setPost_me_id(post_me_id);
		boolean res = communityService.insertPost(post);
		
		if(res) {
			model.addAttribute("msg","게시글을 작성하였습니다.");
			model.addAttribute("url","/");
			return "message";
		}
		model.addAttribute("msg","게시글을 작성하지 못했습니다.");
		model.addAttribute("url","/");
		return "message";
	}
	
	@GetMapping("/community")
	public String communityMain() {
		
		
		return "/community/communitymain";
	}
	
	@GetMapping("/community/board")
	@ResponseBody
	public Map<String,Object> communityBoard(){
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		ArrayList<BoardVO> boardList = communityService.getBoardList();
		map.put("boardList", boardList);
		return map;
	}

}
