package kr.kh.team2.model.vo.member;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;


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
}
