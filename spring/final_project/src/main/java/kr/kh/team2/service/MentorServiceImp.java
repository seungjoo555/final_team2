package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.MentorDAO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.pagination.CriteriaMentor;
import kr.kh.team2.utils.Methods;

@Service
public class MentorServiceImp implements MentorService {
	
	@Autowired
	MentorDAO mentorDAO;
	
	Methods methods = new Methods();
	
	@Override
	public ArrayList<MetoringVO> getMentorList(CriteriaMentor cri) {
		if(cri == null) {
			cri = new CriteriaMentor(1, 20);
		}
		if(cri.getJobList() == null || cri.getJobList().size() == 0) {
			cri.setJobList(getJobList());
		}
		return mentorDAO.selectMentorList(cri);
	}

	@Override
	public int getMentorTotalCount(CriteriaMentor cri) {
		if(cri == null) {
			cri = new CriteriaMentor(1, 20);
		}
		if(cri.getJobList() == null || cri.getJobList().size() == 0) {
			cri.setJobList(getJobList());
		}
		return mentorDAO.selectMentorTotalCount(cri);
	}

	@Override
	public ArrayList<MentorJobVO> getJobList() {
		return mentorDAO.selectJobList();
	}

	@Override
	public boolean insertMentorInfo(MentorInfoVO mentorInfoVO) {
		
		
		if(!methods.checkString(mentorInfoVO.getMentIf_me_id())||
		   !methods.checkString(mentorInfoVO.getMentIf_bank())||
		   !methods.checkString(mentorInfoVO.getMentIf_account())||
		   !methods.checkString(mentorInfoVO.getMentIf_ment_job())||
		   !methods.checkString(mentorInfoVO.getMentIf_portfolio())) {
			return false;
		}
		
		return mentorDAO.insertMentorInfo(mentorInfoVO);
		
	}

	@Override
	public boolean checkMentor(String me_id) {
		
		MentorInfoVO dbMentor = mentorDAO.selectMentorInfo(me_id);
		if(dbMentor==null) {
			return true;
		}
		return false;
		
	}

	@Override
	public ArrayList<MetoringVO> getMentoringList(String me_id) {

		return mentorDAO.selectMentoringList(me_id);
	}

	@Override
	public ArrayList<TotalCategoryVO> getMentoCategory(int ment_num, String table2) {
		if(!methods.checkString(table2)) {
			return null;
		}
		
		return mentorDAO.selectMentoCategory(ment_num, table2);
	}


}
