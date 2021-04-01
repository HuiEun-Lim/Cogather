package com.project.cogather.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cogather.domain.MembersDAO;
import com.project.cogather.domain.MembersDTO;

@Service
public class MembersService {
	private MembersDAO membersDAO;
	
	@Autowired
	private SqlSession sqlsession;
	
	public List<MembersDTO> selectMembers(){
		membersDAO = sqlsession.getMapper(MembersDAO.class);
		return membersDAO.selectAll();
	}
}
