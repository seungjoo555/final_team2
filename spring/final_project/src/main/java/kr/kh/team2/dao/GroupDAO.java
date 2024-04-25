package kr.kh.team2.dao;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupCalendarVO;
import kr.kh.team2.model.vo.group.GroupPostVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MetoringVO;

@Service
public interface GroupDAO {

	ArrayList<RecruitVO> selectGroupList(@Param("cri")Criteria cri);

	int selectGroupTotalCount(@Param("cri")Criteria cri);
	
	ArrayList<GroupVO> getGroupListById(@Param("id")String me_id);

	GroupVO getGroupByGoNum(@Param("num")int groupNum);

	Object isGroupMember(@Param("id")String me_id, @Param("num")int groupNum);

	RecruitVO selectRecruit(@Param("num")int num);

	MemberVO selectGroupKing(@Param("recu_go_num")int recu_go_num);

	ArrayList<TotalCategoryVO> selectCategoryList(@Param("num")int num, @Param("table")String table);

	ArrayList<TotalLanguageVO> selectLanguageList(@Param("num")int num, @Param("table")String table);

	ArrayList<GroupPostVO> getRecentGroupBoard(@Param("num")int groupNum, @Param("count")int recentBoard);

	ArrayList<GroupCalendarVO> getDday(@Param("num")int groupNum, @Param("count")int dday);

	long getGroupTime(@Param("num")int groupNum);

	boolean updateGoTime(@Param("num")int groupNum);

	ArrayList<GroupVO> selectStudyGroupList(@Param("me_id") String me_id);

	ArrayList<TotalCategoryVO> selectStudyCategoryList(@Param("recu_num")int recu_num);

	ArrayList<GroupVO> getStudyApplyList(@Param("me_id") String me_id);

}
