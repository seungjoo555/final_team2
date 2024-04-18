package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.CommunityDAO;
import kr.kh.team2.model.vo.community.BoardVO;
import kr.kh.team2.model.vo.community.PostVO;
import kr.kh.team2.utils.Methods;

@Service
public class CommunityServiceImp implements CommunityService {
	
	@Autowired
	CommunityDAO communityDAO;
	
	Methods methods = new Methods();

	@Override
	public ArrayList<BoardVO> getBoardList() {
		
		
		return communityDAO.selectBoardList();
	}

	@Override
	public boolean insertPost(PostVO post) {
		
		if(!methods.checkString(post.getPost_name())||
		   !methods.checkString(post.getPost_content())||
		   !methods.checkString(post.getPost_me_id())||
		   post == null) {
			return false;
		}
		
		return communityDAO.insertPost(post);
		
	}
	
	

}
