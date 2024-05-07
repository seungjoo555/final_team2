package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.dto.ReportSimpleDTO;
import kr.kh.team2.model.vo.common.ReportContentVO;
import kr.kh.team2.model.vo.common.ReportVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;

public interface ReportService {

	ArrayList<ReportContentVO> getReportContentList();

	boolean insertReport(ReportVO reportVO, MemberVO user);

	ArrayList<ReportSimpleDTO> gerRepoertSimple(Criteria cri);

	int gerRepoertSimpleCount(Criteria cri);

	String setRepoTableStr(String repo_table);

	String setTargetStr(ReportSimpleDTO reportSimpleDTO);

	ArrayList<ReportVO> getReportList(String repo_target, String repo_table);




}
