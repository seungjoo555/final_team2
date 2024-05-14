package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;

public interface CommonService {

	ArrayList<SearchMenuVO> getMenuList();

	ArrayList<ProgrammingCategoryVO> getCateList();

}
