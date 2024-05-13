package kr.kh.team2.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.team2.dao.LectureDAO;
import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.lecture.LectureFileVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.utils.UploadFileUtils;

@Service
public class LectureServiceImp implements LectureService{

	@Autowired
	LectureDAO lectureDao;
	
	@Resource
	String uploadPath;

	private void uploadFile(int lect_num, MultipartFile file) {
		if(file == null || file.getOriginalFilename().length() == 0)
			return;
		try {
			String fileOriName = file.getOriginalFilename();
			//첨부파일 업로드 후 경로를 가져옴
			String fileName = 
				UploadFileUtils.uploadFile(
						uploadPath, 
						fileOriName, 
						file.getBytes());
			LectureFileVO fileVO = new LectureFileVO(lect_num, fileName, fileOriName);
			//DB에 첨부파일 정보를 추가
			lectureDao.insertFile(fileVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
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

	@Override
	public boolean insertLecture(LectureVO lecture, MemberVO user, String progCtList, String progLangList) {
		if(user == null || lecture == null) {
			return false;
		}
		if( !checkString(lecture.getLect_name()) ||
			!checkString(lecture.getLect_intro()) ||
			!checkString(progCtList) ||
			!checkString(progLangList) ) {
			return false;
		}
		lecture.setLect_mentIf_me_id(user.getMe_id());
		boolean res = lectureDao.insertLecture(lecture);
		//강의 등록에 실패하면 분야,언어,파일 업로드 필요x
		if(!res) {
			return false;
		}
		//분야 insert
		String [] progCt = progCtList.split(",");
		for(String tmp : progCt) {
			int ct = Integer.parseInt(tmp);
			TotalCategoryVO totalCateVo = new TotalCategoryVO();
			totalCateVo.setToCt_progCt_num(ct);
			totalCateVo.setToCt_table_name("lecture");
			totalCateVo.setToCt_table_pk(""+lecture.getLect_num());
			boolean resCate = lectureDao.insertTotalCate(totalCateVo);
			
			if(!resCate) {
				System.out.println("분야 등록 실패");
			}
		}
		//사용 언어,스킬 insert
		String [] progLang = progLangList.split(",");
		for(String tmp : progLang) {
			int ct = Integer.parseInt(tmp);
			TotalLanguageVO totalLangVo = new TotalLanguageVO();
			totalLangVo.setToLg_lang_num(ct);
			totalLangVo.setToLg_table_name("lecture");
			totalLangVo.setToLg_table_pk(""+lecture.getLect_num());
			boolean resLang = lectureDao.insertTotalLang(totalLangVo);
			
			if(!resLang) {
				System.out.println("언어 등록 실패");
			}
		}
		return true;
	}

}
