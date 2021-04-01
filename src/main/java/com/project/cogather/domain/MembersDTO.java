package com.project.cogather.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MembersDTO {
	private String id; 
	private String name; 
	private String pw;
	private String phone;
	private String email; 
	private String pimg_url;
	private String tag;
	
}
