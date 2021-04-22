package com.project.cogather.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.cogather.domain.CafeDTO;
import com.project.cogather.service.CafeService;

@RestController
public class RestReservationController {
	@Autowired
	CafeService cafeService;
	@GetMapping("/studycafe/dateResult")
	public RestReservationResult getDates(String seat_id) {
		RestReservationResult result = new RestReservationResult();
		int cnt = 0;
		String status = "fail";
		StringBuffer message = new StringBuffer();
		List<CafeDTO> chkdates = null;
		try {
		chkdates = cafeService.selectDate(seat_id);
		if(chkdates == null || chkdates.size() == 0) {
			message.append("예약 데이터가 없습니다");
		}
		else {
			cnt = chkdates.size();
			status = "success";
		}
		} catch(Exception e) {
			message.append(e.getMessage());
		}
		
		result.setCnt(cnt);
		result.setMessage(message.toString());
		result.setStatus(status);
		result.setChkdates(chkdates);
		
		return result;
	}

	@GetMapping("/studycafe/adminResult")
	public AdminRsvResult adminview() {
		AdminRsvResult result = new AdminRsvResult();
		int cnt = 0;
		String status = "fail";
		StringBuffer message = new StringBuffer();
		List<CafeDTO> adminrsvs = null;
		try {
			adminrsvs = cafeService.adminview();
			if(adminrsvs == null || adminrsvs.size() == 0) {
				message.append("예약 데이터가 없습니다");
			}
			else {
				cnt = adminrsvs.size();
				status = "success";
			}
		} catch(Exception e) {
			message.append(e.getMessage());
		}
		
		result.setCnt(cnt);
		result.setMessage(message.toString());
		result.setStatus(status);
		result.setAdminrsvs(adminrsvs);
		
		return result;
	}
	
	
}
