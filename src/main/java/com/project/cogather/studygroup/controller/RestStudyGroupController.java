package com.project.cogather.studygroup.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.cogather.memberstudy.model.MemberStudyDTO;
import com.project.cogather.memberstudy.service.MemberStudyService;
import com.project.cogather.studygroup.model.StudyGroupDTO;
import com.project.cogather.studygroup.model.StudyGroupResult;
import com.project.cogather.studygroup.service.StudyGroupService;

@RestController
public class RestStudyGroupController {
	@Autowired
	StudyGroupService studygroupservice;
	@Autowired
	MemberStudyService memberStudyService;
	
	@RequestMapping("/group/myPage/{id}")
	public StudyGroupResult myPage(@PathVariable String id) {
		StudyGroupResult result = new StudyGroupResult();
		int cnt = 0;
		String status = "fail";
		StringBuffer message = new StringBuffer();
		List<StudyGroupDTO> data = null;
		List<MemberStudyDTO> ms = null;
		try {
			data = studygroupservice.getStudyByID(id);
			ms = memberStudyService.getMemberStudyByID(id);
			if(data == null || data.size() == 0 || ms == null || ms.size() == 0) {
				message.append("가입하신 스터디가 없습니다.");
			}else {
				status = "OK";
				result.setData(data);
				result.setMs(ms);
				cnt = data.size();
			}
			
		}catch(Exception e) {
			message.append(e.getMessage());
		}
		result.setCnt(cnt);
		result.setStatus(status);
		result.setMessage(message.toString());
		result.setId(id);
		
		return result;
	}
}
