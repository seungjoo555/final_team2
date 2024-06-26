package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.dto.RecommendCountDTO;
import kr.kh.team2.model.vo.common.RecommendVO;
import kr.kh.team2.model.vo.group.RecruitVO;

public interface RecommendDAO {

	boolean insertRecuRecommend(@Param("recommend")RecommendVO recommendVo);

	RecommendVO selectRecuRecommend(@Param("recommend")RecommendVO recommendVo);

	boolean updateRecuRecommend(@Param("recommend") RecommendVO reco);

	RecommendVO selectRecuRecoCount(@Param("recu_num")Integer recu_num);

	ArrayList<RecommendVO> selectRecuTotalRecommend(@Param("recommend")RecommendVO recommendVo);

	RecommendVO selectMentoringRecommend(@Param("recommend")RecommendVO recommendVo);

	boolean insertMentoringRecommend(@Param("recommend")RecommendVO recommendVo);

	boolean updateMentoringRecommend(@Param("recommend")RecommendVO reco);

	RecommendVO selectRecoMentoringCount(@Param("ment_num")Integer ment_num);

	RecommendCountDTO selectRecommendCountList(@Param("reco_table")String reco_table,  @Param("reco_target")String reco_target);


}
