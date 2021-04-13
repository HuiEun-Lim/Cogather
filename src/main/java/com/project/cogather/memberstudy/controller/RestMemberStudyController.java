package com.project.cogather.memberstudy.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.cogather.common.AjaxResult;
import com.project.cogather.members.model.MembersDTO;
import com.project.cogather.memberstudy.model.MemberStudyDTO;
import com.project.cogather.memberstudy.model.MemberStudyResult;
import com.project.cogather.memberstudy.model.MemberStudyUserResult;
import com.project.cogather.memberstudy.service.MemberStudyService;

@RestController
@RequestMapping("/group/MemberStudyRest")
public class RestMemberStudyController {

	@Autowired
	MemberStudyService memberStudyService;

	@GetMapping("/{sg_id}")
	public MemberStudyUserResult getUserList(@PathVariable int sg_id) {
		MemberStudyUserResult result = new MemberStudyUserResult();
		List<MemberStudyDTO> rdata = null;
		List<MembersDTO> rmember = null;
		List<MemberStudyDTO> cdata = null;
		List<MembersDTO> cmember = null;
		
		int cnt = 0;
		String status = "fail";
		StringBuilder message = new StringBuilder();
		
		try {
			System.out.println("check0");
			rdata = memberStudyService.selectRegister(sg_id);
			System.out.println("check1");
			rmember = memberStudyService.selectRegisterMember(sg_id);
			System.out.println("check2");
			cdata = memberStudyService.selectCommon(sg_id);
			System.out.println("check3");
			cmember = memberStudyService.selectCommonMember(sg_id);
			System.out.println("check4");
			
			if (rdata == null || rdata.size() == 0 || rmember == null || rmember.size() == 0) {
				message.append("생성자는 어디 있냐");
				
			}else {
				status = "OK";
			}
			
			if (cdata == null || cdata.size() == 0 || cmember == null || cmember.size() == 0) {
				message.append("참가 신청한 인원이 없음");
			}
			
		}catch(Exception e) {
			message.append("트랜잭션 에러: " + e.getMessage());
		}
		
		result.setMessage(message.toString());
		result.setStatus(status);
		result.setRdata(rdata);
		result.setRmember(rmember);
		result.setCdata(cdata);
		result.setCmember(cmember);
		
		return result;
	}
	

	// memberStudy 에서 studygroup 아이디에 따라 참여하고 있는 멤버데이터를 json으로 반환하는 핸드
	@GetMapping("/ms/{sg_id}")
	public MemberStudyResult getMemberStudy(@PathVariable int sg_id) {
		MemberStudyResult result = new MemberStudyResult();
		List<MemberStudyDTO> ms = null;
		List<MembersDTO> m = null;
		ms = memberStudyService.select(sg_id);
		m = memberStudyService.selectMembersBySGId(sg_id);
		int cnt = 0;
		String status = "fail";
		StringBuilder message = new StringBuilder();
		if (ms == null || ms.size() == 0 || m == null || m.size() == 0) {
			message.append("StudyGroup data 가져오기 실패");
		} else {
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

	// 방번호와 유저 아이디를 통해 누적시간 저장
	@PutMapping("/ms/acctime")
	public AjaxResult updateAcctime(int sg_id, String id, String acctime) {
		AjaxResult result = new AjaxResult();
		int cnt = 0;
		String status = "fail";
		StringBuilder message = new StringBuilder();

		List<MemberStudyDTO> ms = memberStudyService.getAcctime(sg_id, id);
		if (ms == null || ms.size() == 0) {
			message.append("Acctime data가 없음");
		}

		if (ms.get(0).getAcctime() == null) {
			System.out.println("tets");
			cnt = memberStudyService.updateAcctime(sg_id, id,
					LocalDateTime.parse(acctime, DateTimeFormatter.ISO_DATE_TIME));
		} else {
			LocalDateTime temp = ms.get(0).getAcctime();

			LocalDateTime time = LocalDateTime.parse(acctime, DateTimeFormatter.ISO_DATE_TIME);
			LocalDateTime baseTime = LocalDateTime.of(1900, 1, 1, 15, 32, 8); 
			// var time = new Date(0, 0, 2, temp[0], temp[1], temp[2]);
			// javascript 에서 위의 기준으로 맞춘 시간이 baseTime 기준 시간임.

			temp = temp.plusSeconds(time.minusSeconds(baseTime.getSecond()).getSecond());
			temp = temp.plusMinutes(time.minusMinutes(baseTime.getMinute()).getMinute());
			temp = temp.plusHours(time.minusHours(baseTime.getHour()).getHour());
			temp = temp.plusMonths(time.minusMonths(baseTime.getMonthValue()).getMonthValue());
			temp = temp.plusYears(time.minusYears(baseTime.getYear()).getYear());
			cnt = memberStudyService.updateAcctime(sg_id, id, temp);
		}

		if (cnt == 0) {
			message.append("Acctime update 실패");
		} else {
			status = "OK";
		}
		result.setCnt(cnt);
		result.setMessage(message.toString());
		result.setStatus(status);
		return result;
	}

	// 스터디 룸 나가기
	@GetMapping("ms/roomoutOk")
	public AjaxResult roomoutOk(int sg_id, String id, Model model) {
		AjaxResult result = new AjaxResult();
		int cnt = 0;
		String status = "fail";
		StringBuilder message = new StringBuilder();
		
		cnt = memberStudyService.outStatus(sg_id, id);
		if (cnt == 0) {
			message.append("방 상태 변경 못함");
		} else {
			status = "OK";
		}

		result.setCnt(cnt);
		result.setMessage(message.toString());
		result.setStatus(status);
		System.out.println("퇴실중"+status);
		return result;
	}

	// 스터디 룸 들어오기
	@GetMapping("ms/roomenter")
	public AjaxResult roomenter(int sg_id, String id, Model model) {
		AjaxResult result = new AjaxResult();
		int cnt = 0;
		String status = "fail";
		StringBuilder message = new StringBuilder();

		cnt = memberStudyService.enterStatus(sg_id, id);

		if (cnt == 0) {
			message.append("방 상태 변경 못함");
		} else {
			status = "OK";
		}
		result.setCnt(cnt);
		result.setMessage(message.toString());
		result.setStatus(status);
		return result;
	}

		//스터디 신청
		@GetMapping("/ms/{sg_id}/{id}")
		public AjaxResult RegisterRoom(@PathVariable String id,@PathVariable int sg_id){
			AjaxResult result = new AjaxResult();
			
			
			int cnt = 0; 
			String status = "fail"; 
			StringBuilder message = new StringBuilder(); 
		
			try {
				cnt = memberStudyService.createCommon(id, sg_id);
				if(cnt !=0) {
					status="Ok";
				}
			}catch (Exception e){
				message.append("error:"+e.getMessage());
			}
			result.setCnt(cnt);
			result.setMessage(message.toString());
			result.setStatus(status);
			
			return result;
		}
		
		@PutMapping("/ms/{sg_id}/{id}")
		public AjaxResult UpdateCrew(@PathVariable String id,@PathVariable int sg_id){
			AjaxResult result = new AjaxResult();
			
			
			int cnt = 0; 
			String status = "fail"; 
			StringBuilder message = new StringBuilder(); 
		
			try {
				cnt = memberStudyService.updateCrew(id, sg_id);
				if(cnt !=0) {
					status="Ok";
				}
			}catch (Exception e){
				message.append("error:"+e.getMessage());
			}
			result.setCnt(cnt);
			result.setMessage(message.toString());
			result.setStatus(status);
			
			return result;
		}
		
		

}
