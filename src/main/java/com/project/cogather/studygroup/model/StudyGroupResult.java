package com.project.cogather.studygroup.model;

import java.util.List;

import com.project.cogather.common.AjaxResult;
import com.project.cogather.memberstudy.model.MemberStudyDTO;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class StudyGroupResult extends AjaxResult{
	String id;
	List<StudyGroupDTO> data;
	List<MemberStudyDTO> ms;
}
