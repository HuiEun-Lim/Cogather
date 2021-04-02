package com.project.cogather.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/studycafe")
public class CafeController {
	
	@RequestMapping("/main")
	public String studymain(Model model) {
		return "cafe/main";
	}
	
	@RequestMapping("/info")
	public String studyinfo(Model model) {
		return "cafe/info";
	}
	
	@RequestMapping("/map")
	public String studymap(Model model) {
		return "cafe/map";
	}
}
