package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.common.ReportContentVO;
import kr.kh.team2.model.vo.common.ReportVO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface ReportService {

	ArrayList<ReportContentVO> getReportContentList();

	boolean insertReport(ReportVO reportVO, MemberVO user);

}
