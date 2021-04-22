package com.project.cogather.members.controller;

import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.cogather.members.model.MembersDTO;
import com.project.cogather.members.model.MembersResult;
import com.project.cogather.members.service.MembersService;

@RequestMapping("/members")
@RestController
public class RestMembersController {
	@Autowired
	MembersService membersService;
	
	@GetMapping("/{id}")
	public MembersResult selectMemberById(@NotNull @Pattern(regexp = "^[0-9a-zA-Z가-힣]*$") @PathVariable String id) {
		MembersResult result = new MembersResult();
		String status = "FAIL";
		StringBuffer message = new StringBuffer();
		int cnt = 0;
		
		List<MembersDTO> list = null;
		
		try {
			list = membersService.selectMemberById(id);
			
			if(list == null || list.size() == 0) {
				message.append("멤버 정보가 존재 하지 않습니다.");
			}else {
				cnt = list.size();
				status = "OK";
				
			}
		}catch(Exception e) {
			message.append("트랜잭션 에러: " + e.getMessage());
		}
		
		result.setCnt(cnt);
		result.setData(list);
		result.setMessage(status);
		result.setStatus(status);
		return result;
	}
}
