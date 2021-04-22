package com.project.cogather.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Date;

import javax.sql.DataSource;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/*
 * 스프링에서는 자동으로 클래스 간 여러 의존주입이 발생하기 때문에
 * 다른 클래스에서 작성한 코드들을 사용할 수 있지만, JUnit 은 테스트 케이스 부분만 실행하기 때문에
 * 빈 자동 등록이나 의존주입이 일어나지 않습니다.
 * 따라서! @Service 나 @Mapper 가 붙은 클래스나 인터페이스도 쓰지 못하게 됩니다.
 * 이럴때는
 * @RunWith와 @ContextConfiguration을 이용합니다
 * 
 * 위와 같이 하면 JUnit 테스트를 실행할때 
 * @RunWith의 SpringJUnit4ClassRunner 클래스가 
 * @ContextConfiguration에 적어 놓은 파일들을 같이 실행시킵니다. 
 * root-context.xml과 security-context.xml을 실행시켜 빈 등록과 의존 주입을 실행시키는 것입니다
 */

// 참조 https://webcoding.tistory.com/entry/Spring-%EC%8A%A4%ED%94%84%EB%A7%81-JUnit%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%98%EC%97%AC-%EC%BD%94%EB%93%9C-%ED%85%8C%EC%8A%A4%ED%8A%B8%ED%95%98%EA%B8%B0

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
  "file:src/main/webapp/WEB-INF/spring/root-context.xml",
  "file:src/main/webapp/WEB-INF/spring/appServlet/security-context.xml"
  })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)  // JUnit 의 실행 순서를 메소드 이름 순으로 
public class Reservations {

	// 자동 주입 받을 PasswordEncoder 와 DataSource 객체
	private PasswordEncoder pwencoder;
	private DataSource ds;
  
	public PasswordEncoder getPwencoder() {return pwencoder;}
	@Autowired
	public void setPwencoder(PasswordEncoder pwencoder) {this.pwencoder = pwencoder;}
	public DataSource getDs() {return ds;}
	@Autowired
	public void setDs(DataSource ds) {this.ds = ds;}
	Connection conn = null;
	PreparedStatement pstmt = null;
	final String SQL_INSERT_RESERVATION = "INSERT INTO RESERVATION(RES_ID, ID, seat_id, START_DATE, END_DATE, payment) VALUES (reservation_seq.nextval,?,?,?,?,?)";
 
	@Before // org.junit.Before
	public void initialize() {
		System.out.println("Reservations 시작");
		try {
			conn = ds.getConnection();   // DataSource 에서 Connection 받아옴.
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	} // end initialize()
	
	java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Test
	public void testA_InsertMember() {
		System.out.println("InsertReservation() 실행");
		
		if(conn == null) return;
		
		int cnt = 0;
		
		String id = "", seat_id= "", payment = "";
		String start_date_str = "", end_date_str="";
		java.util.Date start_date = null;
		java.util.Date end_date = null;
		Timestamp start_date_sql = null;
		Timestamp end_date_sql = null;
		try {
			pstmt = conn.prepareStatement(SQL_INSERT_RESERVATION);
			// 100명의 테스트용 데이터 생성
			for(int i = 4; i < 10; i++) {
				id = "user" + i;   // 패스워드 pw0, pw1, ... 생성
				seat_id= "seat"+(i+1);
				
				if(i<7) {
					payment="현장결제";
				}
				else {
					payment="카카오페이";
				}

				if(i<7){
					start_date_str = "2021-0"+(i-3)+"-0"+i+" 0"+(i+1)+":0"+(i+1)+":00";
					start_date = format.parse(start_date_str);
					start_date_sql = new java.sql.Timestamp(start_date.getTime());
					end_date_str = "2021-0"+(i-3)+"-0"+i+" 0"+(i+3)+":0"+(i+2)+":00";
					end_date = format.parse(end_date_str);
					end_date_sql = new java.sql.Timestamp(end_date.getTime());
				}
				else{
					start_date_str = "2021-0"+(i-6)+"-0"+i+" 0"+(i+1)+":0"+(i+1)+":00";
					start_date = format.parse(start_date_str);
					start_date_sql = new java.sql.Timestamp(start_date.getTime());
					end_date_str = "2021-0"+(i-6)+"-0"+(i)+" 0"+(i+3)+":0"+(i+2)+":00";
					end_date = format.parse(end_date_str);
					end_date_sql = new java.sql.Timestamp(end_date.getTime());
					System.out.println(start_date_sql);
				}
				cnt = 0;
				try {
					pstmt.setString(1, id);
					pstmt.setString(2, seat_id);
					pstmt.setTimestamp(3, start_date_sql);
					pstmt.setTimestamp(4, end_date_sql);
					pstmt.setString(5, payment);
					cnt = pstmt.executeUpdate();
				} catch(Exception e) {
					System.out.println(e.getMessage());
				}
				
				if(cnt > 0) {
					System.out.println("INSERT_Reservation 성공]" + seat_id +":"+id);
				} else {
					System.out.println("INSERT_Reservation 실패]" + seat_id +":"+id);
				}
				
			} // end for
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
    
  } // end reservation()
  
  
  @After  //org.junit.After;
  public void finalize() {
	  System.out.println("UserTests 종료");
		try {
			if(conn != null) {
				conn.close();
				conn = null;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
  }
  
}
