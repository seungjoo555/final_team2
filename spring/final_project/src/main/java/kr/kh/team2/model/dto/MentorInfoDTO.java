package kr.kh.team2.model.dto;

import java.util.ArrayList;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class MentorInfoDTO {
	
	private String btnType;
	private ArrayList<String> checkedIds;
}
