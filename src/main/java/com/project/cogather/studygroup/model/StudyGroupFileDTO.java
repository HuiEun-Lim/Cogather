package com.project.cogather.studygroup.model;

public class StudyGroupFileDTO {

	String sgf_org_file_name = null;
	String sgf_stored_file_name = null;
	int sgf_file_size;
	int sg_id;
	
	
	public StudyGroupFileDTO() {
		super();
		
	}

	
	static int sg_id1;
	public StudyGroupFileDTO(String sgf_org_file_name, String sgf_stored_file_name, int sgf_file_size,int sg_id1) {
		super();
		this.sgf_org_file_name = sgf_org_file_name;
		this.sgf_stored_file_name = sgf_stored_file_name;
		this.sgf_file_size = sgf_file_size;
		this.sg_id = sg_id1;
	
		
	}


	

	public StudyGroupFileDTO(String sgf_org_file_name, String sgf_stored_file_name) {
		super();
		this.sgf_org_file_name = sgf_org_file_name;
		this.sgf_stored_file_name = sgf_stored_file_name;
	}




	public String getSgf_org_file_name() {
		System.out.println(sgf_org_file_name);
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
		return sgf_file_size;
	}


	public void setSgf_file_size(int sgf_file_size) {
		this.sgf_file_size = sgf_file_size;
	}


	public int getSg_id() {
		System.out.println("함수안에서 sg_id "+sg_id);
		return sg_id;
	}


	public void setSg_id(int sg_id) {
		
		this.sg_id = sg_id;
	}


	
	

	
	
	
	
	
}
