package kr.kh.team2.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.lecture.LectureFileVO;
import kr.kh.team2.model.vo.lecture.LectureRegisterVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;

public interface LectureService {

	ArrayList<LectureVO> getAllLectureList(Criteria cri);

	ArrayList<LectureVO> getLectureList(Criteria cri, SearchMenuVO search);

	int getLectureCount(Criteria cri, SearchMenuVO search);

	LectureVO getLecture(int lectNum);

	MemberVO getLecture_Mento(String lect_mentIf_me_id);

	ArrayList<TotalCategoryVO> getCategory(int lectNum, String table);

	ArrayList<TotalLanguageVO> getLanguage(int lectNum, String table);

	ArrayList<ProgrammingCategoryVO> getProgrammingCategoryList();

	ArrayList<ProgrammingLanguageVO> getProgrammingLanguageList();

	boolean insertLecture(LectureVO lecture, MemberVO user, String progCtList, String progLangList, MultipartFile[] file);

	ArrayList<LectureFileVO> getFileList(int lectNum);

	ArrayList<LectureVO> getHotLectureList();

	boolean insertLectureRegister(LectureRegisterVO lectureRgVo);

	LectureRegisterVO getLecturePayment(int lectNum, MemberVO user);

	String uploadImg(MultipartFile file);

	void deleteImg(String file);

	boolean updateLecture(LectureVO lecture, MemberVO user, MultipartFile[] file, int[] delNums);

	ArrayList<LectureVO> getMyLecture(MemberVO user);

}
