package kr.kh.team2.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SignupDTO {
	private String id;
	private String pw;
	private String nickname;
	private String name;
	private String phone;
	private String add1;
	private String add2;
}
