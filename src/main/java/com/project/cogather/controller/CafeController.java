package com.project.cogather.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cogather.domain.CafeDTO;
import com.project.cogather.domain.CafeMemberDTO;
import com.project.cogather.service.CafeService;

@Controller
@RequestMapping("/studycafe")
public class CafeController {
	
	private CafeService cafeService;
	
	@Autowired
	public void setCafeService(CafeService cafeService) {
		this.cafeService = cafeService;
	}
	

	public CafeController() {
		System.out.println("CafeController() 생성");
	}
	
	@RequestMapping("/main")
	public String studymain(Model model) {
		return "cafe/main";
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
	
	@RequestMapping("/login")
	public String cafeLogin(Model model) {
		return "cafe/login";
	}
	
	@PostMapping("/login")
	public void loginInput(String error, String logout, Model model) {
		System.out.println("error: " + error);
		System.out.println("logout: " + logout);
		
//		if(error != null) {
//			model.addAttribute("error", "로그인 에러, 계정정보 확인해주삼");
//		}
		
//		if(logout != null) {
//			model.addAttribute("logout", "로그아웃!!");
//		}
	}

}
