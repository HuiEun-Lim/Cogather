package com.project.cogather.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.cogather.controller.StudyController;
import com.project.cogather.domain.StudyGroupDTO;
import com.project.cogather.domain.StudyGroupFileDTO;

@Component
public class StudyGroupFileUtils {

	private static final String filePath="C:\\tomcat\\upload";
	String sgf_org_file_name = null;
	String originalFileExtension = null;
	String sgf_stored_file_name = null;
	int sgf_file_size;
	
	
	
	public StudyGroupFileUtils() {
		super();
	}

	public StudyGroupFileUtils(String sgf_org_file_name, String originalFileExtension, String sgf_stored_file_name,
			int sgf_file_size) {
		super();
		this.sgf_org_file_name = sgf_org_file_name;
		this.originalFileExtension = originalFileExtension;
		this.sgf_stored_file_name = sgf_stored_file_name;
		this.sgf_file_size = sgf_file_size;
	}
	
	public List<Map<String,Object>> parseInsertFileInfo(StudyGroupDTO dto,
			MultipartHttpServletRequest mpRequest) throws IllegalStateException, IOException {
				
		Iterator<String> iterator = mpRequest.getFileNames();
		MultipartFile multipartFile =null;
		sgf_org_file_name = null;
		originalFileExtension = null;
		sgf_stored_file_name = null;
		sgf_file_size=0;
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();

		Map<String,Object> listMap = null;
		int sg_id = dto.getSg_id();
		File file = new File(filePath);
		if(file.exists() == false) {
			file.mkdir();
		}
		
		while(iterator.hasNext()) {
			multipartFile = mpRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false) {
				sgf_org_file_name = multipartFile.getOriginalFilename();
				originalFileExtension = sgf_org_file_name.substring(sgf_org_file_name.lastIndexOf("."));
				sgf_stored_file_name = getRandomString() + originalFileExtension;
				
				file = new File(filePath + sgf_stored_file_name);
				multipartFile.transferTo(file);
				listMap = new HashMap<String, Object>();
				listMap.put("sg_id", sg_id);
				listMap.put("sgf_org_file_name", sgf_org_file_name);
				listMap.put("sgf_stored_file_name", sgf_stored_file_name);
				listMap.put("sgf_file_size", multipartFile.getSize());
				sgf_file_size = (int) multipartFile.getSize();
				list.add(listMap);
			
				StudyGroupFileDTO fdto = new StudyGroupFileDTO(sgf_org_file_name,sgf_stored_file_name,sgf_file_size,sg_id);
				fdto.getSgf_org_file_name();
			//	StudyController scr = new StudyController(fdto.getSgf_org_file_name(),fdto.getSgf_stored_file_name());
				System.out.println("util"+fdto.getSg_id());
				fdto.getSgf_stored_file_name();
			}
		}
		return list;
		
	}
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	public String getSgf_org_file_name() {
		return sgf_org_file_name;
	}
	public void setSgf_org_file_name(String sgf_org_file_name) {
		this.sgf_org_file_name = sgf_org_file_name;
	}
	public String getSgf_stored_file_name() {
		return sgf_stored_file_name;
	}
	public void setSgf_stored_file_name(String sgf_stored_file_name) {
		this.sgf_stored_file_name = sgf_stored_file_name;
	}
	public int getSgf_file_size() {
		System.out.println("유틸 안 "+sgf_file_size);
		return sgf_file_size;
	}
	public void setSgf_file_size(int sgf_file_size) {
		this.sgf_file_size = sgf_file_size;
	}
	
	
}
