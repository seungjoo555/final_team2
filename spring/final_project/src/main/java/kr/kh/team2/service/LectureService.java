package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.pagination.Criteria;

public interface LectureService {

	ArrayList<LectureVO> getLectureList(Criteria cri);

}
