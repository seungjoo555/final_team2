package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.LectureDAO;
import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.pagination.Criteria;

@Service
public class LectureServiceImp implements LectureService{

	@Autowired
	LectureDAO lectureDao;
	
	private boolean checkString(String str) {
		return str != null && str.length() != 0;
	}
	
	@Override
	public ArrayList<LectureVO> getAllLectureList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1,5);
		}
		return lectureDao.selectAllLectureList(cri);
	}

	@Override
	public ArrayList<LectureVO> getLectureList(Criteria cri, SearchMenuVO search) {
		if(cri == null) {
			cri = new Criteria(1,5);
		}
		if(search == null) {
			search = new SearchMenuVO();
		}
		return lectureDao.selectLectureList(cri, search);
	}

	@Override
	public int getLectureCount(Criteria cri, SearchMenuVO search) {
		if(cri == null) {
			cri = new Criteria(1,5);
		}
		if(search == null) {
			search = new SearchMenuVO();
		}
		return lectureDao.selectLectureCount(cri, search);
	}

}
