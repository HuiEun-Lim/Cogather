package com.project.cogather.content.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface ContentDAO {
	/**
	 * 페이징용 SELECT
	 * @param from 몇번째 row 부터
	 * @param pageRows 몇개의 데이터(게시글)
	 * @return
	 */
	public List<ContentDTO> selectFromRow(@Param("from") int from, @Param("pageRows") int pageRows, int sg_id);
	
	// 전체 글의 개수
	public int countAll(int sg_id);
	
	// 글 읽기
	public List<ContentDTO> selectByUid(int ct_uid);
	
	// 조회수 증가
	public int incViewCnt(int ct_uid);
	
	// 글 작성
	public int insert(ContentDTO dto);
	
	// 글 수정
	public int update(ContentDTO dto);
	
	// 특정 uid 글들 삭제하기 - 방생성자나 관리자가
	public int deleteByUids(int [] uids);
	
	// 특정 uid 글 삭제
	public int deleteByUid(int ct_uid, int id);
}
