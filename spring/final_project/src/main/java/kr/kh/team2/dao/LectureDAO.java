package kr.kh.team2.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.pagination.Criteria;

public interface LectureDAO {

	ArrayList<LectureVO> selectLectureList(@Param("cri") Criteria cri);

}
