package com.project.cogather;
import java.sql.*;

public class Batch {
	// JDBC 관련 기본 객체 변수들 선언
		Connection conn = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;   // executeQuery(), SELECT 결과 
		int cnt = 0;           // executeUpdate(), DML 결과
		
		final String DRIVER = "oracle.jdbc.driver.OracleDriver";	  // JDBC 드라이버 클래스
		final String URL = "jdbc:oracle:thin:@localhost:1521:XE";   // DB 접속 URL
		final String USERID = "cogather";   // DB 접속 계정 정보
		final String USERPW = "1234";
		
		final String MEMBER_INSERT = 
				"INSERT INTO members (ID, NAME, PW, PHONE, EMAIL, PIMG_URL, TAG)\r\n"
				+ "VALUES \r\n"
				+ "(?, ?, ?,?,?, ?,?)";
		
		final String STUDYGROUP_INSERT = 
				"INSERT INTO STUDYGROUP (SG_ID, SG_NAME, SG_INFO, SG_MAX, SG_TAG, KKO_URL)\r\n"
				+ "VALUES \r\n"
				+ "(studygroup_seq.nextval, 'test1', 'test', 4,'1,2,3', 'url1')";
		
		final String MEMBERSTUDY_CAPTAIN_INSERT = 
				"INSERT INTO memberstudy (ID, sg_id, g_auth)\r\n"
				+ "VALUES \r\n"
				+ "('?', '?', '?')";
		final String MEMBERSTUDY_CREW_INSERT = 
				"INSERT INTO memberstudy (ID, sg_id, g_auth)\r\n"
				+ "VALUES \r\n"
				+ "('?', '?', '?')";
		
		public static void main(String[] args) {
			// TODO Auto-generated method stub
			try {
				new Batch().runBatch();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		private void runBatch() throws SQLException {
			// dummy data 10개 작성
			
			try{
				Class.forName(DRIVER);
				System.out.println("드라이버 로딩 성공" + "<br>");   // 테스트 출력
				conn = DriverManager.getConnection(URL, USERID, USERPW);
				System.out.println("conn 성공" + "<br>");       // 테스트 출력
				
				conn.setAutoCommit(false);
				
//				pstmt = conn.prepareStatement(STUDYGROUP_INSERT);
//				cnt = 0;
//				int num = 4;
//				for (int i = 1;i <num+1; i++) {
//					
//					cnt += pstmt.executeUpdate();
//				}
//				
//				System.out.println(cnt + "개의 데이터가 studygroup table에 Insert 되었습니다.");
//				pstmt.close();
				
				pstmt = conn.prepareStatement(MEMBER_INSERT);
				int num = 5;
				for(int i = 1; i< num+1; i++) {
					pstmt.setString(1, String.format("id%d", i));
					pstmt.setString(2, String.format("name%d", i));
					pstmt.setString(3, String.format("pw%d", i));
					pstmt.setString(4, "010-xxxx-xxxx");
					pstmt.setString(5, String.format("oooo%d@gmail.com", i));
					pstmt.setString(6, "img/member/default.jpg");
					pstmt.setString(7, "1,2,3");
					
					cnt += pstmt.executeUpdate();
				}
				System.out.println(cnt + "개의 데이터가 member table에 Insert 되었습니다.");
				pstmt.close();
				
				
				
//				pstmt = conn.prepareStatement(MEMBERSTUDY_CAPTAIN_INSERT);
//				cnt = 0;
//				num = 4;
//				for (int i = 1;i <num+1; i++) {
//					pstmt.setString(1, "id1");
//					pstmt.setInt(2, i);
//					pstmt.setString(3, "catain");
//					
//					cnt += pstmt.executeUpdate();
//				}
//				
//				System.out.println(cnt + "개의 데이터가 memberstudy table에 Insert 되었습니다.");
//				pstmt.close();
//				
//				pstmt = conn.prepareStatement(MEMBERSTUDY_CREW_INSERT);
//				cnt = 0;
//				num = 4;
//				for (int i = 2;i <num+1; i++) {
//					pstmt.setString(1, String.format("id%d", i));
//					pstmt.setInt(2, i-1);
//					pstmt.setString(3, "crew");
//					cnt += pstmt.executeUpdate();
//				}
//				
//				System.out.println(cnt + "개의 데이터가 memberstudy table에 Insert 되었습니다.");
				
				conn.commit();
			} catch(SQLException e) {
				conn.rollback(); // 예외 발생하면 rollback 하고
				throw e; // 다시 예외를 throw

			} catch(Exception e){
				e.printStackTrace();
								//※ 예외처리를 하든지, 예외 페이지를 설정해주어야 한다.
			} finally {
				// DB 리소스 해제
				try{
					if(rs != null) rs.close();
					if(stmt != null) stmt.close();
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			} // end try
			
		}
}
