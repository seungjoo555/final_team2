
package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.GroupDAO;
import kr.kh.team2.dao.RecruitDAO;
import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class RecruitServiceImp implements RecruitService {
	@Autowired
	private RecruitDAO recruitDao;
	
	@Autowired
	private GroupDAO groupDao;

	private boolean checkString(String str) {
		return str != null && str.length() != 0;
	}
	
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

		group.setGo_name(user.getMe_nickname()+"의 그룹");
		
		boolean makeGroup = recruitDao.insertGroup(group);
		
		if(!makeGroup) {
			return false;
		}
		
		int go_num = group.getGo_num();
		
		boolean makeGroupMember = recruitDao.insertGroupMember(user.getMe_id(), go_num);
	    
	    if (!makeGroupMember) {
	    	return false;
	    }
		
		
		boolean res = recruitDao.insertRecruit(go_num, recruit, user);
		
		if(!res) {
			return false;
		}
		
		return true;
		
	}
	
	@Override
	public boolean insertTotalCate(int recu_num) {
		return false;
	}

	@Override
	public boolean insertTotalLang(int recu_num) {
		return false;
	}
	
	
	@Override
	public boolean insertTotalCate(String progCtList, int recu_num) {
		if(!checkString(progCtList)) {
	        return false;
	    }

		String [] progCt = progCtList.split(",");
		
		
		for(String tmp : progCt) {
			int ct = Integer.parseInt(tmp);
			TotalCategoryVO totalCateVo = new TotalCategoryVO();
			totalCateVo.setToCt_progCt_num(ct);
			totalCateVo.setToCt_table_name("recruit");
			totalCateVo.setToCt_table_pk(""+recu_num);
			boolean res = recruitDao.insertTotalCate(totalCateVo);
			
			if(!res) {
				return false;
			}
		}
		
		return true;
	}


	@Override
	public boolean insertTotalLang(String progLangList, int recu_num) {
		if(!checkString(progLangList)) {
			return false;
		}
		String [] progLang = progLangList.split(",");
		
		
		for(String tmp : progLang) {
			int ct = Integer.parseInt(tmp);
			TotalLanguageVO totalLangVo = new TotalLanguageVO();
			totalLangVo.setToLg_lang_num(ct);
			totalLangVo.setToLg_table_name("recruit");
			totalLangVo.setToLg_table_pk(""+recu_num);
			boolean res = recruitDao.insertTotalLang(totalLangVo);
			
			if(!res) {
				return false;
			}
		}
		
		return true;
	}

	@Override
	public ArrayList<ProgrammingCategoryVO> getProgrammingCategoryList() {
		return recruitDao.selectProgrammingCategoryList();
	}

	@Override
	public ArrayList<ProgrammingLanguageVO> getProgrammingLanguageList() {
		return recruitDao.selectProgrammingLanguageList();
	}



	

}
