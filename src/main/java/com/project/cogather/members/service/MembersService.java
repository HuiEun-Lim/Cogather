package com.project.cogather.members.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cogather.members.model.MembersDAO;
import com.project.cogather.members.model.MembersDTO;

@Service
public class MembersService {
	private MembersDAO membersDAO;
	
	@Autowired
	private SqlSession sqlsession;
	
	public List<MembersDTO> selectMembers(){
		membersDAO = sqlsession.getMapper(MembersDAO.class);
		return membersDAO.selectAll();
	}
	public List<MembersDTO> selectMemberById(String id){
		membersDAO = sqlsession.getMapper(MembersDAO.class);
		return membersDAO.selectMemberById(id);
	}
}
