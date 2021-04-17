package com.project.cogather.studygroup.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.cogather.chat.service.RedisService;
import com.project.cogather.studygroup.model.StudyGroupFileDTO;
import com.project.cogather.studygroup.model.StudyGroupPaging;
import com.project.cogather.members.service.MembersService;
import com.project.cogather.memberstudy.model.MemberStudyDTO;
import com.project.cogather.memberstudy.service.MemberStudyService;
import com.project.cogather.studygroup.model.StudyGroupDTO;
import com.project.cogather.studygroup.service.StudyGroupService;

@Controller
@RequestMapping("/group")
public class StudyGroupController {
	
	@Autowired
	MembersService membersService;

	@Autowired
	MemberStudyService memberStudyService;
	@Autowired
	RedisService redisService;
	@Autowired
	StudyGroupService studygroupservice;
	@Autowired
	private JavaMailSender mailSender;
	
	
	//페이징 게시판  임시
		@RequestMapping("/studylist")
		public String studylist(StudyGroupPaging sp, Model model
				, @RequestParam(value="nowPage", required=false,defaultValue = "1")String nowPage
				, @RequestParam(value="cntPerPage", required=false,defaultValue = "9")String cntPerPage
				, @RequestParam(required = false, defaultValue = "title") String searchType
				, @RequestParam(required = false) String keyword
				) {
			
			int total = studygroupservice.countBoard(sp);
			sp.setTotal(total);
			System.out.println("방 개수"+total);
			sp.getTotal();
			
			sp = new StudyGroupPaging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			//sp.pageInfo(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			sp.setSearchType(searchType);
			sp.setKeyword(keyword);
			
			model.addAttribute("paging", sp);
			//model.addAttribute("list", studygroupservice.list());
			model.addAttribute("list", studygroupservice.selectBoard(sp));
			total = studygroupservice.countBoard(sp);
			sp.setTotal(total);
			System.out.println("방 개수2: "+sp.getTotal());
			return "group/studylist";
		}
		
		@RequestMapping("/studygroup")
		public String studymain(Model model) {
			model.addAttribute("list", studygroupservice.list_recent());
			return "group/studygroup";
		}
		
//		@RequestMapping("/studylist")
//		public String studylist(Model model) {
//			model.addAttribute("list", studygroupservice.list());
//			return "group/studylist";
//		}
		@RequestMapping("/studywrite")
		public String studywrite(Model model) {
			
			
			
			
			return "group/studywrite";
		}
		@RequestMapping(value="/studywriteOk")
		public String studywriteOk(StudyGroupDTO dto,MultipartHttpServletRequest mpRequest,Model model) throws Exception {

			//1.상대경로 바꾸기 2.물리적인 파일 같이 삭제하기  
			//첨부파일 썸네일 하나의 함수로 
			//memberstudy captain 자격으로  
			model.addAttribute("result", studygroupservice.write(mpRequest));
			
		//	memberStudyService.createCaptain('id1')
			
			return "group/studywriteOk";
		}
		
		@GetMapping("/studyview")
		public String studyview(int sg_id,Model model) {
			StudyGroupFileDTO fdto = null;
			model.addAttribute("list", studygroupservice.viewByUid(sg_id));
			
			List<Map<String,Object>> fileList = studygroupservice.selectFile(sg_id);
			
			model.addAttribute("files",fileList);
			model.addAttribute("sg_id", sg_id);
			return "group/studyview";
		}
		@RequestMapping("/studyupdate")
		public String update (int sg_id,Model model) {
			model.addAttribute("list", studygroupservice.selectByUid(sg_id));
			List<Map<String,Object>> fileList = studygroupservice.selectFile(sg_id);
			
			model.addAttribute("files",fileList);
			return "group/studyupdate";
		}
		@PostMapping("/studyupdateOk")
		public String updateOk(StudyGroupDTO dto,MultipartHttpServletRequest mpRequest,Model model) throws Exception {
			model.addAttribute("result", studygroupservice.update(dto,mpRequest));
			return "group/studyupdateOk";
		}
		@GetMapping("/studydeleteOk")
		public String deleteOk(int sg_id,Model model) {
			model.addAttribute("result", studygroupservice.deleteByUid(sg_id));
			model.addAttribute("result", studygroupservice.deleteFileByUid(sg_id));
			return "group/studydeleteOk";
		}
		@GetMapping("/studydeleteFileOk")
		public String deleteFileOk(int sgf_id,Model model) {
			model.addAttribute("result", studygroupservice.deleteFileByUid(sgf_id));
			return "group/studydeleteOk";
		}
		
		@RequestMapping(value="/fileDown")
		public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response,Model model) throws Exception{
			
			Map<String, Object> resultMap=studygroupservice.selectFileInfo(map);
			model.addAttribute("rmap",resultMap);
			System.out.println("fdfdfssdfd"+resultMap.toString());	
			String storedFileName = (String) resultMap.get("SGF_STORED_FILE_NAME");
			String originalFileName = (String) resultMap.get("SGF_ORG_FILE_NAME");
			
			// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
			byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\\\tomcat\\"+"upload"+storedFileName));
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
		}
		
		//메일 보내기 기능
		@RequestMapping("/mailSending")
		public String mailSending(HttpServletRequest request) {

			String setfrom = "``";
			//String frommail = request.getParameter("frommail"); // 받는 사람 이메일
			String tomail = request.getParameter("tomail"); // 받는 사람 이메일
			String title = request.getParameter("title"); // 제목
			String content = request.getParameter("content"); // 내용

			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message,
						true, "UTF-8");

			//	messageHelper.setFrom(frommail); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(tomail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}

			return "group/mail";
		}	
	// 스터디 룸으로 들어온 상태
	@PostMapping("/studyroom")
	public String studyroom(int sg_id, String id ,Model model) {
		model.addAttribute("studyGroupBYSGID", studygroupservice.selectByUid(sg_id));
		model.addAttribute("sg_id", sg_id);
		model.addAttribute("id", id);
		redisService.enterChatRoom(sg_id); // redis topic 리스너 활성화
		return "group/studyroom";
	}
	// 스터디 룸으로 들어가기전 해당 id가 방에 가입상태인지 파악
	@RequestMapping("/roomenterOk")
	public String roomenterOk(int sg_id, String id, Model model) {
		int result = memberStudyService.enterStatus(sg_id, id);
		model.addAttribute("result", result);
		List<MemberStudyDTO> temp = memberStudyService.select(sg_id);
		
		model.addAttribute("sg_id", sg_id);
		model.addAttribute("id", id);
		
		return "group/roomenterOk";
	}
	
	
}
