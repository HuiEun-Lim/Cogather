package com.project.cogather.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cogather.domain.CafeDTO;
import com.project.cogather.domain.CafeDAO;


@Service
public class CafeService {

	CafeDAO dao;
//	@Autowired
//	public void setDao(CafeDAO dao) {
//		this.dao = dao;
//	}
	
	// MyBatis
	private SqlSession sqlSession;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 테스트 출력
	public CafeService() {
		super();
		System.out.println("CafeService() 생성");
	}
	
	public List<CafeDTO> list(){
		// MyBatis 가 만들어준 DAO
		dao = sqlSession.getMapper(CafeDAO.class);
		return dao.select();
	}
	
	public List<CafeDTO> selectDate(String seat_id){
		dao = sqlSession.getMapper(CafeDAO.class);
		return dao.selectDate(seat_id);
	}
	
	public int write(CafeDTO dto) {
		dao = sqlSession.getMapper(CafeDAO.class);
		//return dao.insert(dto);
		
		int result = dao.insert(dto);
		System.out.println("생성된 uid 는 " + dto.getRes_id());
		
		return result;
		
		//return dao.insert(dto.getSubject(), dto.getContent(), dto.getName());
	}
	
	
	public int deleteByUid(int uid) {
		dao = sqlSession.getMapper(CafeDAO.class); // MyBatis 사용
		return dao.deleteByUid(uid);				
	}
	@Transactional
	public int getprice(CafeDTO dto) {
		dao = sqlSession.getMapper(CafeDAO.class);
		return dao.getprice(dto.getSeat_id(),dto);
	}
}

