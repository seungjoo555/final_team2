package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.pagination.Criteria;

public interface LectureService {

	ArrayList<LectureVO> getAllLectureList(Criteria cri);

	ArrayList<LectureVO> getLectureList(Criteria cri, SearchMenuVO search);

	int getLectureCount(Criteria cri, SearchMenuVO search);

}
