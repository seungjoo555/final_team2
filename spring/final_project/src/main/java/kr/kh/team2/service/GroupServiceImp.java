package kr.kh.team2.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.GroupDAO;
import kr.kh.team2.dao.RecommendDAO;
import kr.kh.team2.model.dto.MutualReviewDTO;
import kr.kh.team2.model.dto.RecommendCountDTO;
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
import kr.kh.team2.utils.Methods;

@Service
public class GroupServiceImp implements GroupService{
	private Methods methods = new Methods();
	
	@Autowired
	GroupDAO groupDao;
	@Autowired
	RecommendDAO recommendDAO;

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
		
		if(!groupDao.getGoUpdate(groupNum)) {
			System.out.println("frozen group");
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
			if(!groupDao.getGoUpdate(goNum)) {
				System.out.println("frozen group");
				return false;
			}
			
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
		if(!groupDao.getGoUpdate(num)) {
			System.out.println("frozen group");
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
		if(!groupDao.getGoUpdate(num)) {
			System.out.println("frozen group");
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
		if(!groupDao.getGoUpdate(num)) {
			System.out.println("frozen group");
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
	public boolean insertGroupMember(MemberVO user, int num, int apNum) {
		if(num == 0 || apNum == 0) {
			System.out.println("num is 0");
			System.out.println("num: "+num);
			System.out.println("apNum: "+apNum);
			return false;
		}
		if(!groupDao.getGoUpdate(num)) {
			System.out.println("frozen group");
			return false;
		}
		
		GroupVO tmp = getGroupByGoNum(num);
		
		if(!tmp.getLeader().equals(user.getMe_id())) {
			System.out.println("not group leader user");
			return false;
		}
		
		GroupApplyVO application = groupDao.getApplicationByGoap_num(apNum);
		
		if(application == null) {
			System.out.println("no application");
			return false;
		}
		
		return groupDao.updateGoap_stateSigned(apNum) 
				&& groupDao.insertGroupMember(application.getGoap_go_num(), application.getGoap_me_id());
	}

	@Override
	public boolean cancelApply(MemberVO user, int num, int apNum) {
		if(num == 0) {
			System.out.println("num is 0");
			return false;
		}
		if(!groupDao.getGoUpdate(num)) {
			System.out.println("frozen group");
			return false;
		}
		
		GroupVO tmp = getGroupByGoNum(num);
		
		if(!tmp.getLeader().equals(user.getMe_id())) {
			System.out.println("not group leader user");
			return false;
		}
		
		GroupApplyVO application = groupDao.getApplicationByGoap_num(apNum);
		
		if(application == null) {
			System.out.println("no application");
			return false;
		}
		
		return groupDao.updateGoap_stateCanceled(apNum);
	}

	@Override
	public ArrayList<GroupMemberVO> getGroupMember(int num, Criteria cri) {
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
		if(!groupDao.getGoUpdate(num)) {
			System.out.println("frozen group");
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
		if(!groupDao.getGoUpdate(num)) {
			System.out.println("frozen group");
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
		if(!groupDao.getGoUpdate(num)) {
			System.out.println("frozen group");
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


	@Override
	public GroupApplyVO getGroupApply(Integer num, MemberVO user) {
		if(num == 0 || user == null) {
			return null;
		}	
		return groupDao.selectGroupApply(num, user);
	}

	@Override
	public boolean updateGroupApply(GroupVO group, int recu_num, GroupApplyVO goapVo, MemberVO user) {
		if(group == null || recu_num == 0 || goapVo == null || user == null) {
			return false;
		}
		
		// 작성자가 맞는지 확인
		GroupApplyVO goap = groupDao.selectGroupApply(recu_num, user);
		
		if(goap == null || !goap.getGoap_me_id().equals(user.getMe_id())) {
			return false;
		}
		
		boolean res = groupDao.updateGroupApply(goapVo, goap, user);
		
		if(!res) {
			return false;
		}
			
		return true;
	}


  @Override
	public boolean changeGroupLeader(int num, String id, MemberVO user) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return false;
		}
		if(user == null) {
			System.out.println("null user");
			return false;
		}
		if(!methods.checkString(id)) {
			System.out.println("invalid id");
			return false;
		}
		if(!groupDao.getGoUpdate(num)) {
			System.out.println("frozen group");
			return false;
		}
		
		
		GroupVO tmpGroup = getGroupByGoNum(num);
		
		if(!tmpGroup.getLeader().equals(user.getMe_id())) {
			System.out.println("not group leader user");
			return false;
		}
		
		MemberVO tmpMember = new MemberVO(id);
		
		if(!isGroupMember(tmpMember, num)) {
			System.out.println("not group member user id");
			return false;
		}
		
		return groupDao.updateGomeStateTo0(num, user.getMe_id()) && groupDao.updateGomeStateTo1(num, id);
	}

	@Override
	public boolean updateGoUpdate(int num, boolean freeze, MemberVO user) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return false;
		}
		if(user == null) {
			System.out.println("null user");
			return false;
		}
		
		GroupVO tmpGroup = getGroupByGoNum(num);
		
		if(!tmpGroup.getLeader().equals(user.getMe_id())) {
			System.out.println("not group leader user");
			return false;
		}
		
		return groupDao.updateGoUpdate(num, freeze);
	}

	@Override
	public ArrayList<GroupMemberVO> getNotReviewedMember(int num, Criteria cri) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return null;
		}
		if(cri == null) {
			System.out.println("null cri");
			return null;
		}
		
		return groupDao.getNotReviewedMember(num, cri);
	}

	@Override
	public int getNotReviewedMemberTotalCount(int num, String id) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return -1;
		}
		if(!methods.checkString(id)) {
			System.out.println("invalid id");
			return -1;
		}
		
		return groupDao.getNotReviewedMemberTotalCount(num, id);
	}

