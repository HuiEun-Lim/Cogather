package com.project.cogather.comments.controller;

import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Positive;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.cogather.comments.model.CommentsDTO;
import com.project.cogather.comments.model.CommentsResult;
import com.project.cogather.comments.model.CommentsValitator;
import com.project.cogather.comments.service.CommentsService;
import com.project.cogather.common.AjaxResult;
import com.project.cogather.members.model.MembersDTO;
import com.project.cogather.members.service.MembersService;

@RestController
public class RestCommentsController {
	@Autowired
	CommentsService commentsService;
	
	@Autowired
	MembersService membersService;
	
	@RequestMapping("/group/studyboard/comments/{ct_uid}")
	public CommentsResult selectComments(@NotNull @Positive @PathVariable Integer ct_uid) {
		CommentsResult result = new CommentsResult();
		
		String status ="fail";
		StringBuffer message = new StringBuffer();
		int cnt = 0;
		List<CommentsDTO> data = null;
		List<MembersDTO> members = null;
		
		
		try {
			data = commentsService.selectAllCommentsByCTUID(ct_uid);
			members = membersService.selectMemberByCtUid(ct_uid);
			if(data == null || data.size() == 0 || members == null || members.size() == 0) {
				message.append("댓글이 없습니다.");
			}else {
				cnt = data.size();
				status = "OK";
			}
		}catch(Exception e) {
			message.append(e.getMessage());
		}
		
		result.setCnt(cnt);
		result.setMessage(message.toString());
		result.setStatus(status);
		result.setData(data);
		result.setMembers(members);
		return result;
	}
	
	@PostMapping("/group/studyboard/comments")
	public AjaxResult insertComment(@Valid CommentsDTO dto) {
		AjaxResult result = new AjaxResult();
		String status ="fail";
		StringBuffer message = new StringBuffer();
		int cnt = 0;
		try {
			cnt = commentsService.insertComments(dto);
			
			if(cnt == 0) {
				message.append("댓글 입력에 실패했습니다.");
			}else {
				status="OK";
				
			}
		}catch(Exception e) {
			message.append(e.getMessage());
		}
		
		result.setCnt(cnt);
		result.setMessage(message.toString());
		result.setStatus(status);
		return result;
	}
	
	@PutMapping("/group/studyboard/comments")
	public AjaxResult updateComment(@Valid CommentsDTO dto) {
		AjaxResult result = new AjaxResult();
		String status ="fail";
		StringBuffer message = new StringBuffer();
		int cnt = 0;
		try {
			cnt = commentsService.updateComments(dto);
			
			if(cnt == 0) {
				message.append("댓글 수정에 실패했습니다.");
			}else {
				status="OK";
			}
		}catch(Exception e) {
			message.append(e.getMessage());
		}
		
		result.setCnt(cnt);
		result.setMessage(message.toString());
		result.setStatus(status);
		return result;
	}
	@DeleteMapping("/group/studyboard/comments/")
	public AjaxResult deleteComment(
			@NotNull @Positive Integer cm_uid, 
			@NotNull @Pattern(regexp = "^[0-9a-zA-Z가-힣]*$") String id) {
		AjaxResult result = new AjaxResult();
		String status ="fail";
		StringBuffer message = new StringBuffer();
		int cnt = 0;
		try {
			cnt = commentsService.deleteComments(cm_uid, id);
			if(cnt == 0) {
				message.append("댓글 삭제에 실패했습니다.");
			}else {
				status="OK";
			}
		}catch(Exception e) {
			message.append(e.getMessage());
		}
		
		result.setCnt(cnt);
		result.setMessage(message.toString());
		result.setStatus(status);
		return result;
	}
	
	// 이 컨트롤러 클래스의 handler 에서 폼 데이터를 바인딩 할 때 검증하는 객체 지정
		@InitBinder
		public void initBinder(WebDataBinder binder) {
			binder.setValidator(new CommentsValitator());
		}
}
