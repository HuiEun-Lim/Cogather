package com.project.cogather.service;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cogather.domain.MemberStudyDAO;
import com.project.cogather.domain.MemberStudyDTO;
import com.project.cogather.domain.MembersDAO;
import com.project.cogather.domain.MembersDTO;

@Service
public class MemberStudyService {
	private MemberStudyDAO memberStudyDAO;

	@Autowired
	private SqlSession sqlsession;
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 memberstudy 항목을 가져오는 쿼리
	public List<MemberStudyDTO> select(int sg_id){
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.selectBySGId(sg_id);
	}
	// 스터디그룹id를 통해 특정 스터디그룹과 연관된 members 항목을 가져오는 쿼리
	public List<MembersDTO> selectMembersBySGId(int sg_id){
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.selectMemberBySGId(sg_id);
	}
	// 방 입장 상태로 변경 - 
	public int enterStatus(int sg_id, String id) {
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.enterEnstatus(sg_id, id);
	}
	// 방 퇴실 상태로 변경
	public int outStatus(int sg_id, String id) {
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.outEnstatus(sg_id, id);
	}
	
	// 누적시간 가져오기
	public List<MemberStudyDTO> getAcctime(int sg_id, String id){
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.getAcctime(sg_id, id);
	}
	
	// 누적 시간 업데이트
	public int updateAcctime(int sg_id, String id, LocalDateTime acctime) {
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.updateAcctime(sg_id, id, acctime);
	}
}
