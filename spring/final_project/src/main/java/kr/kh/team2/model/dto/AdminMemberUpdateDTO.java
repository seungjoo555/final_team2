package kr.kh.team2.model.dto;

import java.util.ArrayList;

import lombok.Data;

@Data
public class AdminMemberUpdateDTO {
	private ArrayList<String> idList;
	private String me_ma_auth;
	private String me_ms_state;
}
