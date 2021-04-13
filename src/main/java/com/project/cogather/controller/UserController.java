package com.project.cogather.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cogather.domain.CafeMemberDTO;
import com.project.cogather.service.CafeService;

@Controller
public class UserController {
	
	private CafeService cafeService;

	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		System.out.println("access Denied : " + auth);
		model.addAttribute("msg", "접근 권한 거부");
	}
	
	@RequestMapping("/signup")
	public String cafeSignup(Model model) {
		return "cafe/signup";
	}
	
	@RequestMapping("/signupOk")
	public String cafeSignupOk(CafeMemberDTO dto, Model model) {
		model.addAttribute("result", cafeService.signup(dto));
		return "cafe/signupOk";
	}
	
//	@GetMapping("/login")
//	public String cafeLogin(Model model) {
//		return "cafeuser/login";
//	}
	
	@GetMapping("/login")
	public String loginInput(String error, String logout, Model model) {
		System.out.println("error: " + error);
		System.out.println("logout: " + logout);
		
//		if(error != null) {
//			model.addAttribute("error", "로그인 에러, 계정정보 확인해주삼");
//		}
		
//		if(logout != null) {
//			model.addAttribute("logout", "로그아웃!!");
//		}
		return "cafeuser/login";
	}
	
	
}
