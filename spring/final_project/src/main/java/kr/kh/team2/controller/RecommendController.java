package kr.kh.team2.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team2.model.vo.common.RecommendVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.service.RecommendService;
import kr.kh.team2.service.RecruitService;

@Controller
public class RecommendController {
	
	@Autowired
	RecommendService recommendService;

	@Autowired
	RecruitService recruitService;
	
	
	@GetMapping("/group/recommend")
	public Map<String, Object> GroupRecommend(HttpSession session, Integer recu_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 로그인 여부 확인
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    if (user == null) {
	        map.put("result", false);
	        return map;
	    }
	    
		// 추천 정보 받아오기
		RecommendVO recommendVo = new RecommendVO();
	    recommendVo.setRecu_num(recu_num);
		RecommendVO recommend = recommendService.getRecuRecommend(recommendVo);
		
		// 추천 정보가 없을 경우 처리
	    if (recommend == null) {
	        map.put("result", false);
	        return map;
	    }
	    
	    map.put("result", true);
		map.put("recommend", recommend);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/group/recommend")
	public Map<String, Object> GroupRecommendPost(HttpSession session, @RequestBody Map<String, Integer> requestBody) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		// user 정보
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if (user == null) {
	        // 로그인되지 않은 상태에서는 처리하지 않음
	        map.put("result", false);
	        return map;
	    }
		
		// 공고 번호 가져오기
		Integer recu_num = requestBody.get("recu_num");
		
		// 추천 정보 생성
	    RecommendVO recommendVo = new RecommendVO();
	    recommendVo.setReco_target(""+recu_num);
	    recommendVo.setReco_me_id(user.getMe_id());
	    recommendVo.setReco_table("recruit");
	    
	    // 좋아요 상태 확인
	    RecommendVO reco = recommendService.getRecuRecommend(recommendVo);
	    
	    if(reco == null) {
	    	RecommendVO newRecommend = new RecommendVO();
	    	newRecommend.setReco_target(""+recu_num);
	        newRecommend.setReco_me_id(user.getMe_id());
	        newRecommend.setReco_state(1); // 처음에는 좋아요 상태로 설정
	        boolean res = recommendService.insertRecuRecommend(newRecommend, user, recu_num);
			if(res) {
				map.put("result", newRecommend.getReco_state());
			}
	    } else {
	    	// 추천 정보가 있는 경우 상태 변경
	        int newRecoState = reco.getReco_state() == 1 ? 0 : 1; // 상태 변경
	        reco.setReco_state(newRecoState);
	        boolean res = recommendService.updateRecuRecommend(reco, user, recu_num);
	        if(res) {
	        	map.put("result", reco.getReco_state());
	        }
	    }

		return map;
	}
}
