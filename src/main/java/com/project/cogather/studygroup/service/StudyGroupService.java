package com.project.cogather.studygroup.service;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.cogather.memberstudy.model.MemberStudyDAO;
import com.project.cogather.memberstudy.model.MemberStudyDTO;
import com.project.cogather.studygroup.model.StudyGroupDAO;
import com.project.cogather.studygroup.model.StudyGroupDTO;

import com.project.cogather.studygroup.model.StudyGroupFileDTO;
import com.project.cogather.studygroup.model.StudyGroupPaging;
import com.project.cogather.util.StudyGroupFileUtils;

@Service
public class StudyGroupService {
	@Autowired
	SqlSession sqlSession;
	@Autowired
	private StudyGroupFileUtils fileUtils;

	StudyGroupDAO dao;

	
	MemberStudyDAO mdao;
	
	
	public List<StudyGroupDTO> list_recent(){
		dao=sqlSession.getMapper(StudyGroupDAO.class);
		return dao.select_recent();
	}
	@Transactional
	public int write(MultipartHttpServletRequest mpRequest) throws Exception {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		StudyGroupDTO dto = new StudyGroupDTO();
		StudyGroupFileDTO fdto = new StudyGroupFileDTO();
		String file_name=null;

//		MultipartFile uploadFile = dto.getUploadFile(); // 형꺼
		MultipartFile uploadFile = mpRequest.getFile("uploadFile"); // 정희꺼

		System.out.println("mp1 "+mpRequest.getParameter("sg_name"));
		System.out.println("mp2 "+mpRequest.getParameter("sg_info"));
		System.out.println("mp3 "+mpRequest.getParameter("sg_tag"));
		System.out.println("mp4 "+mpRequest.getParameter("kko_url"));
		String sg_info=mpRequest.getParameter("sg_info");
		String sg_name=mpRequest.getParameter("sg_name");
		String sg_tag=mpRequest.getParameter("sg_tag");
		String kko_url=mpRequest.getParameter("kko_url");
		int sg_max=Integer.parseInt(mpRequest.getParameter("sg_max"));
		String id=mpRequest.getParameter("id");
		dto.setSg_info(sg_info);
		dto.setKko_url(kko_url);
		dto.setSg_name(sg_name);
		dto.setSg_tag(sg_tag);
		dto.setSg_max(sg_max);
		dto.setId(id);
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();

			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			file_name=uuid+"."+ext;
	//		String pdfPath = mpRequest.getSession().getServletContext().getRealPath("/img/group/");
	//		System.out.println(new File(pdfPath));	
	//		uploadFile.transferTo(new File(pdfPath+file_name));
			//uploadFile.transferTo(new File("upload"+file_name));
		//	uploadFile.transferTo(new File("D:\\DevRoot\\Dropbox\\App04\\CoGather\\Cogather\\src\\main\\webapp\\img\\group\\upload\\"+file_name));
			uploadFile.transferTo(new File("C:\\tomcat\\upload\\"+file_name));


		}
		

		dto.setFile_name(file_name);

		// insert
		int result = dao.insert(dto);
		
		//첨부파일 업로드 
		List<Map<String,Object>> list =  fileUtils.parseInsertFileInfo(dto, mpRequest); 
		if(!list.isEmpty()) { 
		String sgf_org_file_name = null;
		String sgf_stored_file_name = null;
		int sgf_file_size;
		// 진행중
		int size = list.size();

		int sg_id = dto.getSg_id();
		
		int sgf_id = fdto.getSgf_id();
		System.out.println("고유번호:  " + sg_id);
		System.out.println("파일고유번호:  " + sgf_id);
		sgf_org_file_name = fileUtils.getSgf_org_file_name();
		sgf_stored_file_name = fileUtils.getSgf_stored_file_name();
		sgf_file_size = fileUtils.getSgf_file_size();
		
		// fdto = new
		// StudyGroupFileDTO(sgf_org_file_name,sgf_stored_file_name,sgf_file_size,sg_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(sgf_org_file_name, "sgf_org_file_name");
		map.put(sgf_stored_file_name, "sgf_stored_file_name");
	
		System.out.println("map 파일 다운로드 확인" + map.toString());
		selectFileInfo(map);
		System.out.println("StudyGroup:  " + list.get(0));
//		for(int i=0;i<size-1;i++) {
//			dao.insertFile(list.get(i));
//		}
		// dao.insertFile(fdto);
		int i = 1;
		if (list.size() == 2) {
			dao.insertFile(list.get(1));
		} else {
			System.out.println("파일없어요");
		}
		}

		
		System.out.println("생성된 sg_id는 "+dto.getSg_id());
		
