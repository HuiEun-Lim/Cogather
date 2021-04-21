package com.project.cogather.memberstudy.model;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.cogather.members.model.MembersDTO;

public interface MemberStudyDAO {
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 memberstudy 항목을 가져오는 쿼리
	public List<MemberStudyDTO> selectBySGId(@Param("sg_id") int sg_id);
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 members 항목을 가져오는 쿼리
	public List<MembersDTO> selectMemberBySGId(@Param("sg_id") int sg_id);
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 memberstudy 항목 중 권한이 captain인 항목을 가져오는 쿼리
	public List<MemberStudyDTO> selectCaptainBySGId(@Param("sg_id") int sg_id);
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 memberstudy 항목 중 권한이 crew인 항목을 가져오는 쿼리
	public List<MemberStudyDTO> selectCrewBySGId(@Param("sg_id") int sg_id);
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 memberstudy 항목 중 권한이 common인 항목을 가져오는 쿼리
	public List<MemberStudyDTO> selectCommonBySGId(@Param("sg_id") int sg_id);
	
	// 방 입장 상태로 변경
	public int enterEnstatus(int sg_id, String id);
	// 방 퇴장 상태로 변경
	public int outEnstatus(int sg_id, String id);
	
	// 유저 id, 스터디 그룹 id를 통해 누적시간을 가져오는 쿼리
	public List<MemberStudyDTO> getAcctime(int sg_id, String id);
	// 유저 id, 스터디 그룹 id를 통해 누적시간 갱신하는 쿼리
	public int updateAcctime(int sg_id, String id, LocalDateTime acctime);
	
	// 방생성시 captain 자격으로 memberstudy 추가
	public int createCaptain(@Param("id") String id,@Param("sg_id")int sg_id);
	
	// 방생성시 captain 자격으로 memberstudy 추가
	public int createCommon(@Param("id") String id,@Param("sg_id")int sg_id);
	
	// 방생성시 captain 자격으로 memberstudy 추가
	public int updateCrew(@Param("id") String id,@Param("sg_id")int sg_id);
	//
	public List<MemberStudyDTO> selectRegister(int sg_id);
	
	public List<MembersDTO> selectCommonMemberBySGId(@Param("sg_id")int sg_id);
	
	public List<MembersDTO> selectRegisterMemberBySGId(@Param("sg_id")int sg_id);
	
	// 회원 아이디와 관련된 모든 memberstudy 행 가져오기
	public List<MemberStudyDTO> getMemberStudyByID(@Param("id") String id);
}
