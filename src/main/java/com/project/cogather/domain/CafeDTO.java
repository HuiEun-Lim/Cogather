package com.project.cogather.domain;

<<<<<<< HEAD
public class CafeDTO {

}
=======
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;

public class CafeDTO {
	private int res_id; // 예약번호 res_id : number
	private String ID;  // 예약한 회원 ID, ID:String
	private String seat_id;    // 예약한 시설번호 seat_id : String
	@JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonSerialize(using = LocalDateTimeSerializer.class)
   @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone="Asia/Seoul")
	private LocalDateTime start_date; //예약 시작날짜
	@JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonSerialize(using = LocalDateTimeSerializer.class)
   @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone="Asia/Seoul")
	private LocalDateTime end_date;
	private String payment; //결제 방법
	private int seat_price;
	
	public CafeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public CafeDTO(int res_id, String ID, String seat_id, LocalDateTime start_date, LocalDateTime end_date,
			String payment, int seat_price) {
		super();
		this.res_id = res_id;
		this.ID = ID;
		this.seat_id = seat_id;
		this.start_date = start_date;
		this.end_date = end_date;
		this.payment = payment;
		this.seat_price = seat_price;
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
		return start_date;
	}
	

	public void setStart_date(LocalDateTime start_date) {
		this.start_date = start_date;
	}
	
//  Date 를 String 으로 리턴하는 getter
	public String getStart_dateTime() {
		if(this.start_date == null) return "";
		return this.start_date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm"));
	}

	public LocalDateTime getEnd_date() {
		return end_date;
	}


	public void setEnd_date(LocalDateTime end_date) {
		this.end_date = end_date;
	}
	
	public String getEnd_dateTime() {
		if(this.end_date == null) return "";
		return this.end_date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm"));
	}

	public String getPayment() {
		return payment;
	}


	public void setPayment(String payment) {
		this.payment = payment;
	}
	
	public void setStartdate(String startdate) {
		this.start_date = LocalDateTime.parse(startdate);
		System.out.println("받아온시작날짜" + start_date);
	}
		
	public void setEnddate(String enddate) {
		this.end_date = LocalDateTime.parse(enddate);
		System.out.println("받아온종료날짜" + end_date);

	}


	public int getSeat_price() {
		return seat_price;
	}


	public void setSeat_price(int seat_price) {
		this.seat_price = seat_price;
	}
	
} //end DTO
>>>>>>> origin/cafersv
