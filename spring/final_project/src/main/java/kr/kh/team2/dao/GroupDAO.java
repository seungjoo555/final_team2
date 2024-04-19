package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;

@Service
public interface GroupDAO {

	ArrayList<RecruitVO> selectGroupList(@Param("cri")Criteria cri);

	RecruitVO selectRecruit(@Param("num")int num);

	MemberVO selectGroupKing(@Param("recu_go_num")int recu_go_num);

	ArrayList<TotalCategoryVO> selectCategoryList(@Param("num")int num, @Param("table")String table);

	ArrayList<TotalLanguageVO> selectLanguageList(@Param("num")int num, @Param("table")String table);
	
}