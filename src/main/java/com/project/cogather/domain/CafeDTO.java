package com.project.cogather.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CafeDTO {
	private int res_id; // 예약번호 res_id : number
	private String ID;  // 예약한 회원 ID, ID:String
	private String seat_id;    // 예약한 시설번호 seat_id : String
	private LocalDateTime start_date; //예약 시작날짜
	private LocalDateTime end_date;
	private String payment; //결제 방법
	
	
	public CafeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public CafeDTO(int res_id, String ID, String seat_id, LocalDateTime start_date, LocalDateTime end_date,
			String payment) {
		super();
		this.res_id = res_id;
		this.ID = ID;
		this.seat_id = seat_id;
		this.start_date = start_date;
		this.end_date = end_date;
		this.payment = payment;
		System.out.printf("CafeDTO(%d, %s, %s, %s, %s, %s) 객체 생성\n", res_id, ID, seat_id, start_date, end_date, payment);
	}


	public int getRes_id() {
		return res_id;
	}


	public void setRes_id(int res_id) {
		this.res_id = res_id;
	}


	public String getID() {
		return ID;
	}


	public void setID(String iD) {
		this.ID = iD;
	}


	public String getSeat_id() {
		return seat_id;
	}


	public void setSeat_id(String seat_id) {
		this.seat_id = seat_id;
	}


	public LocalDateTime getStart_date() {
		System.out.println(start_date+"시작날짜");
		return start_date;
	}
	

	public void setStart_date(LocalDateTime start_date) {
		System.out.println(start_date+"시작날짜!!");
		this.start_date = start_date;
	}
	
//  Date 를 String 으로 리턴하는 getter
	public String getStart_dateTime() {
		if(this.start_date == null) return "";
		return this.start_date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh"));
	}

	public LocalDateTime getEnd_date() {
		return end_date;
	}


	public void setEnd_date(LocalDateTime end_date) {
		this.end_date = end_date;
	}
	
	public String getEnd_dateTime() {
		if(this.end_date == null) return "";
		return this.end_date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
	}

	public String getPayment() {
		return payment;
	}


	public void setPayment(String payment) {
		this.payment = payment;
	}
		
	
	
} //end DTO
