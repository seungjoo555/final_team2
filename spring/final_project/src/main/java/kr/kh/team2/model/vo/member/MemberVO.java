package kr.kh.team2.model.vo.member;

import java.util.Date;

import kr.kh.team2.model.dto.SignupDTO;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberVO {
	private String me_id;
    private String me_ms_state;
    private String me_ma_auth;
    private String me_pw;
    private String me_nickname;
    private String me_name;
    private String me_phone;
    private int me_point;
    private String me_address;
    private int me_failcount;
    private int me_reportcount;
    private int me_login;
    private Date me_date;
    private int me_type;
    private float me_degree;
    private String me_interests;
    private String me_preferloc;
    private int me_prefertime;
    private int me_onoff;
    private String me_intro;
    private String me_cookie;
    private Date me_cookie_limit;
    private int me_temppw;
    private boolean autoLogin;
    
	public MemberVO(SignupDTO signupDto) {
		this.me_id = signupDto.getId();
		this.me_pw = signupDto.getPw();
		this.me_nickname = signupDto.getNickname();
		this.me_name = signupDto.getName();
		this.me_phone = signupDto.getPhone();
		this.me_address = signupDto.getAdd1() + " " + signupDto.getAdd2();
	}

	public MemberVO(String me_id) {
		this.me_id = me_id;
	}
}
