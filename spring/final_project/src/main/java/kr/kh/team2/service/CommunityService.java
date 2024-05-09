package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.community.BoardVO;
import kr.kh.team2.pagination.Criteria;

public interface CommunityService {

	ArrayList<BoardVO> getBoardList(Criteria cri);

	int insertBoard(String board_name);

	int updateBoard(int board_num,String board_name);

	boolean deleteBoard(int board_num);

	int getBoardTotalCount();

}
