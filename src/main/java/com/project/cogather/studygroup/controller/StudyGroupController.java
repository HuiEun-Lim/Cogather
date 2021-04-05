package com.project.cogather.studygroup.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cogather.members.service.MembersService;
import com.project.cogather.memberstudy.service.MemberStudyService;

@Controller
@RequestMapping("/group")
public class StudyGroupController {
	
	@Autowired
	MembersService membersService;

	@Autowired
	MemberStudyService memberStudyService;
	
	@RequestMapping("/studygroup")
	public String studymain(Model model) {
		model.addAttribute("test", membersService.selectMembers());
		return "group/studygroup";
	}
	// 스터디 룸으로 들어온 상태
	@RequestMapping("/studyroom")
	public String studyroom(int sg_id, String id ,Model model) {
		model.addAttribute("studyMemberList", memberStudyService.select(sg_id));
		model.addAttribute("studyMemberdetails", memberStudyService.selectMembersBySGId(sg_id));
		model.addAttribute("sg_id", sg_id);
		model.addAttribute("id", id);
		return "group/studyroom";
	}
	// 스터디 룸으로 들어가기전 해당 id가 방에 가입상태인지 파악
	@RequestMapping("/roomenterOk")
	public String roomenterOk(int sg_id, String id, Model model) {
		model.addAttribute("result", memberStudyService.enterStatus(sg_id, id));
		model.addAttribute("sg_id", sg_id);
		model.addAttribute("id", id);
		
		return "group/roomenterOk";
	}
	// 스터디 룸을 나가기전 누적 시간 저장
	@RequestMapping("/roomoutOk")
	public String  roomoutOk(int sg_id, String id, Model model) {
		model.addAttribute("result", memberStudyService.outStatus(sg_id, id));
		
		return "group/roomoutOk";
	}
	
}