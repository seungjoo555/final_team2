package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.GroupDAO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.pagination.Criteria;

@Service
public class GroupServiceImp implements GroupService {
	
	@Autowired
	GroupDAO groupDAO;

	@Override
	public ArrayList<RecruitVO> getGroupList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 5);
		}
		return groupDAO.selectGroupList(cri);
	}

}
