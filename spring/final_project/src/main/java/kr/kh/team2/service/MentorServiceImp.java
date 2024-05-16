package kr.kh.team2.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.MentorDAO;
import kr.kh.team2.model.dto.MentorInfoDTO;
import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;
import kr.kh.team2.model.vo.member.MentoringApplyVO;
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
	public MentorInfoVO checkMentor(String me_id) {
		
		MentorInfoVO dbMentor = mentorDAO.selectMentorInfo(me_id);
		
		return dbMentor;
		
	}

	@Override
	public MetoringVO getMentoring(int ment_num) {
		if(ment_num <= 0) {
			return null;
		}
		return mentorDAO.selectMentoring(ment_num);
	}

	@Override
	public MentorInfoVO getMentor(String ment_me_id) {
		return mentorDAO.selectMentorInfo(ment_me_id);
	}

	@Override
	public boolean insertMentoringApply(MentoringApplyVO mentoApVO,  MemberVO user) {
		if(	user == null	|| !methods.checkString(user.getMe_id())) {
			return false;}
		//회원 아이디 
		mentoApVO.setMentAp_me_id(user.getMe_id());
		if(mentoApVO == null || !methods.checkString(mentoApVO.getMentAp_me_id()) 
			|| !methods.checkString(mentoApVO.getMentAp_contact())
			|| !methods.checkString(mentoApVO.getMentAp_content())
			) {
			return false;
		}
		if(getMentoring(mentoApVO.getMentAp_ment_num()) == null) {
			return false;
		}
		return mentorDAO.insertMentoringApply(mentoApVO);
	}
	
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
  
	public MentorInfoVO getMentorInfo(String me_id) {
		
		return mentorDAO.selectMentorInfo(me_id);
		
	}

	@Override
	public MetoringVO getMetoring(String me_id) {
		
		return mentorDAO.selectMetoring(me_id);
	}

	@Override
	public ArrayList<ProgrammingCategoryVO> getProgrammingCategory() {
		
		return mentorDAO.selectProgrammingCategoryList();
	}

	@Override
	public boolean insertMentoring(MetoringVO mentoring, TotalCategoryVO toCt) {
		if(!methods.checkString(mentoring.getMent_title())||
		   !methods.checkString(mentoring.getMent_content())||
		   !methods.checkString(mentoring.getMent_duration()+"")||
		   !methods.checkString(mentoring.getMent_me_id())) {
			return false;
		}
		
		
		if(!mentorDAO.insertMentoring(mentoring)) {
			return false;
		}
		
		toCt.setToCt_table_pk(mentoring.getMent_num()+"");
		
		if(!mentorDAO.insertTotalCategory(toCt)) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean updateMentoring(MetoringVO mentoring, TotalCategoryVO toCt) {
		if(!methods.checkString(mentoring.getMent_title())||
		   !methods.checkString(mentoring.getMent_content())||
		   !methods.checkString(mentoring.getMent_duration()+"")||
		   !methods.checkString(mentoring.getMent_me_id())) {
			
			return false;
		}
		
		
		if(!mentorDAO.updateMentoring(mentoring)) {
			return false;
		}
		
		//toCt.setToCt_table_pk(mentoring.getMent_num()+"");
		/*
		if(!mentorDAO.insertTotalCategory(toCt)) {
			return false;
		}
		*/
		return true;
	}


	@Override
	public ArrayList<MentorInfoVO> getMentorInfoList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 10);
		}

		return mentorDAO.selectMentorInfoList(cri);
	}

	@Override
	public int getMentorInfoTotalCount(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 10);
		}
		return mentorDAO.selectMentorInfoTotalCount(cri);
	}

	@Override
	public boolean mentorMultiRequest(MentorInfoDTO mentorInfoDTO) {
		boolean resMentorInfo = false;
		boolean resMentorInfoMember = false;
		if(mentorInfoDTO.getBtnType().equals("accept")) {
			for(String me_id : mentorInfoDTO.getCheckedIds()) {
				resMentorInfo = mentorDAO.mentorInfoAccept(me_id);
				resMentorInfoMember = mentorDAO.updateMemberMentorInfo(me_id);
			}
			return resMentorInfo&&resMentorInfoMember;
		}
		else if(mentorInfoDTO.getBtnType().equals("deny")) {
			for(String me_id : mentorInfoDTO.getCheckedIds()) {
				resMentorInfo = mentorDAO.mentorInfoDeny(me_id);
			}
			return resMentorInfo;
		}
		return false;
		
	}

	@Override
	public boolean mentorRequest(String mentIf_me_id, String btnType) {
		boolean resMentorInfo = false;
		boolean resMentorInfoMember = false;
		if(btnType.equals("accept")) {
			resMentorInfo = mentorDAO.mentorInfoAccept(mentIf_me_id);
			resMentorInfoMember = mentorDAO.updateMemberMentorInfo(mentIf_me_id);
			return resMentorInfo&&resMentorInfoMember;
		}else if(btnType.equals("deny")) {
			resMentorInfo = mentorDAO.mentorInfoDeny(mentIf_me_id);
			return resMentorInfo;
		}
		return false;
		
		
	}

	@Override
	public boolean updateMentorInfoForDenied(MentorInfoVO mentorInfoVO, String me_id) {
		if(!methods.checkString(mentorInfoVO.getMentIf_me_id())||
				   !methods.checkString(mentorInfoVO.getMentIf_bank())||
				   !methods.checkString(mentorInfoVO.getMentIf_account())||
				   !methods.checkString(mentorInfoVO.getMentIf_ment_job())||
				   !methods.checkString(mentorInfoVO.getMentIf_portfolio())) {
					return false;
			}
		
		return mentorDAO.updateMentorInfoForDenied(mentorInfoVO,me_id);
		
	}

	@Override
	public boolean deleteMentoring(Integer mentNum) {
		if(mentNum <= 0) {
			return false;
		}
		return mentorDAO.deleteMentoring(mentNum);
	}

	@Override
	public MentoringApplyVO getMentoringApply(int num, MemberVO user) {
		return mentorDAO.selectMentoringApply(num, user);
	}

	/** 추천 리스트 가져오기 */
	@Override
	public ArrayList<MetoringVO> getHotMentorList() {
		//전체 멘토링 글 가져오기
		ArrayList<MetoringVO> allList = mentorDAO.selectAllMentoring();
		
		if(allList == null) {
			return null;
		}
		
		//추천 리스트 가져오기
		ArrayList<RecommendCountDTO> list = new ArrayList<RecommendCountDTO>();
		
		for(MetoringVO i : allList) {
			RecommendCountDTO recruitCount = recommendDAO.selectRecommendCountList("mentoring", Integer.toString(i.getMent_num()));
			recruitCount.setReco_table("mentoring");
			recruitCount.setReco_target(Integer.toString(i.getMent_num()));
			recruitCount.setRecu_due(mentorDAO.selectDue(recruitCount.getReco_target()));
			System.out.println(recruitCount);
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
		
		//추천순으로 멘토링 가져오기
		ArrayList<MetoringVO> hotList = new ArrayList<MetoringVO>();
		
		System.out.println("list :: "+list);
		if(list.size() > 4) {
			for(int i=0; i<4; i++) {
				hotList.add(mentorDAO.selectMentoringIF(Integer.parseInt(list.get(i).getReco_target())));
			}
		}else {
			for(int i=0; i<list.size(); i++) {
				hotList.add(mentorDAO.selectMentoringIF(Integer.parseInt(list.get(i).getReco_target())));
			}
		}
		
		System.out.println("hotList :: "+hotList);
		
		return hotList;
	}

}
