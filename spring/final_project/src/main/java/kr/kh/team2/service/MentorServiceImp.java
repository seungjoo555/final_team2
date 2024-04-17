package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.MentorDAO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.utils.Methods;

@Service
public class MentorServiceImp implements MentorService {
	
	@Autowired
	MentorDAO mentorDAO;
	
	Methods methods = new Methods();

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

}
