package com.project.cogather.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cogather.domain.CafeDAO;

@Service
public class CafeService {
	CafeDAO dao;
	
	private SqlSession sqlSession;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	public CafeService() {
		super();
	}

	
}
