package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupApplyVO;
import kr.kh.team2.model.vo.group.GroupCalendarVO;
import kr.kh.team2.model.vo.group.GroupMemberVO;
import kr.kh.team2.model.vo.group.GroupPostVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.MutualReviewVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;

@Service
public interface GroupDAO {

	ArrayList<RecruitVO> selectGroupList(@Param("cri")Criteria cri);

	int selectGroupTotalCount(@Param("cri")Criteria cri);
	
	ArrayList<GroupVO> getGroupListById(@Param("id")String me_id, @Param("cri")Criteria cri);

	GroupVO getGroupByGoNum(@Param("num")int groupNum);

	Object isGroupMember(@Param("id")String me_id, @Param("num")int groupNum);

	RecruitVO selectRecruit(@Param("num")int num);

	MemberVO selectGroupKing(@Param("recu_go_num")int recu_go_num);

	ArrayList<TotalCategoryVO> selectCategoryList(@Param("num")int num, @Param("table")String table);

	ArrayList<TotalLanguageVO> selectLanguageList(@Param("num")int num, @Param("table")String table);

	ArrayList<GroupPostVO> getRecentGroupBoard(@Param("num")int groupNum, @Param("count")int recentBoard);

	long getGroupTime(@Param("num")int groupNum);

	boolean updateGoTime(@Param("num")int groupNum);

	ArrayList<GroupVO> selectStudyGroupList(@Param("me_id") String me_id);

	ArrayList<TotalCategoryVO> selectStudyCategoryList(@Param("recu_num")int recu_num);

	ArrayList<GroupVO> getStudyApplyList(@Param("me_id") String me_id);

	int selectGroupMemberCount(@Param("go_num")int go_num);

	ArrayList<GroupPostVO> getGroupPostByGoNum(@Param("num")int groupNum, @Param("cri")Criteria cri);

	boolean insertGroupPost(@Param("num")int goNum, @Param("writer")String writer, @Param("content")String content);

	int getMyGroupTotalCount(@Param("id")String me_id);

	int getGroupPostTotalCount(@Param("num")int goNum);

	boolean deleteGroupPost(@Param("num")int gopoNum);

	GroupPostVO getGroupPostByGopoNum(@Param("num")int gopoNum);

	GroupPostVO checkWriter(@Param("num")int gopoNum, @Param("id")String me_id);

	boolean updateGroupPost(@Param("num")int gopoNum, @Param("content")String content);

	boolean updateGroupName(@Param("num")int num, @Param("name")String name);

	ArrayList<GroupVO> countGroupListById(@Param("me_id") String me_id);

	ArrayList<GroupCalendarVO> getCalendar(@Param("num")int num);

	boolean insertGroupCal(@Param("num")int num, @Param("newSche")GroupCalendarVO newSch, @Param("user")MemberVO user);

	boolean deleteGroupCal(@Param("num")int calNum);

	boolean quitGroup(@Param("num")int num, @Param("user")MemberVO user);

	ArrayList<GroupApplyVO> getApplyListByGoNum(@Param("num")int num, @Param("cri")Criteria cri);

	int getApplicantTotalCount(@Param("num")int num);

	GroupApplyVO getApplicationByGoap_num(@Param("num")int num);

	boolean insertGroupMember(@Param("num")int goap_go_num, @Param("id")String goap_me_id);

	boolean updateGoap_stateSigned(@Param("num")int num);
	
	boolean updateGoap_stateCanceled(@Param("num")int num);

	ArrayList<GroupMemberVO> getGroupMember(@Param("num")int num, @Param("cri")Criteria cri);
	
	int getGroupMemberTotalCount(@Param("num")int num);

	boolean updateGroupMemberGome_warn(@Param("num")int num, @Param("id")String id);

	boolean updateGroupTimer(@Param("num")int num);

	boolean deleteGroupByGoNum(@Param("num")int num);

	ArrayList<GroupMemberVO> getGroupMemberByGoNum(@Param("num")int num);

	boolean updateGomeStateTo0(@Param("num")int num, @Param("id")String id);
	
	boolean updateGomeStateTo1(@Param("num")int num, @Param("id")String id);

	boolean updateGoUpdate(@Param("num")int num, @Param("freeze")boolean freeze);

	boolean getGoUpdate(@Param("num")int num);

	ArrayList<GroupMemberVO> getNotReviewedMember(@Param("num")int num, @Param("cri")Criteria cri);

	int getNotReviewedMemberTotalCount(@Param("num")int num, @Param("id")String id);

	ArrayList<MutualReviewVO> getReviewedMember(@Param("num")int num,  @Param("id")String id);

	int getReviewedMemberTotalCount(@Param("num")int num,  @Param("id")String id);

}
