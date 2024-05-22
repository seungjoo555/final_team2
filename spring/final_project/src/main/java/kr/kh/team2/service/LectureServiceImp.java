package kr.kh.team2.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.team2.dao.LectureDAO;
import kr.kh.team2.dao.RecommendDAO;
import kr.kh.team2.model.dto.RecommendCountDTO;
import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.lecture.LectureFileVO;
import kr.kh.team2.model.vo.lecture.LectureRegisterVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;
import kr.kh.team2.utils.UploadFileUtils;

@Service
public class LectureServiceImp implements LectureService{

	@Autowired
	LectureDAO lectureDao;
	@Autowired
	RecommendDAO recommendDAO;
	
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
			System.out.println(fileVO);
			//DB에 첨부파일 정보를 추가
			lectureDao.insertFile(fileVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void deleteFile(LectureFileVO file) {
		if(file == null) {
			return;
		}
		//서버에서 삭제
		UploadFileUtils.delteFile(uploadPath, file.getLectFi_path());
		//DB에서 삭제
		lectureDao.deleteFile(file.getLectFi_num());
	}
	
	private boolean checkString(String str) {
		return str != null && str.length() != 0;
	}
	
	@Override
	public ArrayList<LectureVO> getAllLectureList(Criteria cri, SearchMenuVO search) {
		if(cri == null) {
			cri = new Criteria(1,5);
		}
		return lectureDao.selectAllLectureList(cri, search);
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
	public boolean insertLecture(LectureVO lecture, MemberVO user,
								String progCtList, String progLangList, MultipartFile[] file) {
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
		
		if(file == null || file.length == 0) {
			System.out.println("파일 없음");
			return true;
		}
		
		for(MultipartFile tmp : file) {
			uploadFile(lecture.getLect_num(), tmp);
		}
		
		return true;
	}
	/** 추천 순 강의 리스트 가져오는 서비스 */
	@Override
	public ArrayList<LectureVO> getHotLectureList() {
		//그룹 전체 리스트 가져오기
		ArrayList<LectureVO> AllList = lectureDao.selectHotLectureList();
		if(AllList == null) {
			return null;
		}
		
		//추천 리스트 가져오기
		ArrayList<RecommendCountDTO> list = new ArrayList<RecommendCountDTO>();
		
		for(LectureVO i : AllList) {
			RecommendCountDTO recruitCount = recommendDAO.selectRecommendCountList("lecture", Integer.toString(i.getLect_num()));
			recruitCount.setReco_table("recruit");
			recruitCount.setReco_target(Integer.toString(i.getLect_num()));
			recruitCount.setRecu_due(lectureDao.selectDue(recruitCount.getReco_target()));
			System.out.println(recruitCount);
			list.add(recruitCount);
		}
		
		//추천순으로 자르기
		Collections.sort(list, new Comparator<RecommendCountDTO>() {
			@Override
			public int compare(RecommendCountDTO o1, RecommendCountDTO o2) {
				//만약 추천수가 같다면
				if(o2.getCount() - o1.getCount() == 0) {
					//최신순으로 정렬
					return o2.getRecu_due().compareTo(o1.getRecu_due());
				}
				return o2.getCount() - o1.getCount();
			}
		});
		
		//추천순으로 그룹 가져오기
		ArrayList<LectureVO> hotList = new ArrayList<LectureVO>();
		
		if(list.size() > 4) {
			for(int i=0; i<4; i++) {
				hotList.add(lectureDao.selectLecture(Integer.parseInt(list.get(i).getReco_target()))) ;
			}
		}else {
			for(int i=0; i<list.size(); i++) {
				hotList.add(lectureDao.selectLecture(Integer.parseInt(list.get(i).getReco_target()))) ;
			}
		}
		
		return hotList;
	}

	@Override
	public ArrayList<LectureFileVO> getFileList(int lectNum) {
		return lectureDao.selectFileList(lectNum);
	}

	@Override
	public boolean insertLectureRegister(LectureRegisterVO lectureRgVo) {
		if(lectureRgVo == null) {
			return false;
		}
		return lectureDao.insertLectureRegister(lectureRgVo);
	}

	@Override
	public LectureRegisterVO getLecturePayment(int lectNum, MemberVO user) {
		if(user == null) {
			return null;
		}
		return lectureDao.selectLecturePayment(lectNum, user.getMe_id());
	}

	@Override
	public String uploadImg(MultipartFile file) {
		if(file == null || file.getOriginalFilename().length() == 0)
			return null;
		try {
			return UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public void deleteImg(String file) {
		System.out.println(file);
		UploadFileUtils.delteFile(uploadPath, file);
	}

	@Override
	public boolean updateLecture(LectureVO lecture, MemberVO user, MultipartFile[] file, int[] delNums) {
		if(lecture == null || !checkString(lecture.getLect_name()) || !checkString(lecture.getLect_intro())) return false;
		if(user == null) return false;
		LectureVO dbLecture = lectureDao.selectLecture(lecture.getLect_num());
		if(dbLecture == null || !dbLecture.getLect_mentIf_me_id().equals(user.getMe_id())) return false;
		//강의 수정
		boolean res = lectureDao.updateLecture(lecture);
		if(!res) return false;
		//첨부파일 수정
		//새 첨부파일 추가
		if(file != null) {
			for(MultipartFile tmp : file) {
				uploadFile(lecture.getLect_num(), tmp);
			}
		}
		//삭제할 첨부파일
		if(delNums == null) return true;
		for(int tmp : delNums) {
			LectureFileVO fileVo = lectureDao.selectFile(tmp);
			deleteFile(fileVo);
		}
		return true;
	}

	@Override
	public ArrayList<LectureVO> getMyLecture(MemberVO user) {
		if(user == null) {
			return null;
		}
		return lectureDao.selectMyLecture(user.getMe_id());
	}

}
