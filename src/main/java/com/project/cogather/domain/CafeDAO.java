package com.project.cogather.domain;

import java.util.List;

//import org.apache.ibatis.annotations.Param;
//import org.mybatis.spring.annotation.MapperScan;

//@MapperScan
public interface CafeDAO {
	// 전체 SELECT
	List<CafeMemberDTO> select();
	
	int minsert(CafeMemberDTO dto);
	int minsert(String id, String pw, String name, String phone, String email);
	
	int authinsert(CafeMemberDTO dto);
	int authinsert(String auth, CafeMemberDTO dto);
}
