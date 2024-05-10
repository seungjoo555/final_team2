package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.LectureDAO;
import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.model.vo.member.MemberVO;
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

	@Override
	public LectureVO getLecture(int lectNum) {
		return lectureDao.selectLecture(lectNum);
	}

	@Override
	public MemberVO getLecture_Mento(String lect_mentIf_me_id) {
		if(!checkString(lect_mentIf_me_id)) {
			return null;
		}
		return lectureDao.selectLecture_Mento(lect_mentIf_me_id);
	}

	@Override
	public ArrayList<TotalCategoryVO> getCategory(int lectNum, String table) {
		if(!checkString(table)) {
			return null;
		}
		return lectureDao.selectCategoryList(lectNum, table);
	}

	@Override
	public ArrayList<TotalLanguageVO> getLanguage(int lectNum, String table) {
		if(!checkString(table)) {
			return null;
		}
		return lectureDao.selectLanguageList(lectNum, table);
	}

	@Override
	public ArrayList<ProgrammingCategoryVO> getProgrammingCategoryList() {
		return lectureDao.selectProgrammingCategoryList();
	}

	@Override
	public ArrayList<ProgrammingLanguageVO> getProgrammingLanguageList() {
		return lectureDao.selectProgrammingLanguageList();
	}

}
