package kr.kh.team2.service;

import kr.kh.team2.model.vo.group.GroupVO;
import kr.kh.team2.model.vo.group.RecruitVO;
import kr.kh.team2.model.vo.member.MemberVO;

public interface RecruitService {

	boolean insertRecruit(GroupVO group, RecruitVO recruit, MemberVO user);

}
