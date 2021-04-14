package com.project.cogather.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cogather.service.CafeService;
import com.project.cogather.service.UserService;

@Controller
@RequestMapping("/studycafe")
public class CafeController {
	
	private CafeService cafeService;
	private UserService userService;
	
	@Autowired
	public void setCafeService(CafeService cafeService) {
		this.cafeService = cafeService;
	}
	
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	

	public CafeController() {
		System.out.println("CafeController() 생성");
	}
	
	@RequestMapping("/main")
	public String studymain(Model model) {
		return "cafe/main";
	}

	
	

}
