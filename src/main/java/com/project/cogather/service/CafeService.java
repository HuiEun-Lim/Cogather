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
		dao = sqlSession.getMapper(CafeDAO.class);
		return dao.select();
	}
	
	public List<CafeDTO> selectDate(String seat_id){ //각 좌석에대한 예약내역
		dao = sqlSession.getMapper(CafeDAO.class);
		return dao.selectDate(seat_id);
	}
	
	public List<CafeDTO> adminview(){
		dao = sqlSession.getMapper(CafeDAO.class);
		return dao.adminview();
	}
	
	public int write(CafeDTO dto) {
		dao = sqlSession.getMapper(CafeDAO.class);
		
		int result = dao.insert(dto);
		System.out.println("생성된 uid 는 " + dto.getRes_id());
		
		return result;
			}

	
	public int deleteByUid(int uid) {
		dao = sqlSession.getMapper(CafeDAO.class);
		return dao.deleteByUid(uid);				
	}
	
	@Transactional
	public int getprice(CafeDTO dto) {
		dao = sqlSession.getMapper(CafeDAO.class);
		return dao.getprice(dto.getSeat_id(),dto);
	}
}















