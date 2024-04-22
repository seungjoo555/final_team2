package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface RecruitService {

	boolean insertRecruit(GroupVO group, RecruitVO recruit, MemberVO user);

	ArrayList<ProgrammingCategoryVO> getProgrammingCategoryList();

	ArrayList<ProgrammingLanguageVO> getProgrammingLanguageList();

	boolean insertTotalCate(TotalCategoryVO totalCate, int recu_num);

	boolean insertTotalLang(TotalLanguageVO totalLang, int recu_num);


}
