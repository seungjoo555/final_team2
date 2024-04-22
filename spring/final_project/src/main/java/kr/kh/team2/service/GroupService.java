package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupCalendarVO;
import kr.kh.team2.model.vo.group.GroupPostVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface GroupService {

	ArrayList<GroupVO> getGroupListById(String me_id);

	GroupVO getGroupByGoNum(int groupNum);

	boolean isGroupMember(MemberVO user, int groupNum);

	RecruitVO getRecruit(int num);

	MemberVO getGroupKing(int recu_go_num);

	ArrayList<TotalCategoryVO> getCategory(int num, String table);

	ArrayList<TotalLanguageVO> getLanguage(int num, String table);

	ArrayList<GroupPostVO> getRecentGroupBoard(int groupNum, int recentBoard);

	ArrayList<GroupCalendarVO> getDday(int groupNum, int dday);

	long getGroupTime(int groupNum);

	boolean updateGoTime(int goNum);

	long getGoTimeByGoNum(int goNum);

}
