package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.common.ReportContentVO;
import kr.kh.team2.model.vo.common.ReportVO;

public interface ReportDAO {

	ArrayList<ReportContentVO> selectReportContentList();

	boolean insertReport(@Param("report") ReportVO reportVO);

}
