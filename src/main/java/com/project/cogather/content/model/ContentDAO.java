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
	public List<ContentDTO> selectFromRow(@Param("from") int from, @Param("pageRows") int pageRows, @Param("sg_id") int sg_id);
	
	// 전체 글의 개수
	public int countAll(@Param("sg_id") int sg_id);
	
	// 글 읽기
	public List<ContentDTO> selectByUid(@Param("sg_id")int sg_id, @Param("ct_uid") int ct_uid);
	
	// 임시 생성된 글 번호 가져오기
	public List<ContentDTO> selectTempContent(@Param("id") String id);
	
	// 조회수 증가
	public int incViewCnt(@Param("sg_id") int sg_id, @Param("ct_uid") int ct_uid);
	
	// 글 작성
	public int insert(ContentDTO dto);
	
	// 글 수정
	public int update(ContentDTO dto);
	
	// 특정 uid 글들 삭제하기 - 방생성자나 관리자가
	public int deleteByUids(int [] uids);
	
	// 특정 uid 글 삭제
	public int deleteByUid(@Param("sg_id") int sg_id,@Param("ct_uid") int ct_uid, @Param("id") String id);
	
	
}
