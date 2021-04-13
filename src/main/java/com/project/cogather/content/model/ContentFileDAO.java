package com.project.cogather.content.model;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
@MapperScan
public interface ContentFileDAO {
	// 파일 테이블 저장
	public int saveFile(ContentFileDTO dto);
	// 게시물 id로 파일에 대해 알아오기
	public List<ContentFileDTO> getFileInfosByCTUID(@Param("ct_uid") int ct_uid);
		
		
}
