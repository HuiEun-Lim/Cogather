package com.project.cogather.service;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.cogather.domain.StudyGroupDAO;
import com.project.cogather.domain.StudyGroupDTO;
import com.project.cogather.domain.StudyGroupFileDTO;
import com.project.cogather.domain.StudyGroupPaging;
import com.project.cogather.util.StudyGroupFileUtils;




@Service
public class StudyGroupService {

	StudyGroupDAO dao;
	
	private SqlSession sqlSession;

	
	private StudyGroupFileUtils fileUtils;
	@Autowired
	public void setStudyGroupFileUtils(StudyGroupFileUtils fileUtils) {
		this.fileUtils = fileUtils;
	}
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public void StudyGroupService() {
		System.out.println("studygroupservice 생성");
	}
	
//	public List<StudyGroupDTO> list(){
//		dao=sqlSession.getMapper(StudyGroupDAO.class);
//		return dao.select();
//	}
	
	public List<StudyGroupDTO> list_recent(){
		dao=sqlSession.getMapper(StudyGroupDAO.class);
		return dao.select_recent();
	}
	
	public int write(StudyGroupDTO dto,StudyGroupFileDTO fdto,MultipartHttpServletRequest mpRequest) throws Exception {
		dao=sqlSession.getMapper(StudyGroupDAO.class);
		int result = dao.insert(dto);
		List<Map<String,Object>> list =  fileUtils.parseInsertFileInfo(dto, mpRequest); 
		String sgf_org_file_name = null;
		String sgf_stored_file_name = null;
		int sgf_file_size;
		//진행중
		int size= list.size();
		
		int sg_id=dto.getSg_id();
		
		
		System.out.println("고유번호:  "+sg_id);
		
		  sgf_org_file_name=fileUtils.getSgf_org_file_name();
		  sgf_stored_file_name=fileUtils.getSgf_stored_file_name();
		  sgf_file_size=fileUtils.getSgf_file_size();
		  fdto = new StudyGroupFileDTO(sgf_org_file_name,sgf_stored_file_name,sgf_file_size,sg_id);
		 Map<String,Object> map = new HashMap<String,Object>();
		 map.put(sgf_org_file_name,"sgf_org_file_name");
		 map.put(sgf_stored_file_name,"sgf_stored_file_name");
		
		
		 System.out.println("map 파일 다운로드 확인"+map.toString());
		 selectFileInfo(map);
		System.out.println("StudyGroup:  "+list.get(0));
//		for(int i=0;i<size-1;i++) {
//			dao.insertFile(list.get(i));
//		}
		//dao.insertFile(fdto);
		int i=1;
		if(list.size()==2) {
			dao.insertFile(list.get(1));
		}else {
			System.out.println("파일없어요");
		}

		System.out.println("생성된 sg_id는 "+dto.getSg_id());
		return result;
	}

	
	public List<StudyGroupDTO> viewByUid(int sg_id){
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		selectFile(sg_id);
		
		return dao.selectByUid(sg_id);
	}
	
	public List<Map<String,Object>> selectFile(int sg_id){
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		System.out.println("sg_id service"+sg_id);
		
		return dao.selectFile(sg_id);
	}
	
	
	  public Map<String,Object> selectFileInfo(Map<String, Object> map)
	  { 
		 
	   dao =sqlSession.getMapper(StudyGroupDAO.class); 
	   //map = new HashMap<String, Object>();
	   System.out.println("service map"+map.toString());
	   return dao.selectFileInfo(map); 
	  
	  }
	 
	
	public List<StudyGroupDTO> selectByUid(int sg_id){
		dao = sqlSession.getMapper(StudyGroupDAO.class);
	
		return dao.selectByUid(sg_id);
	}
	
	public int update(StudyGroupDTO dto) {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		return dao.update(dto.getSg_id(),dto);
		
	}
	
	public int deleteByUid(int sg_id) {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		return dao.deleteByUid(sg_id);
	}
	
	//게시글 총 개수
	public int countBoard() {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		return dao.countBoard();
	}

	//페이지 게시글 
	public List<StudyGroupDTO> selectBoard(StudyGroupPaging sp) {
		
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		
		return dao.selectBoard(sp);
	}
	
	 
}
