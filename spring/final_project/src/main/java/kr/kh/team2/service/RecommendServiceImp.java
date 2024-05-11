package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.RecommendDAO;
import kr.kh.team2.model.vo.common.RecommendVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.utils.Methods;

@Service
public class RecommendServiceImp implements RecommendService {
	
	@Autowired
	RecommendDAO recommendDao;

	Methods methods = new Methods();
	
	@Override
	public boolean insertRecuRecommend(RecommendVO recommendVo, MemberVO user, Integer recu_num) {
		
		if(user == null || recu_num == null) {
			return false;
		}
		
		recommendVo.setReco_me_id(user.getMe_id());
		recommendVo.setReco_table("recruit");
		recommendVo.setReco_target(""+ recu_num);
		
		if(recommendVo == null || 
				!methods.checkString(recommendVo.getReco_me_id()) ||
				!methods.checkString(recommendVo.getReco_table()) ||
				!methods.checkString(recommendVo.getReco_target())) {
			return false;
		}
		
//		서버에서 좋아요 상태를 확인하여 반환하도록 수정
//		RecommendVO existingRecommend = recommendDao.selectRecuRecommend(recommendVo);
//	    if (existingRecommend != null) {
//	        recommendVo.setReco_state(existingRecommend.getReco_state());
//	    }
	    
		return recommendDao.insertRecuRecommend(recommendVo);
	}

	@Override
	public RecommendVO getRecuRecommend(RecommendVO recommendVo) {
		if(recommendVo == null) {
			return null;
		}
		
		return recommendDao.selectRecuRecommend(recommendVo);
	}

	@Override
	public boolean updateRecuRecommend(RecommendVO reco, MemberVO user, Integer recu_num) {
		if(reco == null || user == null || recu_num == null) {
			return false;
		}
		
		if(reco == null || 
				!methods.checkString(reco.getReco_me_id()) ||
				!methods.checkString(reco.getReco_table()) ||
				!methods.checkString(reco.getReco_target())) {
			return false;
		}
		
		return recommendDao.updateRecuRecommend(reco);
	}

	@Override
	public RecommendVO getRecuRecoCount(Integer recu_num) {
		if (recu_num == null) {
			return null;
		}
		
		return recommendDao.selectRecuRecoCount(recu_num);
	}

	@Override
	public ArrayList<RecommendVO> getRecuTotalRecommend(RecommendVO recommendVo) {
		if(recommendVo == null) {
			return null;
		}
		
		return recommendDao.selectRecuTotalRecommend(recommendVo);
	}

	@Override
	public RecommendVO getMentoringRecommend(RecommendVO recommendVo) {
		if(recommendVo == null) {
			return null;
		}
		
		return recommendDao.selectMentoringRecommend(recommendVo);
	}

	@Override
	public boolean insertMentoringRecommend(RecommendVO recommendVo, MemberVO user, Integer ment_num) {
		if(user == null || ment_num == null) {
			return false;
		}
		
		recommendVo.setReco_me_id(user.getMe_id());
		recommendVo.setReco_table("mentoring");
		recommendVo.setReco_target(""+ ment_num);
		
		if(recommendVo == null || 
				!methods.checkString(recommendVo.getReco_me_id()) ||
				!methods.checkString(recommendVo.getReco_table()) ||
				!methods.checkString(recommendVo.getReco_target())) {
			return false;
		}
		
		return recommendDao.insertMentoringRecommend(recommendVo);
	}

	@Override
	public boolean updateMentoringRecommend(RecommendVO reco, MemberVO user, Integer ment_num) {
		if(reco == null || user == null || ment_num == null) {
			return false;
		}
		
		if(reco == null || 
				!methods.checkString(reco.getReco_me_id()) ||
				!methods.checkString(reco.getReco_table()) ||
				!methods.checkString(reco.getReco_target())) {
			return false;
		}
		
		return recommendDao.updateMentoringRecommend(reco);
	}

	@Override
	public RecommendVO getRecuMentoringCount(Integer ment_num) {
		if (ment_num == null) {
			return null;
		}
		
		return recommendDao.selectRecuMentoringCount(ment_num);
	}


}
