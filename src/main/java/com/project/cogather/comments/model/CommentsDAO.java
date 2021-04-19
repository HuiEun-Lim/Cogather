package com.project.cogather.comments.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface CommentsDAO {
	// 게시글 uid에 대한 모든 댓글 가져오기
	public List<CommentsDTO> selectAllCommentsByCTUID(@Param("ct_uid") int ct_uid);
	// 게시글에 댓글 쓰기
	public int insertComments(CommentsDTO dto);
	// 회원이 특정 게시글에 자신이 써놓은 댓글 수정
	public int updateComments(CommentsDTO dto);
	// 회원이 특정 게시글에 써둔 자기 댓글 삭제
	public int deleteComments(@Param("cm_uid") int cm_uid,@Param("id") String id);
	
	// 리스트의 댓글 수 계산해서 가져오기
	public List<CommentsCounts> getCommentsCounts(@Param("sg_id") Integer sg_id, @Param("page") Integer page, @Param("pageRows") Integer pageRows);
}
