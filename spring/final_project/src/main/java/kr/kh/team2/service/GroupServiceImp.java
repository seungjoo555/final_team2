package kr.kh.team2.service;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.kh.team2.dao.GroupDAO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupCalendarVO;
import kr.kh.team2.model.vo.group.GroupPostVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.utils.Methods;

@Service
public class GroupServiceImp implements GroupService{
	private Methods methods = new Methods();
	
	@Autowired
	GroupDAO groupDao;

	@Override
	public ArrayList<RecruitVO> getGroupList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 20);
		}
		return groupDao.selectGroupList(cri);
	}

	@Override
	public int getGroupTotalCount(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 20);
		}
		System.out.println("게시글 토탈 카운트"+groupDao.selectGroupTotalCount(cri));
		return groupDao.selectGroupTotalCount(cri);
	}

  private boolean checkString(String str) {
		return str != null && str.length() != 0;
	}

	@Override
	public RecruitVO getRecruit(int num) {
		return groupDao.selectRecruit(num);
	}

	@Override
	public MemberVO getGroupKing(int recu_go_num) {
		return groupDao.selectGroupKing(recu_go_num);
	}

	@Override
	public ArrayList<TotalCategoryVO> getCategory(int num, String table) {
		if(!checkString(table)) {
			return null;
		}
		return groupDao.selectCategoryList(num, table);
	}

	@Override
	public ArrayList<TotalLanguageVO> getLanguage(int num, String table) {
		if(!checkString(table)) {
			return null;
		}
		return groupDao.selectLanguageList(num, table);
	}
  
	@Override
	public ArrayList<GroupVO> getGroupListById(String me_id) {
		if(!methods.checkString(me_id)) {
			return null;
		}
		
		return groupDao.getGroupListById(me_id);
	}

	@Override
	public GroupVO getGroupByGoNum(int groupNum) {
		if(groupNum == 0) {
			System.out.println("groupNum is 0");
			return null;
		}
			
		return groupDao.getGroupByGoNum(groupNum);
	}

	@Override
	public boolean isGroupMember(MemberVO user, int groupNum) {
		if(user == null) {
			System.out.println("null user");
			return false;
		}else if(groupNum == 0) {
			System.out.println("groupNum is 0");
			return false;
		}
		
		if(groupDao.isGroupMember(user.getMe_id(), groupNum) == null)
			return false;
		else
			return true;
	}

	@Override
	public ArrayList<GroupPostVO> getRecentGroupBoard(int groupNum, int recentBoard) {
		if(groupNum == 0 || recentBoard == 0) {
			System.out.println("groupNum is or count 0");
			return null;
		}
		
		return groupDao.getRecentGroupBoard(groupNum, recentBoard);
	}

	@Override
	public ArrayList<GroupCalendarVO> getDday(int groupNum, int dday) {
		if(groupNum == 0 || dday == 0) {
			System.out.println("groupNum  or count is 0");
			return null;
		}
		return groupDao.getDday(groupNum, dday);
	}

	@Override
	public long getGroupTime(int groupNum) {
		if(groupNum == 0 ) {
			System.out.println("groupNum is 0");
			return -1;
		}
		return groupDao.getGroupTime(groupNum);
	}

	@Override
	public boolean updateGoTime(int groupNum) {
		if(groupNum == 0 ) {
			System.out.println("groupNum is 0");
			return false;
		}
		return groupDao.updateGoTime(groupNum);
	}

	@Override
	public long getGoTimeByGoNum(int groupNum) {
		if(groupNum == 0 ) {
			System.out.println("groupNum is 0");
			return -1;
		}
		
		return groupDao.getGroupTime(groupNum);
	}

	@Override
	public ArrayList<GroupVO> getStudyGroupList(String me_id) {
		if (me_id == null) {
			return null;
		}
		
		return groupDao.selectStudyGroupList(me_id);
	}
	
}
