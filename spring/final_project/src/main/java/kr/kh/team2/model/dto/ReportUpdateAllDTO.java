package kr.kh.team2.model.dto;

import java.util.ArrayList;

import lombok.Data;

@Data
public class ReportUpdateAllDTO {
	private String set_state;
	private ArrayList<ReportSimpleDTO> tdList;
	
}
