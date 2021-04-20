package com.project.cogather.domain;

public class UserDTO {
	private String id;
	private String pw;
	private String name;
	private String phone;
	private String email;
	private String tag;
	private String pimg_url;
	private String auth;
	
	public UserDTO() { super(); }
	
	public UserDTO(String id, String pw, String name, String phone, String email, String tag, String pimg_url, String auth) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.tag = tag;
		this.pimg_url = pimg_url;
		this.auth = auth;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}
	

	public String getPimg_url() {
		return pimg_url;
	}

	public void setPimg_url(String pimg) {
		this.pimg_url = pimg;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}
	
}
