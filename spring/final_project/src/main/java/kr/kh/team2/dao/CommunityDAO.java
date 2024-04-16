package kr.kh.team2.dao;

import java.util.ArrayList;

import kr.kh.team2.model.vo.community.BoardVO;

public interface CommunityDAO {

	ArrayList<BoardVO> selectBoardList();

}
