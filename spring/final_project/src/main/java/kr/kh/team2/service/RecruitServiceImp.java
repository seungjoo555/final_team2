
package kr.kh.team2.service;

import java.util.concurrent.RecursiveAction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.RecruitDAO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class RecruitServiceImp implements RecruitService {
	@Autowired
	private RecruitDAO recruitDao;

	@Override
	public boolean insertRecruit(GroupVO group, RecruitVO recruit, MemberVO user) {
		if (recruit == null || recruit.getRecu_topic() == null || recruit.getRecu_content() == null
			|| recruit.getRecu_target() == null || recruit.getRecu_required() == null || recruit.getRecu_due() == null 
			|| recruit.getRecu_preferred() == null) {
			return false;
		}
		
		if (user == null) {
			return false;
		}

		group.setGo_name(user.getMe_id()+"의 그룹");
		
		boolean makeGroup = recruitDao.insertGroup(group);
		
		if(!makeGroup) {
			return false;
		}
		
		int go_num = group.getGo_num();
		
		boolean res = recruitDao.insertRecruit(go_num, recruit, user);
		
		if(!res) {
			return false;
		}
		return true;
		
	}

}
