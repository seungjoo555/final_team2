package kr.kh.team2.service;

import java.util.ArrayList;

import kr.kh.team2.model.vo.member.MentorInfoVO;
import kr.kh.team2.model.vo.member.MentorJobVO;

public interface MentorService {

	ArrayList<MentorJobVO> getJobList();

	boolean insertMentorInfo(MentorInfoVO mentorInfoVO);

	boolean checkMentor(String me_id);

}
