package com.project.cogather.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

public class UserLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		System.out.println("AuthenticationSuccessHandler : 로그인 성공");
		

		// Authentication 객체를 이용해서 사용자가 가진 모든 권한을 문자열로 체크 가능
		List<String> roleNames = new ArrayList<>();
		authentication.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		System.out.println("ROLE NAMES : " + roleNames);
		
		
		// 만약 사용자가 ROLE_ADMIN 권한을 가졌다면 로그인 후 곧바로 /sample/admin 으로 이동
//		if(roleNames.contains("ROLE_ADMIN")) {
//			response.sendRedirect(request.getContextPath() + "/studycafe/adminrsv");
//			return;
//		}
		
		// 만약 일반 회원 (ROLE_MEMBER) 라면 로그인 후 곧바로 /sample/member 로 이동
//		if(roleNames.contains("ROLE_USER")) {
//			response.sendRedirect(request.getContextPath() + "/studycafe/main");
//			return;
//		}
		
		//response.sendRedirect(request.getContextPath());
		
		
		String uri = request.getContextPath(); // 전 페이지가 없을 경우 contextPath로 이동
		
		/* 강제 인터셉트 당했을 경우의 데이터 get */
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		/* 로그인 버튼 눌러 접속했을 경우의 데이터 get */
		String prevPage = (String) request.getSession().getAttribute("prevPage");
		
		if (prevPage != null) {
			request.getSession().removeAttribute("prevPage");
		}

		// null이 아니라면 강제 인터셉트 당했다는 것
		if (savedRequest != null) {
			uri = savedRequest.getRedirectUrl();

		// ""가 아니라면 직접 로그인 페이지로 접속한 것
		} else if (prevPage != null && !prevPage.equals("")) {
			uri = prevPage;
		}
		
		// 유저 이름 쿠키에 담기
		Cookie userCookie = new Cookie("user_id", authentication.getName());
		userCookie.setMaxAge(15*60); // 쿠키 15분 유지
		response.addCookie(userCookie);
		// 세 가지 케이스에 따른 URI 주소로 리다이렉트
		response.sendRedirect(uri);
		
	}
}
