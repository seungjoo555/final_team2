package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.pagination.Criteria;

public interface GroupService {

	ArrayList<RecruitVO> getGroupList(Criteria cri);

	RecruitVO getRecruit(int num);

}