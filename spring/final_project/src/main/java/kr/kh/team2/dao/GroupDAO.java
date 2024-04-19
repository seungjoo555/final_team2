package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.group.GroupVO;

public interface GroupDAO {

	ArrayList<GroupVO> getGroupListById(@Param("id")String me_id);

	GroupVO getGroupByGoNum(@Param("num")int groupNum);

	Object isGroupMember(@Param("id")String me_id, @Param("num")int groupNum);

}
