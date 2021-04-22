package com.project.cogather.comments.model;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

public class CommentsValitator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		System.out.println("supports(" + clazz.getName() + ")");
		return CommentsDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		System.out.println("Comment Validator validating...");;
		CommentsDTO dto = (CommentsDTO) target;
		String regex = "^[0-9a-zA-Z가-힣]*$";
		
		String id = dto.getId();
		
		Matcher matcher = Pattern.compile(regex).matcher(id);
		if(id == null || id.length() == 0) {
			System.out.println("아이디 오류: 아이디가 비었음" );
			errors.rejectValue("id", "EmptyID");
		}else if(!matcher.find()) {
			System.out.println("아이디 오류: 아이디 형식이 맞지 않았습니다." );
			errors.rejectValue("id", "IDRegexError");
		}
		
		
	}

}
