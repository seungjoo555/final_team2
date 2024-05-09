package kr.kh.team2.service;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.ReportDAO;
import kr.kh.team2.model.vo.common.ReportContentVO;
import kr.kh.team2.model.vo.common.ReportVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.utils.Methods;

@Service
public class ReportServiceImp implements ReportService{
	
	@Autowired
	ReportDAO reportDAO;
	Methods methods = new Methods();

	@Override
	public ArrayList<ReportContentVO> getReportContentList() {
		return reportDAO.selectReportContentList();
	}

	@Override
	public boolean insertReport(ReportVO reportVO, MemberVO user) {
		if(user == null) {
			return false;
		}
		reportVO.setRepo_me_id(user.getMe_id());
		//현재 시작 가져오기
		Date repo_date = new Date();
		reportVO.setRepo_date(repo_date);
		if(reportVO == null ||
				!methods.checkString(reportVO.getRepo_repo_content()) ||
				!methods.checkString(reportVO.getRepo_detail()) ||
				!methods.checkString(reportVO.getRepo_table()) ||
				!methods.checkString(reportVO.getRepo_target())
				) {
			return false;
		}
		return reportDAO.insertReport(reportVO);
	}

}
