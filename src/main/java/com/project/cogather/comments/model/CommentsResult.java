package com.project.cogather.comments.model;

import java.util.List;

import com.project.cogather.common.AjaxResult;
import com.project.cogather.members.model.MembersDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentsResult extends AjaxResult {
	List<CommentsDTO> data;
	List<MembersDTO> members; 
}
