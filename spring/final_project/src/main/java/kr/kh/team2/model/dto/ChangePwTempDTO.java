package kr.kh.team2.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ChangePwTempDTO {
	private String me_id;
	private String me_pw;
	private int me_temppw;

}
