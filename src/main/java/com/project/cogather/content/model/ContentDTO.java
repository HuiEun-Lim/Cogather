package com.project.cogather.content.model;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ContentDTO {
	Integer	ct_uid;
	String id;
	Integer sg_id;
	String ct_title;
	String ct_content;
	Integer ct_viewcnt;
	LocalDateTime regdate;
}