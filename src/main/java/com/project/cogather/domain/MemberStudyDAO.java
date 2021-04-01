package com.project.cogather.domain;

import java.util.List;

public interface MemberStudyDAO {
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 memberstudy 항목을 가져오는 쿼리
	public List<MemberStudyDTO> selectBySGId(int sg_id);
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 members 항목을 가져오는 쿼리
	public List<MembersDTO> selectMemberBySGId(int sg_id);
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 memberstudy 항목 중 권한이 captain인 항목을 가져오는 쿼리
	public List<MemberStudyDTO> selectCaptainBySGId(int sg_id);
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 memberstudy 항목 중 권한이 crew인 항목을 가져오는 쿼리
	public List<MemberStudyDTO> selectCrewBySGId(int sg_id);
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 memberstudy 항목 중 권한이 common인 항목을 가져오는 쿼리
	public List<MemberStudyDTO> selectCommonBySGId(int sg_id);
	
	// 방 입장 상태로 변경
	public int enterEnstatus(int sg_id, String id);
	// 방 퇴장 상태로 변경
	public int outEnstatus(int sg_id, String id);
	
	
}
