package com.project.cogather.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cogather.service.MemberStudyService;
import com.project.cogather.service.MembersService;

@Controller
@RequestMapping("/group")
public class StudyController {
	
	@Autowired
	MembersService membersService;

	@Autowired
	MemberStudyService memberStudyService;
	
	@RequestMapping("/studygroup")
	public String studymain(Model model) {
		model.addAttribute("test", membersService.selectMembers());
		return "group/studygroup";
	}
	
	@RequestMapping("/studyroom")
	public String studyroom(int sg_id, String id ,Model model) {
		model.addAttribute("studyMemberList", memberStudyService.select(sg_id));
		model.addAttribute("studyMemberdetails", memberStudyService.selectMembersBySGId(sg_id));
		model.addAttribute("sg_id", sg_id);
		model.addAttribute("id", id);
		return "group/studyroom";
	}
	
	@RequestMapping("/roomenterOk")
	public String roomenterOk(int sg_id, String id, Model model) {
		model.addAttribute("result", memberStudyService.enterStatus(sg_id, id));
		model.addAttribute("sg_id", sg_id);
		model.addAttribute("id", id);
		
		return "group/roomenterOk";
	}
	@RequestMapping("/roomoutOk")
	public String  roomoutOk(int sg_id, String id, Model model) {
		model.addAttribute("result", memberStudyService.outStatus(sg_id, id));
		
		return "group/roomoutOk";
	}
	
}
