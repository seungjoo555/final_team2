package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.group.MutualReviewVO;
import kr.kh.team2.model.vo.group.RecruitVO;

public interface ReviewDAO {

	ArrayList<MutualReviewVO> selectMutualReviewList(@Param("me_id")String me_id);

	RecruitVO selectRecuType(@Param("me_id")String me_id);


}
