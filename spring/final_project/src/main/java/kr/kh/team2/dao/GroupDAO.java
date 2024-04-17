package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.pagination.Criteria;

@Service
public interface GroupDAO {

	ArrayList<RecruitVO> selectGroupList(@Param("cri")Criteria cri);

	int selectGroupTotalCount(@Param("cri")Criteria cri);
	
	

}
