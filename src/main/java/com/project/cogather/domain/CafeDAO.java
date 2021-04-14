package com.project.cogather.domain;

import java.time.LocalDateTime;
<<<<<<< HEAD
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

public interface CafeDAO {
	//전체 예약내역 SELECT
	List<CafeDTO> select();
	
	//새로운 예약 등록
	int insert(CafeDTO dto);
	int insert(String ID, String seat_id, LocalDateTime start_date, LocalDateTime end_date, String payment, int seat_price);
	
	//특정 예약내역 삭제하기
	int deleteByUid(int res_id);
	
	CafeDTO searchBySubject(String seat_id);
	
	int getprice(String seat_id, CafeDTO dto);
	
	List<CafeDTO> selectDate(@Param("seat_id") String seat_id);
} //end DAO
=======
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface CafeDAO {
   //전체 예약내역 SELECT
   List<CafeDTO> select();
   
   //새로운 예약 등록
   int insert(CafeDTO dto);
   int insert(String ID, String seat_id, LocalDateTime start_date, LocalDateTime end_date, String payment, int seat_price);
   
   //특정 예약내역 삭제하기
   int deleteByUid(int res_id);
   
   CafeDTO searchBySubject(String seat_id);
   
   int getprice(String seat_id, CafeDTO dto);
   
   List<CafeDTO> selectDate(@Param("seat_id") String seat_id);
} //end DAO
>>>>>>> 4157cb4d463a0b4845299e527c4e2a4f481e5015
