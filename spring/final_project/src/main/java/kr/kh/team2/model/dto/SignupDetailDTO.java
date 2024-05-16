package kr.kh.team2.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SignupDetailDTO {
	private String interest;
	private String location;
	private int time;
	private String onoff;
	private String intro;
}
