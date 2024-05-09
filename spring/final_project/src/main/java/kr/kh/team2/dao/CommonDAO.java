package kr.kh.team2.dao;

import java.util.ArrayList;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;

public interface CommonDAO {

	ArrayList<SearchMenuVO> getMenuList();

	ArrayList<ProgrammingCategoryVO> getCateList();

}
