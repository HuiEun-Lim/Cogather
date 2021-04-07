package com.project.cogather.domain;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface StudyGroupDAO {

	public abstract List<StudyGroupDTO> select();
	
	public abstract List<StudyGroupDTO> select_recent();
	
	public abstract int insert(StudyGroupDTO dto);
	
	public abstract int update(StudyGroupDTO dto);
	public abstract int update(int sg_id, @Param("a") StudyGroupDTO dto);
	public abstract int deleteByUid(int sg_id);
	
	public abstract List<StudyGroupDTO> selectByUid(int sg_id);
	
	// 게시물 총 갯수
	public int countBoard();

	// 페이징 처리 게시글 조회
	public List<StudyGroupDTO> selectBoard(StudyGroupPaging sp);
	
	//첨부파일 업로드

	//public abstract void insertFile(StudyGroupFileDTO fdto);
	public abstract void insertFile(Map<String,Object>map) throws Exception;
	//첨부파일 다운로드 
	public abstract Map<String,Object> selectFileInfo(Map<String,Object>map);
	//첨부파일 조회
	public abstract List<Map<String,Object>> selectFile(int sg_id);
}
