package kr.kh.team2.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.GroupDAO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupApplyVO;
import kr.kh.team2.model.vo.group.GroupCalendarVO;
import kr.kh.team2.model.vo.group.GroupPostVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;
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
	public ArrayList<GroupVO> getGroupListById(String me_id, Criteria cri) {
		if(!methods.checkString(me_id)) {
			System.out.println("wrong id: "+me_id);
			return null;
		}else if(cri == null) {
			System.out.println("null cri");
			return null;
		}
		
		return groupDao.getGroupListById(me_id, cri);
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
		if (me_id == null || me_id.isEmpty()) {
			return null;
		}
		
		ArrayList<GroupVO> groupList = groupDao.selectStudyGroupList(me_id);
		
		// 각 그룹의 가입 멤버 수
        for (GroupVO group : groupList) {
            int go_num = group.getGo_num();
            int memberCount = groupDao.selectGroupMemberCount(go_num);
            group.setGo_member_count(memberCount);
        }
		
		return groupList;
	}

	@Override
	public ArrayList<GroupVO> getStudyApplyList(String me_id) {
		if (me_id == null || me_id.isEmpty()) {
			return null;
		}
		
		ArrayList<GroupVO> groupApplyList = groupDao.getStudyApplyList(me_id);
		
		// 각 그룹의 가입 멤버 수
        for (GroupVO group : groupApplyList) {
            int go_num = group.getGo_num();
            int memberCount = groupDao.selectGroupMemberCount(go_num);
            group.setGo_member_count(memberCount);
        }
        
		return groupApplyList;
	}
  
	public ArrayList<GroupPostVO> getGroupPostByGoNum(int groupNum, Criteria cri) {
		if(groupNum == 0 ) {
			System.out.println("groupNum is 0");
			return null;
		}else if(cri == null) {
			System.out.println("null cri");
			return null;
		}
		
		return groupDao.getGroupPostByGoNum(groupNum, cri);
	}

	@Override
	public boolean insertGroupPost(int goNum, String  writer, String content) {
		if(goNum == 0 ) {
			System.out.println("groupNum is 0");
			return false;
		}else if(!methods.checkString(content) || !methods.checkString(writer)) {
			System.out.println("invalid content or writer: "+ content + ", " + writer);
			return false;
		}
		
		// 권한 확인 필요
		MemberVO tmp = new MemberVO(writer);
		
		if(!isGroupMember(tmp, goNum)) {
			System.out.println("not group member");
			return false;
		}else {
			return groupDao.insertGroupPost(goNum, writer, content);
		}
		
	}

	@Override
	public int getMyGroupTotalCount(String me_id) {
		if(!methods.checkString(me_id)) {
			System.out.println("wrong id: "+me_id);
			return -1;
		}
		return groupDao.getMyGroupTotalCount(me_id);
	}

	@Override
	public int getGroupPostTotalCount(int goNum) {
		if(goNum == 0 ) {
			System.out.println("groupNum is 0");
			return -1;
		}
		return groupDao.getGroupPostTotalCount(goNum);
	}

	@Override
	public boolean deleteGroupPost(int gopoNum, MemberVO user) {
		if(gopoNum == 0 ) {
			System.out.println("gopoNum is 0");
			return false;
		}else if(user == null){
			System.out.println("null user");
			return false;
		}
		
		GroupPostVO post = getGroupPostByGopoNum(gopoNum);
		
		if(post == null) {
			System.out.println("no post with gopoNum: "+gopoNum);
			return false;
		}
		
		if(!post.getGopo_gome_me_id().equals(user.getMe_id())) {
			System.out.println("not writer or authorized");
			return false;
		}
		
		return groupDao.deleteGroupPost(gopoNum);
	}
	
	@Override
	public GroupPostVO getGroupPostByGopoNum(int gopoNum) {
		return groupDao.getGroupPostByGopoNum(gopoNum);
	}

	@Override
	public boolean updateGroupPost(int gopoNum, String content, MemberVO user) {
		if(gopoNum == 0 ) {
			System.out.println("gopoNum is 0");
			return false;
		}
		if(!methods.checkString(content) ) {
			System.out.println("null content: " + content );
			return false;
		}
		if(user == null) {
			System.out.println("null user");
			return false;
		}
		
		// 현재 로그인한 유저가 게시글의 작성자인지 확인함
		if(groupDao.checkWriter(gopoNum, user.getMe_id()) == null) {
			System.out.println("not identical writer");
			return false;
		}
		
		return groupDao.updateGroupPost(gopoNum, content);
	}

	@Override
	public boolean updateGroupName(int num, String name, MemberVO user) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return false;
		}
		if(!methods.checkString(name)) {
			System.out.println("name is invalid: "+name);
			return false;
		}
		if(user == null) {
			System.out.println("null user");
			return false;
		}
		
		GroupVO tmp = getGroupByGoNum(num);
		
		if(!tmp.getLeader().equals(user.getMe_id())) {
			System.out.println("not group leader user");
			return false;
		}
		
		return groupDao.updateGroupName(num, name);
	}

	@Override
	public ArrayList<GroupVO> countGroupListById(String me_id) {
		if(!checkString(me_id)) {
			return null;
		}		
		return groupDao.countGroupListById(me_id);
}
  @Override
	public ArrayList<GroupCalendarVO> getCalendar(int num) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return null;
		}
		return groupDao.getCalendar(num);
	}

	@Override
	public boolean insertGroupCal(int num, GroupCalendarVO newSch, MemberVO user) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return false;
		}
		if(newSch == null) {
			System.out.println("null schedule");
			return false;
		}
		if(user == null) {
			System.out.println("null user");
			return false;
		}
		
		// 로그인 한 유저가 멤버인지 확인함(후에 writer로 변경)
		if(!isGroupMember(user, num)) {
			System.out.println("not group member");
			return false;
		}
		
		return groupDao.insertGroupCal(num, newSch, user);
		
	}

	@Override
	public boolean deleteGroupCal(int num, int calNum, MemberVO user) {
		if(calNum == 0) {
			System.out.println("calNum is 0");
			return false;
		}
		if(user == null) {
			System.out.println("null user");
			return false;
		}
		
		// 로그인 한 유저가 멤버인지 확인함
		if(!isGroupMember(user, num)) {
			System.out.println("not group member");
			return false;
		}
		
		return groupDao.deleteGroupCal(calNum);
	}

	@Override
	public boolean quitGroup(int num, MemberVO user) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return false;
		}
		if(user == null) {
			System.out.println("null user");
			return false;
		}
		
		return groupDao.quitGroup(num, user);
	}

	@Override
	public ArrayList<GroupApplyVO> getApplyListByGoNum(int num, Criteria cri) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return null;
		}
		if(cri == null) {
			System.out.println("null cri");
			return null;
		}
		
		return groupDao.getApplyListByGoNum(num, cri);
	}

	@Override
	public ArrayList<GroupVO> getGroupListByRecuNum(int num) {
		if(num == 0) {
			return null;
		}	
		return groupDao.selectGroupListByGoNum(num);
	}

	@Override
	public boolean insertGroupApply(GroupVO group, int recu_num, GroupApplyVO goapVo, MemberVO user) {
		if(recu_num == 0) {
			return false;
		}
		
		if(group == null || goapVo == null || user == null) {
			return false;
		}
		
		return groupDao.insertGroupApply(group, recu_num, goapVo, user);
	}
	public int getApplicantTotalCount(int num) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return -1;
		}
		
		return groupDao.getApplicantTotalCount(num);
	}

	@Override
	public boolean insertGroupMember(MemberVO user, int num) {
		if(num == 0) {
			System.out.println("num is 0");
			return false;
		}
		
		GroupVO tmp = getGroupByGoNum(num);
		
		if(!tmp.getLeader().equals(user.getMe_id())) {
			System.out.println("not group leader user");
			return false;
		}
		
		GroupApplyVO application = groupDao.getApplicationByGoap_num(num);
		
		if(application == null) {
			System.out.println("no application");
			return false;
		}
		
		return groupDao.updateGoap_stateSigned(num) 
				&& groupDao.insertGroupMember(application.getGoap_go_num(), application.getGoap_me_id());
	}

	@Override
	public boolean cancelApply(MemberVO user, int num) {
		if(num == 0) {
			System.out.println("num is 0");
			return false;
		}
		
		GroupVO tmp = getGroupByGoNum(num);
		
		if(!tmp.getLeader().equals(user.getMe_id())) {
			System.out.println("not group leader user");
			return false;
		}
		
		GroupApplyVO application = groupDao.getApplicationByGoap_num(num);
		
		if(application == null) {
			System.out.println("no application");
			return false;
		}
		
		return groupDao.updateGoap_stateCanceled(num);
	}

	@Override
	public ArrayList<GroupApplyVO> getGroupMember(int num, Criteria cri) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return null;
		}
		if(cri == null) {
			System.out.println("null cri");
			return null;
		}
		
		return groupDao.getGroupMember(num, cri);
	}

	@Override
	public int getGroupMemberTotalCount(int num) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return -1;
		}
		
		return groupDao.getGroupMemberTotalCount(num);
	}

	@Override
	public boolean updateGroupMemberGome_warn(int num, String id) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return false;
		}
		if(!methods.checkString(id)) {
			System.out.println("invalid id");
			return false;
		}
		
		MemberVO user = new MemberVO(id);
		
		if(!isGroupMember(user, num)){
			System.out.println("not group member");
			return false;
		}
		
		return groupDao.updateGroupMemberGome_warn(num, id);
	}

	@Override
	public boolean deleteGroupMember(int num, String id) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return false;
		}
		if(!methods.checkString(id)) {
			System.out.println("invalid id");
			return false;
		}
		
		MemberVO user = new MemberVO(id);
		
		if(!isGroupMember(user, num)){
			System.out.println("not group member");
			return false;
		}
		
		return groupDao.quitGroup(num, user);
	}

	@Override
	public boolean updateGroupTimer(int num, MemberVO user) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return false;
		}
		if(user == null) {
			System.out.println("null user");
			return false;
		}
		
		GroupVO tmp = getGroupByGoNum(num);
		
		if(!tmp.getLeader().equals(user.getMe_id())) {
			System.out.println("not group leader user");
			return false;
		}
		
		return groupDao.updateGroupTimer(num);
	}

	@Override
	public boolean deleteGroupByGoNum(int num, MemberVO user) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return false;
		}
		if(user == null) {
			System.out.println("null user");
			return false;
		}
		
		GroupVO tmp = getGroupByGoNum(num);
		
		if(!tmp.getLeader().equals(user.getMe_id())) {
			System.out.println("not group leader user");
			return false;
		}
		
		
		return groupDao.deleteGroupByGoNum(num);
	}

	
}
