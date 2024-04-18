package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.MentoDAO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;

@Service
public class MentoServiceImp implements MentoService {
	@Autowired
	MentoDAO mentoDAO;

	@Override
	public ArrayList<MetoringVO> getMentoList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 20);
		}
//		if(cri.getCateList() != null) {
//			
//		}
		System.out.println("[MentoController] groupList :: " + mentoDAO.selectMentoList(cri));

		return mentoDAO.selectMentoList(cri);
	}

	@Override
	public int getMentoTotalCount(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 20);
		}
		return mentoDAO.selectMentoTotalCount(cri);
	}
	
}
