package kr.kh.team2.service;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.LectureDAO;
import kr.kh.team2.dao.MentorDAO;
import kr.kh.team2.dao.RecruitDAO;
import kr.kh.team2.dao.ReportDAO;
import kr.kh.team2.model.dto.ReportSimpleDTO;
import kr.kh.team2.model.vo.common.ReportContentVO;
import kr.kh.team2.model.vo.common.ReportVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.utils.Methods;

@Service
public class ReportServiceImp implements ReportService{
	
	@Autowired
	ReportDAO reportDAO; 
	@Autowired
	RecruitDAO recruitDAO; 
	@Autowired
	MentorDAO mentorDAO; 
	@Autowired
	LectureDAO lectureDAO;
	
	Methods methods = new Methods();

	/** 신고 유형 리스트를 반환하는 서비스*/
	@Override
	public ArrayList<ReportContentVO> getReportContentList() {
		return reportDAO.selectReportContentList();
	}

	/** 신고 성공여부를 반환하는 서비스*/
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

	/** 신고 테이블과 신고 타겟이 동일한 신고 리스트를 반환하는 서비스*/
	@Override
	public ArrayList<ReportSimpleDTO> gerRepoertSimple(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 10);
		}
		return reportDAO.selectReportSimpleList(cri);
	}

	/** 신고 테이블과 신고 타겟이 동일한 신고 리스트 개수를 반환하는 서비스*/
	@Override
	public int gerRepoertSimpleCount(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1, 10);
		}
		return reportDAO.selectReportSimpleTotalCount(cri);
	}

	/** 신고 대상 테이블 이름을 지정하는 서비스*/
	@Override
	public String setRepoTableStr(String repo_table) {
		String str="";
    	
    	if(repo_table.equals("recruit")) {str = "모집공고";}
    	else if(repo_table.equals("mentoring")) {str = "멘토링";}
    	else if(repo_table.equals("lecture")) {str = "강의";}
    	else if(repo_table.equals("member")) {str = "유저";}
    	else if(repo_table.equals("post")) {str = "게시글";}
    	else if(repo_table.equals("comment")) {str = "댓글";}
    	else {str = repo_table;}
    	
    	return str;
	}

	/** 신고 대상 테이블 대상을 가져오는 서비스*/
	@Override
	public String setTargetStr(ReportSimpleDTO reportSimpleDTO) {
		String target="";
		if(reportSimpleDTO == null)
			return null;
		
		if(reportSimpleDTO.getRepo_table().equals("recruit")) {
			target = recruitDAO.selectTopic(Integer.parseInt(reportSimpleDTO.getRepo_target()));
		}else if(reportSimpleDTO.getRepo_table().equals("mentoring")) {
			target = mentorDAO.selectMentoring(Integer.parseInt(reportSimpleDTO.getRepo_target())).getMent_title();
		}else if(reportSimpleDTO.getRepo_table().equals("lecture")) {
			target = lectureDAO.selectLecture(Integer.parseInt(reportSimpleDTO.getRepo_target())).getLect_name();
		}else if(reportSimpleDTO.getRepo_table().equals("member")) {
			target =reportSimpleDTO.getRepo_target();
		}
    	else {target = reportSimpleDTO.getRepo_table();}
		
		return target;
	}

	/** 신고테이블, 타켓 정보로 신고 테이블 리스트를 가져오는 서비스 */
	@Override
	public ArrayList<ReportVO> getReportList(String repo_target, String repo_table) {
		if(!methods.checkString(repo_table) || !methods.checkString(repo_target)) 
			return null;
		
		return reportDAO.selectReportList(repo_table, repo_target);
	}

	/** 신고 상태를 업데이트 하는 서비스 */
	@Override
	public void reportStateProcess(String repo_target, String repo_table, String state) {
		if(!methods.checkString(repo_table) || !methods.checkString(repo_target)) 
			return;
		reportDAO.updateReportState(repo_table, repo_target, state);
	}

	/** 신고 여부를 가져오는 서비스 : true=신고가능, false=신고불가능 */
	@Override
	public boolean getReportIsTrue(String repo_target, String repo_table, String me_id) {
		if(!methods.checkString(repo_table) || !methods.checkString(repo_target) || !methods.checkString(me_id)) 
			return false;	//신고불가능
		
		ReportVO report = reportDAO.selectReportIsTrue(repo_table, repo_target, me_id);
		
		//만약 신고여부가 있다면 
		if(report != null) {
			//신고 불가능
			return false;
		}
		return true;
	}

}
