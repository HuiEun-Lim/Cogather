package com.project.cogather.members.model;

import java.util.List;

import com.project.cogather.common.AjaxResult;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MembersResult extends AjaxResult{
	List<MembersDTO> data;
}
