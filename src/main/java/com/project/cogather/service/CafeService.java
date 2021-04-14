package com.project.cogather.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cogather.domain.CafeDTO;
import com.project.cogather.domain.TestDAO;

// Service 단.
//   JSP MVC model2 의 Command 역할 비슷
//           Controller -> Commmand -> DAO
//   - Transaction 담당

// Spring
//     @Controller -> @Service -> DAO -> JdbcTemplate

@Service
public class CafeService {

	TestDAO dao;
//	@Autowired
//	public void setDao(TestDAO dao) {
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
		dao = sqlSession.getMapper(TestDAO.class);
		return dao.select();
	}
	
	public List<CafeDTO> selectDate(String seat_id){
		dao = sqlSession.getMapper(TestDAO.class);
		return dao.selectDate(seat_id);
	}
	
	public int write(CafeDTO dto) {
		dao = sqlSession.getMapper(TestDAO.class);
		//return dao.insert(dto);
		
		int result = dao.insert(dto);
		System.out.println("생성된 uid 는 " + dto.getRes_id());
		
		return result;
		
		//return dao.insert(dto.getSubject(), dto.getContent(), dto.getName());
	}
	
	//@Transactional
//	public List<CafeDTO> viewByUid(int uid){
//		// ※사실, 트랜잭션은 여기서 발생해야 한다.
//		//  1. 조회수 증가    :   incViewCnt()
//		//  2. 글 하나 읽어오기 :  selectByUid()
//		
//		dao = sqlSession.getMapper(TestDAO.class); // MyBatis 사용
//		return dao.selectByUid(uid);
//	}
//	
//	public List<CafeDTO> selectByUid(int uid) {
//		dao = sqlSession.getMapper(TestDAO.class); // MyBatis 사용
//		return dao.selectByUid(uid);  // 1개짜리 List
//	}
//	
//	public int update(CafeDTO dto) {
//		dao = sqlSession.getMapper(TestDAO.class); // MyBatis 사용
//		//return dao.update(dto);
//		return dao.update(dto.getUid(), dto);
//	}
	
	public int deleteByUid(int uid) {
		dao = sqlSession.getMapper(TestDAO.class); // MyBatis 사용
		return dao.deleteByUid(uid);				
	}
	@Transactional
	public int getprice(CafeDTO dto) {
		dao = sqlSession.getMapper(TestDAO.class);
		return dao.getprice(dto.getSeat_id(),dto);
	}
}















