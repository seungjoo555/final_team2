package kr.kh.team2.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.LectureDAO;
import kr.kh.team2.dao.RecommendDAO;
import kr.kh.team2.model.dto.RecommendCountDTO;
import kr.kh.team2.model.vo.common.ProgrammingCategoryVO;
import kr.kh.team2.model.vo.common.ProgrammingLanguageVO;
import kr.kh.team2.model.vo.common.SearchMenuVO;
import kr.kh.team2.model.vo.common.TotalCategoryVO;
import kr.kh.team2.model.vo.common.TotalLanguageVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.lecture.LectureVO;
import kr.kh.team2.model.vo.member.MemberVO;
import kr.kh.team2.pagination.Criteria;

@Service
public class LectureServiceImp implements LectureService{

	@Autowired
	LectureDAO lectureDao;
	@Autowired
	RecommendDAO recommendDAO;
	
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

}
