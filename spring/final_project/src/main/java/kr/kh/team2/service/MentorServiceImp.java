package kr.kh.team2.service;

import java.util.ArrayList;
import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.MentorDAO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.utils.Methods;

@Service
public class MentorServiceImp implements MentorService {
	
	@Autowired
	MentorDAO mentorDAO;
	
	Methods methods = new Methods();
	
	@Override
	public ArrayList<MetoringVO> getMentorList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 20);
		}
		return mentorDAO.selectMentorList(cri);
	}

	@Override
	public int getMentorTotalCount(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 20);
		}
		if(cri.getTypeList() == null || cri.getTypeList().size() == 0) {
			cri.setTypeList(new ArrayList<String>(Arrays.asList("프론트엔드","백엔드","풀스택","프로그래밍 언어","웹개발","데이터베이스","웹 퍼블리싱")));
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

}
