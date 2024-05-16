package kr.kh.team2.model.dto;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RecommendCountDTO {
	private int count;
	private String reco_table;
	private String reco_target;
	private Date recu_due;
}
