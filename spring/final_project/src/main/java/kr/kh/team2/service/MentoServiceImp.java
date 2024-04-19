package kr.kh.team2.service;

import java.util.ArrayList;
import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.MentoDAO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;
import lombok.extern.log4j.Log4j;

@Log4j
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
		if(cri.getTypeList() == null || cri.getTypeList().size() == 0) {
			cri.setTypeList(new ArrayList<String>(Arrays.asList("프론트엔드","백엔드","풀스택","프로그래밍 언어","웹개발","데이터베이스","웹 퍼블리싱")));
		}
		System.out.println("멘토 리스트" + mentoDAO.selectMentoTotalCount(cri));
		return mentoDAO.selectMentoTotalCount(cri);
	}
	
}
