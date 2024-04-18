package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.community.BoardVO;
import kr.kh.team2.model.vo.community.PostVO;

public interface CommunityService {

	ArrayList<BoardVO> getBoardList();

	boolean insertPost(PostVO post);

}
