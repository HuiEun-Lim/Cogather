package com.project.cogather.content.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ContentFileDTO {
	private Integer cf_id;
	private String cf_source;
	private String cf_file;
	private Integer ct_uid;
	
	
}
