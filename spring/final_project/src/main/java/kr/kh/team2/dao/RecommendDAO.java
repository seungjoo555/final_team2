package kr.kh.team2.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.common.RecommendVO;

public interface RecommendDAO {

	boolean insertRecuRecommend(@Param("recommend")RecommendVO recommendVo);

	RecommendVO selectRecuRecommend(@Param("recommend")RecommendVO recommendVo);

	boolean updateRecuRecommend(@Param("recommend") RecommendVO reco);

}
