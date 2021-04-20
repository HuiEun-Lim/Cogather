package com.project.cogather.memberstudy.model;

import java.util.List;

import com.project.cogather.common.AjaxResult;
import com.project.cogather.members.model.MembersDTO;
import com.project.cogather.studygroup.model.StudyGroupDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberStudyResult extends AjaxResult{
	List<MemberStudyDTO> MSdata;
	List<MembersDTO> Mdata;
	List<StudyGroupDTO> study;
}
