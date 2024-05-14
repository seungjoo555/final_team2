package kr.kh.team2.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SnsSignupDTO {
	private String sns;
	private String email;
	private String me_pw;
	private String name;
	private String phone;
	private String nickname;
	private String address;
}
