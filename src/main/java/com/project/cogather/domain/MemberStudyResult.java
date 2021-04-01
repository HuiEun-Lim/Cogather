package com.project.cogather.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberStudyResult extends AjaxResult{
	List<MemberStudyDTO> MSdata;
	List<MembersDTO> Mdata;
	
}
