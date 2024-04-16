package kr.kh.team2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team2.dao.GroupDAO;

@Service
public class GroupServiceImp implements GroupService {
	
	@Autowired
	GroupDAO groupDAO;

}
