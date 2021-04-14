package com.project.cogather.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cogather.domain.UserDTO;
import com.project.cogather.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;

	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		System.out.println("access Denied : " + auth);
		model.addAttribute("msg", "접근 권한 거부");
	}
	
	@RequestMapping("/signup")
	public String cafeSignup(Model model) {
		return "user/signup";
	}
	
	@RequestMapping("/signupOk")
	public String cafeSignupOk(UserDTO dto, Model model) {
		model.addAttribute("result", userService.signup(dto));
		return "user/signupOk";
	}
	
//	@GetMapping("/login")
//	public String cafeLogin(Model model) {
//		return "cafeuser/login";
//	}
	
	@GetMapping("/login")
	public String loginInput(String error, String logout, Model model, HttpServletRequest request) {
		System.out.println("error: " + error);
		System.out.println("logout: " + logout);

		// 요청 시점의 사용자 URI 정보를 Session의 Attribute에 담아서 전달(잘 지워줘야 함)
				// 로그인이 틀려서 다시 하면 요청 시점의 URI가 로그인 페이지가 되므로 조건문 설정
				String uri = request.getHeader("Referer");
				if (!uri.contains("/loginView")) {
					request.getSession().setAttribute("prevPage",
							request.getHeader("Referer"));
				}
		return "user/login";
	}
	
	@GetMapping("/logout")
	public String logoutGET() {
		System.out.println("GET: custom logout");
		
		return "user/logout";
	}
	
	@PostMapping("/logout")
	public void logoutPost() {
		System.out.println("POST: custom logout");
	}
	
	@GetMapping("/cafemypage")
	public String view(String id, Model model) {
		model.addAttribute("list", userService.selectByID(id));
		return "user/cafemypage";
	}
	
	
}
