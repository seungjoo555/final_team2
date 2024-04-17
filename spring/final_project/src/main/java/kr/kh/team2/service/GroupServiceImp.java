package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.GroupDAO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.utils.Methods;

@Service
public class GroupServiceImp implements GroupService{
	private Methods methods = new Methods();
	
	@Autowired
	GroupDAO groupDao;

	@Override
	public ArrayList<GroupVO> getGroupListById(String me_id) {
		if(!methods.checkString(me_id)) {
			return null;
		}
		
		return groupDao.getGroupListById(me_id);
	}
	
	
}
