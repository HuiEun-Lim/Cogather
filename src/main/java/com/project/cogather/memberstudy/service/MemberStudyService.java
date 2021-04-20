package com.project.cogather.memberstudy.service;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cogather.members.model.MembersDAO;
import com.project.cogather.members.model.MembersDTO;
import com.project.cogather.memberstudy.model.MemberStudyDAO;
import com.project.cogather.memberstudy.model.MemberStudyDTO;

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
	//register
	public List<MemberStudyDTO> selectRegister(int sg_id){
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.selectRegister(sg_id);
	}
	//common
	public List<MemberStudyDTO> selectCommon(int sg_id){
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.selectCommonBySGId(sg_id);
	}
	// register 된 멤버 가져오기
	public List<MembersDTO> selectRegisterMember(int sg_id){
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.selectRegisterMemberBySGId(sg_id);
	}
	// common인 멤버 가져오기
	public List<MembersDTO> selectCommonMember(int sg_id){
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.selectCommonMemberBySGId(sg_id);
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
	
	// 방생성시 captain 자격으로 memberstudy 추가
	public int createCaptain(String id, int sg_id) {
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.createCaptain(id,sg_id);
	}
	
	public int createCommon(String id, int sg_id) {
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.createCommon(id,sg_id);
	}
	
	public int updateCrew(String id, int sg_id) {
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.updateCrew(id,sg_id);
	}
	
	// 회원 아이디와 관련된 모든 memberstudy 행 가져오기
	public List<MemberStudyDTO> getMemberStudyByID(String id){
		memberStudyDAO = sqlsession.getMapper(MemberStudyDAO.class);
		return memberStudyDAO.getMemberStudyByID(id);
	}
	
}
