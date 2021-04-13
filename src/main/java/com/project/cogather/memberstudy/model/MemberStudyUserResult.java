package com.project.cogather.memberstudy.model;

import java.util.List;

import com.project.cogather.common.AjaxResult;
import com.project.cogather.members.model.MembersDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberStudyUserResult extends AjaxResult {

	List<MemberStudyDTO> rdata;
	List<MembersDTO> rmember;
	List<MemberStudyDTO> cdata;
	List<MembersDTO> cmember;
	
	
}
