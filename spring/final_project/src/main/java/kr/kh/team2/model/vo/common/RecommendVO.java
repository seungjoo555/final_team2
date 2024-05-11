package kr.kh.team2.model.vo.common;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RecommendVO {
	private int reco_num;
    private String reco_me_id;
    private int reco_state;
    private String reco_table;
    private String reco_target;
    
    private int recu_num;	// 추천 공고 번호
    private int reco_recu_count; //공고 추천 수
    private int reco_ment_count; //멘로링 추천 수
}
