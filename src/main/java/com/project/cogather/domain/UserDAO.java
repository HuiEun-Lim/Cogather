package com.project.cogather.domain;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.cogather.memberstudy.model.MemberStudyDTO;
import com.project.cogather.studygroup.model.StudyGroupDTO;

//@MapperScan
public interface UserDAO {
	// 전체 SELECT
		List<UserDTO> select();
		List<CafeDTO> myrsvID(String id);
		List<MemberStudyDTO> mygroupID(String id);
		List<StudyGroupDTO> mygroupName(String id);
		
		int minsert(UserDTO dto);
		int minsert(String id, String pw, String name, String phone, String email, String tag);
		
		int authinsert(UserDTO dto);
		int authinsert(String auth, UserDTO dto);
		
		UserDTO selectByID(String id);
		
		int update(UserDTO dto);
		int update(@Param("id") String id, @Param("a") UserDTO dto);
		
		int deleteById(String id);
		int deleteAuth(String id);
		int deleteMemberStudy(String id);
		
}
