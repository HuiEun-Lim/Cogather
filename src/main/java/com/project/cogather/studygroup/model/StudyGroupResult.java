package com.project.cogather.studygroup.model;

import java.util.List;

import com.project.cogather.common.AjaxResult;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class StudyGroupResult extends AjaxResult{
	List<StudyGroupDTO> data;
}
