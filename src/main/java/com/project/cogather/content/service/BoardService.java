package com.project.cogather.content.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.cogather.content.model.ContentDAO;
import com.project.cogather.content.model.ContentDTO;

@Service
public class BoardService {
	ContentDAO contentDAO;
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<ContentDTO> list(int from, int pageRows, int sg_id){
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.selectFromRow(from, pageRows, sg_id);
	}
	
	public int count(int sg_id) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.countAll(sg_id);
	}
	
	@Transactional
	public List<ContentDTO> viewByUid(int ct_uid){
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		contentDAO.incViewCnt(ct_uid);
		return contentDAO.selectByUid(ct_uid);
	}
	
	public int insert(ContentDTO dto) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.insert(dto);
	}
	
	public int update(ContentDTO dto) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.update(dto);
	}
	
	public int deleteByUid(int ct_uid, String id) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.deleteByUid(ct_uid, ct_uid);
	}
}
