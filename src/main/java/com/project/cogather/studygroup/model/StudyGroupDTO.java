package com.project.cogather.studygroup.model;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class StudyGroupDTO {
	private int sg_id;
	private String sg_name;
	private String sg_info;
	private int sg_max;
	private LocalDateTime sg_regdate;
	private String sg_tag;
	private String kko_url;
}
