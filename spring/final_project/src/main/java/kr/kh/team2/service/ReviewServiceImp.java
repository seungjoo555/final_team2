package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.ReviewDAO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.MutualReviewVO;
import kr.kh.team2.model.vo.group.RecruitVO;

@Service
public class ReviewServiceImp implements ReviewService {

	@Autowired
	ReviewDAO reviewDao;

	@Override
	public ArrayList<MutualReviewVO> getMutualReviewList(String me_id) {
		return reviewDao.selectMutualReviewList(me_id);
	}

}
