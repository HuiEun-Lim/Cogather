package com.project.cogather.studygroup.service;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cogather.studygroup.model.StudyGroupDAO;
import com.project.cogather.studygroup.model.StudyGroupDTO;
@Service
public class StudyGroupService {
	@Autowired
	SqlSession sqlSession;
	
	StudyGroupDAO studyGroupDAO;
	
	public StudyGroupDTO getStudyGroupBySGID(int sg_id) {
		studyGroupDAO = sqlSession.getMapper(StudyGroupDAO.class);
		
		return studyGroupDAO.getStudyGroupBySGID(sg_id);
	}
}
