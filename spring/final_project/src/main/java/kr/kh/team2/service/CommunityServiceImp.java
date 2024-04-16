package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.CommunityDAO;
import kr.kh.team2.model.vo.community.BoardVO;

@Service
public class CommunityServiceImp implements CommunityService{
	
	@Autowired
	CommunityDAO communityDAO;

	@Override
	public ArrayList<BoardVO> getBoardList() {
		
		
		return communityDAO.selectBoardList();
	}


	
	
	
	

}
