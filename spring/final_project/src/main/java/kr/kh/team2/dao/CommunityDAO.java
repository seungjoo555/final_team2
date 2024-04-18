package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.community.BoardVO;
import kr.kh.team2.model.vo.community.PostVO;

public interface CommunityDAO {

	ArrayList<BoardVO> selectBoardList();

	boolean insertPost(@Param("post")PostVO post);

}
