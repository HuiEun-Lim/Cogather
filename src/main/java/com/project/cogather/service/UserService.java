package com.project.cogather.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.cogather.domain.CafeDTO;
import com.project.cogather.domain.UserDAO;
import com.project.cogather.domain.UserDTO;

@Service
public class UserService {
	UserDAO dao;
	
	private SqlSession sqlSession;
	
	@Inject
	BCryptPasswordEncoder pwdEncoder;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public UserService() {
		super();
	}
	
	public int signup(UserDTO dto) {
		dao = sqlSession.getMapper(UserDAO.class);
		dto.setPw(pwdEncoder.encode(dto.getPw()));
		int result = dao.minsert(dto);
		result = dao.authinsert(dto);
		return result;
	}
	
	public UserDTO selectByID(String id) {
		dao = sqlSession.getMapper(UserDAO.class); // MyBatis 사용
		return dao.selectByID(id);
	}
	
	public List<CafeDTO> myrsvID(String id) {
		dao = sqlSession.getMapper(UserDAO.class);
		return dao.myrsvID(id);
	}
	
}
