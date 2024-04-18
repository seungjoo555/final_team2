package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.group.GroupVO;

public interface GroupService {

	ArrayList<GroupVO> getGroupListById(String me_id);

}
