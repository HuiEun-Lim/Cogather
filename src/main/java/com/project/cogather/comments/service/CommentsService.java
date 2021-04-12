package com.project.cogather.comments.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cogather.comments.model.CommentsDAO;
import com.project.cogather.comments.model.CommentsDTO;

@Service
public class CommentsService {
	private CommentsDAO commentsDAO;
	@Autowired
	private SqlSession sqlSession;
	// 게시글 uid에 대한 모든 댓글 가져오기
	public List<CommentsDTO> selectAllCommentsByCTUID(int ct_uid){
		commentsDAO = sqlSession.getMapper(CommentsDAO.class);
		return commentsDAO.selectAllCommentsByCTUID(ct_uid);
	}
	// 게시글에 댓글 쓰기
	public int insertComments(CommentsDTO dto) {
		commentsDAO = sqlSession.getMapper(CommentsDAO.class);
		return commentsDAO.insertComments(dto);
	}
	// 회원이 특정 게시글에 자신이 써놓은 댓글 수정
	public int updateComments(CommentsDTO dto) {
		commentsDAO = sqlSession.getMapper(CommentsDAO.class);
		return commentsDAO.updateComments(dto);
	}
	// 회원이 특정 게시글에 써둔 자기 댓글 삭제
	public int deleteComments(int cm_uid, String id) {
		commentsDAO = sqlSession.getMapper(CommentsDAO.class);
		return commentsDAO.deleteComments(cm_uid, id);
	}
}
