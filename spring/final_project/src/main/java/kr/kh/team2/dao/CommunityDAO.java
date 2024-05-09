package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.community.BoardVO;
import kr.kh.team2.pagination.Criteria;

public interface CommunityDAO {

	ArrayList<BoardVO> selectBoardList(@Param("cri") Criteria cri);

	int insertBoard(@Param("board_name")String board_name);

	BoardVO selectBoard(@Param("board_name")String board_name);

	boolean deleteBoard(@Param("board_num")int board_num);

	int updateBoard(@Param("board_num")int board_num, @Param("board_name")String board_name);

	int selectBoardTotalCount();

}
