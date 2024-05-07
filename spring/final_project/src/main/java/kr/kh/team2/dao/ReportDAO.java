package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.dto.ReportSimpleDTO;
import kr.kh.team2.model.vo.common.ReportContentVO;
import kr.kh.team2.model.vo.common.ReportVO;
import kr.kh.team2.pagination.Criteria;

public interface ReportDAO {

	ArrayList<ReportContentVO> selectReportContentList();

	boolean insertReport(@Param("report") ReportVO reportVO);

	ArrayList<ReportSimpleDTO> selectReportSimpleList(@Param("cri")Criteria cri);

	int selectReportSimpleTotalCount(@Param("cri")Criteria cri);

	ArrayList<ReportVO> selectReportList(@Param("repo_table")String repo_table, @Param("repo_target")String repo_target);

}
