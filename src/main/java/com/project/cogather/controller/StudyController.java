package com.project.cogather.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/group")
public class StudyController {


	@RequestMapping("/studygroup")
	public String studymain(Model model) {
		return "group/studygroup";
	}
}