	@Override
	public ArrayList<MutualReviewVO> getReviewedMember(int num, Criteria cri) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return null;
		}
		if(cri == null) {
			System.out.println("null cri");
			return null;
		}
		
		return groupDao.getReviewedMember(num, cri);
	}

	@Override
	public int getReviewedMemberTotalCount(int num, String id) {
		if(num == 0) {
			System.out.println("goNum is 0");
			return -1;
		}
		if(!methods.checkString(id)) {
			System.out.println("invalid id");
			return -1;
		}
		
		return groupDao.getReviewedMemberTotalCount(num, id);
	}

	/** 그룹 리더 아이디를 가져오는 서비스*/
	@Override
	public String getGroupLeaderID(int recu_num) {
		if(recu_num <= 0) {
			return null;
		}
		return groupDao.selectGroupLeaderID(recu_num);
	}

	@Override
	public boolean insertMutualReview(MutualReviewDTO mutualReviewDto, MemberVO user) {
		if(mutualReviewDto == null) {
			System.out.println("null DTO");
			return false;
		}
		if(groupDao.isGroupMember(user.getMe_id(), mutualReviewDto.getNum()) == null) {
			System.out.println("not group member");
			return false;
		}
		
		// 매너온도 계산
		float degree;
		int rate = mutualReviewDto.getRate();
		
		if(rate>5) {
			// 5점 이상이면 매너 온도 상승
			degree = rate / 2;
		}else {
			// 5점 이하면 매너 온도 하락
			degree = -(rate / 2);
		}
		
		return groupDao.insertMutualReview(mutualReviewDto) && groupDao.updateMeDgree(mutualReviewDto.getTarget_id(), degree);
	}

	@Override
	public Object isReviewedMember(MutualReviewDTO mutualReviewDto) {
		if(mutualReviewDto == null) {
			System.out.println("null DTO");
			return false;
		}
		
		return groupDao.isReviewedMember(mutualReviewDto);
	}

	/** 추천 순 그룹 리스트 가져오는 서비스 */
	@Override
	public ArrayList<RecruitVO> getHotGroupList() {
		//그룹 전체 리스트 가져오기
		ArrayList<RecruitVO> AllList = groupDao.selectRecruitList();
		if(AllList == null) {
			return null;
		}
		
		//추천 리스트 가져오기
		ArrayList<RecommendCountDTO> list = new ArrayList<RecommendCountDTO>();
		
		for(RecruitVO i : AllList) {
			RecommendCountDTO recruitCount = recommendDAO.selectRecommendCountList("recruit", Integer.toString(i.getRecu_num()));
			recruitCount.setReco_table("recruit");
			recruitCount.setReco_target(Integer.toString(i.getRecu_num()));
			recruitCount.setRecu_due(groupDao.selectDue(recruitCount.getReco_target()));
			list.add(recruitCount);
		}
		
		//추천순으로 자르기
		Collections.sort(list, new Comparator<RecommendCountDTO>() {
			@Override
			public int compare(RecommendCountDTO o1, RecommendCountDTO o2) {
				//만약 추천수가 같다면
				if(o2.getCount() - o1.getCount() == 0) {
					//최신순으로 정렬
					return o2.getRecu_due().compareTo(o1.getRecu_due());
				}
				return o2.getCount() - o1.getCount();
			}
		});
		
		//추천순으로 그룹 가져오기
		ArrayList<RecruitVO> hotList = new ArrayList<RecruitVO>();
		
		if(list.size() > 4) {
			for(int i=0; i<4; i++) {
				hotList.add(groupDao.selectHotGroupList(list.get(i).getReco_target())) ;
			}
		}else {
			for(int i=0; i<list.size(); i++) {
				hotList.add(groupDao.selectHotGroupList(list.get(i).getReco_target())) ;
			}
		}
		
		return hotList;
	}
	
}
