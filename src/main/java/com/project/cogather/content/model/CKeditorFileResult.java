package com.project.cogather.content.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CKeditorFileResult {
	private	int uploaded;
	private String fileName;
	private String url;
	private CKeditorFileError error;
}
