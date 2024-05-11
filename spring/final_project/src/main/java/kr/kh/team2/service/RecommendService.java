package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.common.RecommendVO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface RecommendService {

	boolean insertRecuRecommend(RecommendVO recommendVo, MemberVO user, Integer recu_num);

	RecommendVO getRecuRecommend(RecommendVO recommendVo);

	boolean updateRecuRecommend(RecommendVO reco, MemberVO user, Integer recu_num);

	RecommendVO getRecuRecoCount(Integer recu_num);
	
	//RecommendVO getRecuRecoCount(Integer recu_num, RecommendVO recommendVo, int count);

	ArrayList<RecommendVO> getRecuTotalRecommend(RecommendVO recommendVo);

	RecommendVO getMentoringRecommend(RecommendVO recommendVo);

	boolean insertMentoringRecommend(RecommendVO newRecommend, MemberVO user, Integer ment_num);

	boolean updateMentoringRecommend(RecommendVO reco, MemberVO user, Integer ment_num);

	RecommendVO getRecuMentoringCount(Integer ment_num);



}
