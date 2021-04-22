package com.project.cogather.studygroup.model;

import java.time.LocalDateTime;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StudyGroupDTO {
	private int sg_id;
	private String sg_info;
	private String sg_name;
	private int sg_max;
	private String id;
	private LocalDateTime sg_regdate;
	private String sg_tag;
	private String kko_url;
	private String file_name;
	private MultipartFile uploadFile;
	private boolean isImage;

}