		//스터디 방 생성 
		/* String id="id1"; */
		id = dto.getId();
		mdao=sqlSession.getMapper(MemberStudyDAO.class);
		mdao.createCaptain(id,dto.getSg_id());
		
	
		return result;
	}

	public List<StudyGroupDTO> viewByUid(int sg_id) {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		selectFile(sg_id);

		return dao.selectByUid(sg_id);
	}

	public List<Map<String, Object>> selectFile(int sg_id) {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		return dao.selectFile(sg_id);
	}

	public Map<String, Object> selectFileInfo(Map<String, Object> map) {

		dao = sqlSession.getMapper(StudyGroupDAO.class);
		// map = new HashMap<String, Object>();
		System.out.println("service map" + map.toString());
		return dao.selectFileInfo(map);

	}

	public List<StudyGroupDTO> selectByUid(int sg_id) {
		dao = sqlSession.getMapper(StudyGroupDAO.class);

		return dao.selectByUid(sg_id);
	}

	
	public int update(StudyGroupDTO dto,MultipartHttpServletRequest mpRequest) throws Exception {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		MultipartFile uploadFile = mpRequest.getFile("uploadFile"); 
		String file_name=null;
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			file_name=uuid+"."+ext;
			uploadFile.transferTo(new File("C:\\tomcat\\upload\\"+file_name));
				
		}
		
		dto.setFile_name(file_name);
		
		//첨부파일 업로드 
				List<Map<String,Object>> list =  fileUtils.parseInsertFileInfo(dto, mpRequest); 
				if(!list.isEmpty()) { 
				String sgf_org_file_name = null;
				String sgf_stored_file_name = null;
				int sgf_file_size;
				// 진행중
				int size = list.size();

				int sg_id = dto.getSg_id();

				System.out.println("고유번호:  " + sg_id);

				sgf_org_file_name = fileUtils.getSgf_org_file_name();
				sgf_stored_file_name = fileUtils.getSgf_stored_file_name();
				sgf_file_size = fileUtils.getSgf_file_size();
				// fdto = new
				// StudyGroupFileDTO(sgf_org_file_name,sgf_stored_file_name,sgf_file_size,sg_id);
				Map<String, Object> map = new HashMap<String, Object>();
				map.put(sgf_org_file_name, "sgf_org_file_name");
				map.put(sgf_stored_file_name, "sgf_stored_file_name");

				System.out.println("map 파일 다운로드 확인" + map.toString());
				selectFileInfo(map);
				System.out.println("StudyGroup:  " + list.get(0));
//				for(int i=0;i<size-1;i++) {
//					dao.insertFile(list.get(i));
//				}
				// dao.insertFile(fdto);
				int i = 1;
				if (list.size() == 2) {
					dao.insertFile(list.get(1));
				} else {
					System.out.println("파일없어요");
				}
				}

		
		return dao.update(dto.getSg_id(),dto);
		
	}

	
	public int deleteByUid(int sg_id) {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		return dao.deleteByUid(sg_id);
	}

	public int deleteFileByUid(int sg_id) {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		return dao.deleteFileByUid(sg_id);
	}


	

	//게시글 총 개수
	public int countBoard(StudyGroupPaging sp) {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		return dao.countBoard(sp.getKeyword());
	}

	// 페이지 게시글
	public List<StudyGroupDTO> selectBoard(StudyGroupPaging sp) {

		dao = sqlSession.getMapper(StudyGroupDAO.class);

		return dao.selectBoard(sp);
	}
	
	// 유저 아이디로 참여한 스터디들 가져오기
	public List<StudyGroupDTO> getStudyByID(String id){
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		return dao.getStudyByID(id);
	}
	
	// 방 번호로 방 정보 가져오기
	public List<StudyGroupDTO> getStudyBySgID(Integer sg_id){
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		return dao.getStudyBySgID(sg_id);
	}
	
	public int deleteSGByID(String id) {
		dao = sqlSession.getMapper(StudyGroupDAO.class);
		return dao.deleteSGByID(id);
	}
	
}
