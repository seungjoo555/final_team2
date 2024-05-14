package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.CommonDAO;
import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;

@Service
public class CommonServiceImp implements CommonService {

	@Autowired
	CommonDAO commonDao;

	@Override
	public ArrayList<SearchMenuVO> getMenuList() {
		return commonDao.getMenuList();
	}

	@Override
	public ArrayList<ProgrammingCategoryVO> getCateList() {
		return commonDao.getCateList();
	}
	
}
