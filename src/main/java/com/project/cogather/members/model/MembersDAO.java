package com.project.cogather.members.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
@MapperScan
public interface MembersDAO {
	public List<MembersDTO> selectAll();
	
	public List<MembersDTO> selectMemberById(@Param("id") String id);
	
	public List<MembersDTO> selectMemberByCtUid(@Param("ct_uid") Integer ct_uid);
}
