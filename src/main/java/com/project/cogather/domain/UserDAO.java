package com.project.cogather.domain;

import java.util.List;

//@MapperScan
public interface UserDAO {
	// 전체 SELECT
		List<UserDTO> select();
		
		int minsert(UserDTO dto);
		int minsert(String id, String pw, String name, String phone, String email);
		
		int authinsert(UserDTO dto);
		int authinsert(String auth, UserDTO dto);
		
		UserDTO selectByID(String id);
}
