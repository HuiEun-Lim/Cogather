package com.project.cogather.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.cogather.domain.StudyGroupDTO;
import com.project.cogather.domain.StudyGroupFileDTO;
import com.project.cogather.domain.StudyGroupPaging;
import com.project.cogather.domain.StudyGroupSearch;
import com.project.cogather.service.StudyGroupService;
import com.project.cogather.util.StudyGroupFileUtils;

@Controller
@RequestMapping("/group")
public class StudyController {

	private StudyGroupService studygroupservice;
	
	@Autowired
	public void setStudyGroupService(StudyGroupService studygroupservice) {
		this.studygroupservice = studygroupservice;
	}
	
	public StudyController() {
		// TODO Auto-generated constructor stub
		System.out.println("생성");
	}
	//페이징 게시판  임시
	@RequestMapping("/studylist")
	public String studylist(StudyGroupPaging sp, Model model
			, @RequestParam(value="nowPage", required=false,defaultValue = "1")String nowPage
			, @RequestParam(value="cntPerPage", required=false,defaultValue = "9")String cntPerPage) {
		
		int total = studygroupservice.countBoard();
		/*
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "9";
		} else if (nowPage == null) {
			nowPage = "9";
		} else if (cntPerPage == null) { 
			cntPerPage = "9";
		}
		*/
		sp = new StudyGroupPaging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		//sp.pageInfo(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
	
		model.addAttribute("paging", sp);
		//model.addAttribute("list", studygroupservice.list());
		model.addAttribute("list", studygroupservice.selectBoard(sp));
		return "group/studylist";
	}
	
	@RequestMapping("/studygroup")
	public String studymain(Model model) {
		model.addAttribute("list", studygroupservice.list_recent());
		return "group/studygroup";
	}
	
//	@RequestMapping("/studylist")
//	public String studylist(Model model) {
//		model.addAttribute("list", studygroupservice.list());
//		return "group/studylist";
//	}
	@RequestMapping("/studywrite")
	public String studywrite(Model model) {
		
		
		
		
		return "group/studywrite";
	}
	@RequestMapping(value="/studywriteOk")
	public String studywriteOk(StudyGroupDTO dto,MultipartHttpServletRequest mpRequest,Model model) throws Exception {
		
		
		
		//썸네일 업로드 
		String file_name=null;
		MultipartFile uploadFile = dto.getUploadFile();
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			file_name=uuid+"."+ext;
			uploadFile.transferTo(new File("D:\\DevRoot\\Dropbox\\App04\\CoGather\\Cogather\\src\\main\\webapp\\img\\group"+file_name));
			
		}
		
		dto.setFileName(file_name);
		//썸네일 업로드 끝
		StudyGroupFileDTO fdto = null;
		model.addAttribute("result", studygroupservice.write(dto, fdto, mpRequest));

		return "group/studywriteOk";
	}
	
	@GetMapping("/studyview")
	public String studyview(int sg_id,Model model) {
		StudyGroupFileDTO fdto = null;
		model.addAttribute("list", studygroupservice.viewByUid(sg_id));
		List<Map<String,Object>> fileList = studygroupservice.selectFile(sg_id);
		
		model.addAttribute("files",fileList);
		
		return "group/studyview";
	}
	@RequestMapping("/studyupdate")
	public String update (int sg_id,Model model) {
		model.addAttribute("list", studygroupservice.selectByUid(sg_id));
		return "group/studyupdate";
	}
	@PostMapping("/studyupdateOk")
	public String updateOk(StudyGroupDTO dto,Model model) {
		model.addAttribute("result", studygroupservice.update(dto));
		return "group/studyupdateOk";
	}
	@GetMapping("/studydeleteOk")
	public String deleteOk(int sg_id,Model model) {
		model.addAttribute("result", studygroupservice.deleteByUid(sg_id));
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
	
}
