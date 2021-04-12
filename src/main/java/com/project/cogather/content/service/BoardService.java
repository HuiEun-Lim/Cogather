package com.project.cogather.content.service;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.cogather.common.Common;
import com.project.cogather.content.model.ContentDAO;
import com.project.cogather.content.model.ContentDTO;
import com.project.cogather.content.model.ContentFileDAO;
import com.project.cogather.content.model.ContentFileDTO;

@Service
public class BoardService {
	
	ContentDAO contentDAO;
	ContentFileDAO contentFileDAO;
	@Autowired
	private SqlSession sqlSession;
	
	public List<ContentDTO> list(int from, int pageRows, int sg_id){
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.selectFromRow(from, pageRows, sg_id);
	}
	
	public int countAll(int sg_id) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.countAll(sg_id);
	}
	
	@Transactional
	public List<ContentDTO> viewByUid(int sg_id, int ct_uid){
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		contentDAO.incViewCnt(sg_id, ct_uid);
		return contentDAO.selectByUid(sg_id, ct_uid);
	}
	@Transactional
	public List<ContentDTO> insert(ContentDTO dto) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		contentDAO.insert(dto);
		return contentDAO.selectTempContent(dto.getId());
	}
	
	public int update(ContentDTO dto) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.update(dto);
	}

	public int deleteByUid(int sg_id, int ct_uid, String id) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		
		return contentDAO.deleteByUid(sg_id, ct_uid, id);
	}
	
	public int deleteFiles(int ct_uid , HttpServletRequest request) {
		contentFileDAO = sqlSession.getMapper(ContentFileDAO.class);
		List<ContentFileDTO> list = contentFileDAO.getFileInfosByCTUID(ct_uid);
		int cnt = 0;
		String url = request.getSession().getServletContext().getRealPath(Common.CONTENTFILEPATH);
		
		if(list == null) {
			return 0;
		}
		
		for (int i = 0; i< list.size(); i++) {
			ContentFileDTO dto = list.get(i);
			File file = new File(url+"\\"+dto.getCf_file());
			if(file.exists()) {
				if(file.delete()) {
					System.out.println(url+"\\"+dto.getCf_file()+"물리적 파일 삭제 성공");
					cnt += 1;
				}else {
					System.out.println(url+"\\"+dto.getCf_file()+"물리적 파일 삭제 실패");
				}
			}else {
				System.out.println(url+"\\"+dto.getCf_file() + "파일이 없습니다.");
			}
		}
		return cnt;
	}
	
	public ContentFileDTO saveBoardFile(int ct_uid, MultipartHttpServletRequest mpRequest) {
		contentFileDAO = sqlSession.getMapper(ContentFileDAO.class);
		
		String fileName =null;
		ContentFileDTO dto = null;
		Iterator<String> filenameitr = mpRequest.getFileNames();
		String url = mpRequest.getSession().getServletContext().getRealPath(Common.CONTENTFILEPATH);
		File saveFolder = new File(url);
		
		if(!saveFolder.exists()) {
			try {
				saveFolder.mkdirs();
				System.out.println("저장경로의 폴더가 없었으므로 생성합니다.");
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		try {
			while(filenameitr.hasNext()) {
				fileName = filenameitr.next();
				MultipartFile file = mpRequest.getFile(fileName);
				String orgFileName = file.getOriginalFilename();
				dto = new ContentFileDTO();
				dto.setCf_source(orgFileName);
				
				dto.setCt_uid(ct_uid);
				String orgFileExtension = orgFileName.substring(orgFileName.lastIndexOf("."));
				String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + orgFileExtension;
				
				dto.setCf_file(storedFileName);
				contentFileDAO.saveFile(dto);
				file.transferTo(new File(url+"\\"+storedFileName));
			}
			
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			System.out.println("게시판 "+fileName+"파일 업로드 실패");
			e.printStackTrace();
		}
		
		return dto;
	}
}
