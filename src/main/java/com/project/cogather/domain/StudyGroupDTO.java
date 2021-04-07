package com.project.cogather.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.web.multipart.MultipartFile;


public class StudyGroupDTO {

	private int sg_id;
	private String sg_info;
	private String sg_name;
	private int sg_max;
	private LocalDateTime sg_regdate;
	private String sg_tag;
	private String kko_url;
	private String file_name;
	private MultipartFile uploadFile;
	private boolean isImage;
	
	public StudyGroupDTO() {
		super();
	}


	public StudyGroupDTO(int sg_id, String sg_info, String sg_name, int sg_max, LocalDateTime sg_regdate, String sg_tag,
			String kko_url, String file_name, MultipartFile uploadFile) {
		super();
		this.sg_id = sg_id;
		this.sg_info = sg_info;
		this.sg_name = sg_name;
		this.sg_max = sg_max;
		this.sg_regdate = sg_regdate;
		this.sg_tag = sg_tag;
		this.kko_url = kko_url;
		this.file_name = file_name;
		this.uploadFile = uploadFile;
	}





	public String getSg_name() {
		return sg_name;
	}


	public void setSg_name(String sg_name) {
		this.sg_name = sg_name;
	}


	public int getSg_id() {
		return sg_id;
	}

	public void setSg_id(int sg_id) {
		this.sg_id = sg_id;
	}

	public String getSg_info() {
		return sg_info;
	}

	public void setSg_info(String sg_info) {
		this.sg_info = sg_info;
	}

	public int getSg_max() {
		return sg_max;
	}

	public void setSg_max(int sg_max) {
		this.sg_max = sg_max;
	}

	public LocalDateTime getSg_regDate() {
		return sg_regdate;
	}

	public void setSg_regDate(LocalDateTime sg_regdate) {
		this.sg_regdate = sg_regdate;
	}

	public String getSg_tag() {
		return sg_tag;
	}

	public void setSg_tag(String sg_tag) {
		this.sg_tag = sg_tag;
	}

	public String getKko_url() {
		return kko_url;
	}

	public void setKko_url(String kko_url) {
		this.kko_url = kko_url;
	}

	public String getRegDateTime() {
		if(this.sg_regdate == null) return "";
		return this.sg_regdate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
	
	}


	public String getFileName() {
		return file_name;
	}


	public void setFileName(String file_name) {
		this.file_name = file_name;
		System.out.println(file_name);
	}


	public MultipartFile getUploadFile() {
		return uploadFile;
	}


	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}


	public boolean isImage() {
		return isImage;
	}


	public void setImage(boolean isImage) {
		this.isImage = isImage;
	}


	@Override
	public String toString() {
		return "StudyGroupDTO [sg_id=" + sg_id + ", sg_info=" + sg_info + ", sg_name=" + sg_name + ", sg_max=" + sg_max
				+ ", sg_regdate=" + sg_regdate + ", sg_tag=" + sg_tag + ", kko_url=" + kko_url + ", file_name="
				+ file_name + ", uploadFile=" + uploadFile + ", isImage=" + isImage + "]";
	}
	
	
	

	
	
	
	
}
