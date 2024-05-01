package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.group.MutualReviewVO;

public interface ReviewService {

	ArrayList<MutualReviewVO> getMutualReviewList(String me_id);

}
