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
}
