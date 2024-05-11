package kr.kh.team2.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
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
	public Map<String, Object> GroupRecommend(HttpSession session, @RequestParam(name = "recu_num")Integer recu_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("get 요청 수신중");
		// 로그인 여부 확인
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    
	    if (user == null) {
	        map.put("result", false);
	        return map;
	    }
	    
	    // 추천 정보 생성
	    RecommendVO recommendVo = new RecommendVO();
	    recommendVo.setReco_target(""+recu_num);
	    recommendVo.setReco_me_id(user.getMe_id());
	    recommendVo.setReco_table("recruit");
	    
	    // 좋아요 상태 확인
	    RecommendVO reco = recommendService.getRecuRecommend(recommendVo);
	    System.out.println(reco);
	    
	    // 추천 정보가 없을 경우 처리
	    if (reco == null) {
	        map.put("result", false);
	        return map;
	    }
	    
	    RecommendVO reco_recu_count = recommendService.getRecuRecoCount(recu_num);
	    System.out.println("rrc : "+reco_recu_count);
	    System.out.println("rrcget : "+reco_recu_count.getReco_recu_count());
	    
	    map.put("result", true);
		map.put("recommend", reco);
		map.put("reco_recu_count", reco_recu_count.getReco_recu_count());
		
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
	    
	    RecommendVO reco_recu_count = recommendService.getRecuRecoCount(recu_num);
	    map.put("reco_recu_count", reco_recu_count.getReco_recu_count());
	    
		return map;
	}
	
	@ResponseBody
	@PostMapping("/mentoring/recommend")
	public Map<String, Object> MentoringRecommendPost(HttpSession session, @RequestBody Map<String, Integer> requestBody) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		// user 정보
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if (user == null) {
	        // 로그인되지 않은 상태에서는 처리하지 않음
	        map.put("result", false);
	        return map;
	    }
		
		// 공고 번호 가져오기
		Integer ment_num = requestBody.get("ment_num");
		System.out.println(ment_num);
		
		// 추천 정보 생성
	    RecommendVO recommendVo = new RecommendVO();
	    recommendVo.setReco_target(""+ment_num);
	    recommendVo.setReco_me_id(user.getMe_id());
	    recommendVo.setReco_table("mentoring");
	    
	    // 좋아요 상태 확인
	    RecommendVO reco = recommendService.getMentoringRecommend(recommendVo);
	    System.out.println("컨트롤러 reco : " + reco);
	    
	    if(reco == null) {
	    	RecommendVO newRecommend = new RecommendVO();
	    	newRecommend.setReco_target(""+ment_num);
	        newRecommend.setReco_me_id(user.getMe_id());
	        newRecommend.setReco_state(1); // 처음에는 좋아요 상태로 설정
	        boolean res = recommendService.insertMentoringRecommend(newRecommend, user, ment_num);
			if(res) {
				map.put("result", newRecommend.getReco_state());
			}
	    } else {
	    	// 추천 정보가 있는 경우 상태 변경
	        int newRecoState = reco.getReco_state() == 1 ? 0 : 1; // 상태 변경
	        reco.setReco_state(newRecoState);
	        boolean res = recommendService.updateMentoringRecommend(reco, user, ment_num);
	        if(res) {
	        	map.put("result", reco.getReco_state());
	        }
	    }
	    
	    RecommendVO reco_ment_count = recommendService.getRecuMentoringCount(ment_num);
	    System.out.println("컨트롤러 멘토링 수 : " + reco_ment_count);
	    map.put("reco_ment_count", reco_ment_count.getReco_ment_count());
	    
		return map;
	}
}
