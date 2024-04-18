package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;

public interface MentoService {

	ArrayList<MetoringVO> getMentoList(Criteria cri);

	int getMentoTotalCount(Criteria cri);

}
