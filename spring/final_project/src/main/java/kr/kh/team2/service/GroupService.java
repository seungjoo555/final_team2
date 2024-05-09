package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupApplyVO;
import kr.kh.team2.model.vo.group.GroupCalendarVO;
import kr.kh.team2.model.vo.group.GroupMemberVO;
import kr.kh.team2.model.vo.group.GroupPostVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;


public interface GroupService {

	ArrayList<RecruitVO> getGroupList(Criteria cri);

	int getGroupTotalCount(Criteria cri);

	ArrayList<GroupVO> getGroupListById(String me_id, Criteria cri);

	GroupVO getGroupByGoNum(int groupNum);

	boolean isGroupMember(MemberVO user, int groupNum);

	RecruitVO getRecruit(int num);

	MemberVO getGroupKing(int recu_go_num);

	ArrayList<TotalCategoryVO> getCategory(int num, String table);

	ArrayList<TotalLanguageVO> getLanguage(int num, String table);

	ArrayList<GroupPostVO> getRecentGroupBoard(int groupNum, int recentBoard);

	long getGroupTime(int groupNum);

	boolean updateGoTime(int goNum);

	long getGoTimeByGoNum(int goNum);

	ArrayList<GroupVO> getStudyGroupList(String me_id);

	ArrayList<GroupVO> getStudyApplyList(String me_id);
  
	ArrayList<GroupPostVO> getGroupPostByGoNum(int groupNum, Criteria cri);

	boolean insertGroupPost(int goNum, String  writer, String content);

	int getMyGroupTotalCount(String me_id);

	int getGroupPostTotalCount(int goNum);

	boolean deleteGroupPost(int gopoNum, MemberVO user);
	
	 GroupPostVO getGroupPostByGopoNum(int gopoNum);

	boolean updateGroupPost(int gopoNum, String content, MemberVO user);

	boolean updateGroupName(int num, String name, MemberVO user);


	ArrayList<GroupVO> countGroupListById(String me_id);

	String getGroupLeaderID(int parseInt);
	ArrayList<GroupCalendarVO> getCalendar(int num);

	boolean insertGroupCal(int num, GroupCalendarVO newSch, MemberVO user);

	boolean deleteGroupCal(int num, int calNum, MemberVO user);

	boolean quitGroup(int num, MemberVO user);

	ArrayList<GroupApplyVO> getApplyListByGoNum(int num, Criteria cri);

	int getApplicantTotalCount(int num);

	boolean insertGroupMember(MemberVO user, int num, int apNum);

	boolean cancelApply(MemberVO user, int num, int apNum);

	ArrayList<GroupMemberVO> getGroupMember(int num, Criteria cri);

	int getGroupMemberTotalCount(int num);

	boolean updateGroupMemberGome_warn(int num, String id);

	boolean deleteGroupMember(int num, String id);

	boolean updateGroupTimer(int num, MemberVO user);

	boolean deleteGroupByGoNum(int num, MemberVO user);


	ArrayList<GroupVO> getGroupListByRecuNum(int num);

	boolean insertGroupApply(GroupVO group, int num, GroupApplyVO goapVo, MemberVO user);

	GroupApplyVO getGroupApply(Integer num, MemberVO user);

	boolean updateGroupApply(GroupVO group, int recu_num, GroupApplyVO goapVo, MemberVO user);

	boolean changeGroupLeader(int num, String id, MemberVO user);

	boolean updateGoUpdate(int num, boolean freeze, MemberVO user);



}
