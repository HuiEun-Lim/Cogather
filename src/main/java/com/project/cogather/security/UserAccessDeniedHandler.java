package com.project.cogather.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

public class UserAccessDeniedHandler implements AccessDeniedHandler {
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		System.out.println("User Access Denied Handler");
		accessDeniedException.printStackTrace();
		System.out.println("redirect 합니다...");
		response.sendRedirect(request.getContextPath() + "/accessError");  // 리다이렉트!
	}

}
