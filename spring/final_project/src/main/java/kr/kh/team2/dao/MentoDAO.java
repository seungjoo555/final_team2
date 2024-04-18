package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MetoringVO;
import kr.kh.team2.pagination.Criteria;

public interface MentoDAO {

	ArrayList<MetoringVO> selectMentoList(@Param("cri")Criteria cri);

	int selectMentoTotalCount(@Param("cri")Criteria cri);

}
