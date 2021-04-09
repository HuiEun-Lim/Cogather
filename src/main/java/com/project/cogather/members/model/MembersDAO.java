package com.project.cogather.members.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;


public interface MembersDAO {
	public List<MembersDTO> selectAll();
}
