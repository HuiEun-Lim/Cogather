package com.project.cogather.content.model;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.project.cogather.comments.model.CommentsDTO;

public class BoardValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		System.out.println("supports(" + clazz.getName() + ")");
		return ContentDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		System.out.println("Board Validator validating...");;
		ContentDTO dto = (ContentDTO) target;
		String regex = "^[0-9a-zA-Z가-힣]*$";
		
		
		String id = dto.getId();
		Integer sg_id = dto.getSg_id();
		String ct_title = dto.getCt_title();
		Integer ct_uid = dto.getCt_uid();
		Matcher matcher = Pattern.compile(regex).matcher(id);
		
		if(id == null || id.length() == 0) {
			System.out.println("아이디 오류: 아이디가 비었음" );
			errors.rejectValue("id", "EmptyID");
		}else if(!matcher.find()) {
			System.out.println("아이디 오류: 아이디 형식이 맞지 않았습니다." );
			errors.rejectValue("id", "IDRegexError");
		}
		
		if(sg_id == null) {
			System.out.println("방번호 오류: 방번호가 null임");
			errors.rejectValue("sg_id", "EmptySGID");
		}
		
		if(ct_title == null || ct_title.length() == 0) {
			System.out.println("제목 오류: 제목이 비어있음");
			errors.rejectValue("ct_title", "EmptyCTtitle");
		}
		
		if(ct_uid == null) {
			System.out.println("게시글 번호 오류");
			errors.rejectValue("ct_uid", "EmptyCTUid");
		}
	}

}
