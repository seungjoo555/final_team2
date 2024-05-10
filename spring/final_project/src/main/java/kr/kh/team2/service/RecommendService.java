package kr.kh.team2.service;

import kr.kh.team2.model.vo.common.RecommendVO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface RecommendService {

	boolean insertRecuRecommend(RecommendVO recommendVo, MemberVO user, Integer recu_num);

	RecommendVO getRecuRecommend(RecommendVO recommendVo);

	boolean updateRecuRecommend(RecommendVO reco, MemberVO user, Integer recu_num);

}
