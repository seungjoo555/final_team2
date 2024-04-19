package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface GroupService {

	ArrayList<GroupVO> getGroupListById(String me_id);

	GroupVO getGroupByGoNum(int groupNum);

	boolean isGroupMember(MemberVO user, int groupNum);

}
