package com.project.cogather.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.cogather.domain.MemberStudyDTO;
import com.project.cogather.domain.MemberStudyResult;
import com.project.cogather.domain.MembersDTO;
import com.project.cogather.service.MemberStudyService;

@RestController
@RequestMapping("/group/MemberStudyRest")
public class RestMemberStudyController {
	
	@Autowired
	MemberStudyService memberStudyService;
	
	
	@GetMapping("/ms/{sg_id}")
	public MemberStudyResult getMemberStudy(@PathVariable int sg_id){
		MemberStudyResult result = new MemberStudyResult();
		List<MemberStudyDTO> ms = null;
		List<MembersDTO> m = null;
		ms = memberStudyService.select(sg_id);
		m = memberStudyService.selectMembersBySGId(sg_id);
		int cnt = 0; 
		String status = "fail"; 
		StringBuilder message = new StringBuilder(); 
		if(ms == null || ms.size() == 0) {
			message.append("StudyGroup data 가져오기 실패");
		}else {
			status = "OK";
			cnt = ms.size();
		}
		
		result.setCnt(cnt);
		result.setMessage(message.toString());
		result.setStatus(status);
		result.setMSdata(ms);
		result.setMdata(m);
		return result;
	}
}
