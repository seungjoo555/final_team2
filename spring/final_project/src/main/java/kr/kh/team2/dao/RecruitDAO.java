package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface RecruitDAO {

	boolean insertGroup(@Param("group")GroupVO group);
	
	boolean insertRecruit(@Param("group")int go_num, @Param("recruit")RecruitVO recruit, @Param("user")MemberVO user);

	boolean insertTotalCate(@Param("totalCate")TotalCategoryVO totalCate);
	
	boolean insertTotalLang(@Param("totalLang")TotalLanguageVO totalLang);
	
	ArrayList<ProgrammingCategoryVO> selectProgrammingCategoryList();

	ArrayList<ProgrammingLanguageVO> selectProgrammingLanguageList();




	
}
