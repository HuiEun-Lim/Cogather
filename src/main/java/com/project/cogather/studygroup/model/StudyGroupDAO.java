package com.project.cogather.studygroup.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import com.project.cogather.studygroup.model.StudyGroupPaging;

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
	public int countBoard(String keyword);

	// 페이징 처리 게시글 조회
	public List<StudyGroupDTO> selectBoard(StudyGroupPaging sp);
	
	//첨부파일 업로드

	//public abstract void insertFile(StudyGroupFileDTO fdto);
	public abstract void insertFile(Map<String,Object>map) throws Exception;
	//첨부파일 다운로드 
	public abstract Map<String,Object> selectFileInfo(Map<String,Object>map);
	//첨부파일 조회
	public abstract List<Map<String,Object>> selectFile(int sg_id);
	
	//첨부파일 삭제
	public int deleteFileByUid(int sg_id);
	//첨부파일 수정
	public abstract void updateFile(Map<String,Object>map) throws Exception;
	
	// 유저 아이디로 참여한 모든 스터디 쿼리
	public List<StudyGroupDTO> getStudyByID(@Param("id") String id);
	
	// 방 아이디로 해당 방의 정보 가져오기
	public List<StudyGroupDTO> getStudyBySgID(@Param("sg_id") Integer sg_id);
}	
