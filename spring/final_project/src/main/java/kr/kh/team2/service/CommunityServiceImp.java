package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.CommunityDAO;
import kr.kh.team2.model.vo.community.BoardVO;
import kr.kh.team2.pagination.Criteria;

@Service
public class CommunityServiceImp implements CommunityService{
	
	@Autowired
	CommunityDAO communityDAO;

	@Override
	public ArrayList<BoardVO> getBoardList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 10);
		}
		return communityDAO.selectBoardList(cri);
	}

	@Override
	public int insertBoard(String board_name) {
		if(board_name == null || board_name.length()==0) {
			return -2;
		}
		
		
		BoardVO dbBoard = communityDAO.selectBoard(board_name);
		
		if(dbBoard!=null) {
			return -1;
		}
		
		return communityDAO.insertBoard(board_name);
		
	}

	@Override
	public int updateBoard(int board_num,String board_name) {
		if(board_num == 0 || board_name.length()==0 || board_name==null) {
			return -2;
		}
		
		BoardVO dbBoard = communityDAO.selectBoard(board_name);
		
		if(dbBoard!=null) {
			return -1;
		}
		
		return communityDAO.updateBoard(board_num,board_name);
		
		
		
		
		
	}

	@Override
	public boolean deleteBoard(int board_num) {
		
		if(board_num ==0) {
			return false;
		}
		return communityDAO.deleteBoard(board_num);
	}

	@Override
	public int getBoardTotalCount() {

		
		return communityDAO.selectBoardTotalCount();
		
	}
	
	

}
