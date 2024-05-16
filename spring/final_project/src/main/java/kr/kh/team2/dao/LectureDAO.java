package kr.kh.team2.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;

public interface LectureDAO {

	ArrayList<LectureVO> selectAllLectureList(@Param("cri") Criteria cri);

	ArrayList<LectureVO> selectLectureList(@Param("cri") Criteria cri, @Param("search") SearchMenuVO search);

	int selectLectureCount(@Param("cri") Criteria cri, @Param("search") SearchMenuVO search);

	LectureVO selectLecture(@Param("lect_num") int lectNum);

	MemberVO selectLecture_Mento(@Param("mentIf_me_id") String lect_mentIf_me_id);

	ArrayList<TotalCategoryVO> selectCategoryList(@Param("num") int lectNum, @Param("table") String table);

	ArrayList<TotalLanguageVO> selectLanguageList(@Param("num") int lectNum, @Param("table") String table);

	ArrayList<ProgrammingCategoryVO> selectProgrammingCategoryList();

	ArrayList<ProgrammingLanguageVO> selectProgrammingLanguageList();

	boolean insertLecture(@Param("lecture")LectureVO lecture);

	boolean insertTotalCate(@Param("toCate")TotalCategoryVO totalCateVo);

	boolean insertTotalLang(@Param("toLang")TotalLanguageVO totalLangVo);

	ArrayList<LectureVO> selectHotLectureList();

	Date selectDue(@Param("lect_num")String reco_target);

}
