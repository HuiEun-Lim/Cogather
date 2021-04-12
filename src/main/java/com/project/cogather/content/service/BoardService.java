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
	
	// 게시글 목록 보이기
	public List<ContentDTO> list(int from, int pageRows, int sg_id){
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.selectFromRow(from, pageRows, sg_id);
	}
	// 게시글 수 세기
	public int countAll(int sg_id) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.countAll(sg_id);
	}
	// 게시글 볼 때 조회수 증가 및 하나의 게시글 읽어오기
	@Transactional
	public List<ContentDTO> viewByUid(int sg_id, int ct_uid){
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		contentDAO.incViewCnt(sg_id, ct_uid);
		return contentDAO.selectByUid(sg_id, ct_uid);
	}
	// 이미지 업로드를 위해 임시 게시글 생성후 임시 게시글 반환 - 이게 글 작성위한 부분이 됨
	@Transactional
	public List<ContentDTO> insert(ContentDTO dto) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		contentDAO.insert(dto);
		return contentDAO.selectTempContent(dto.getId());
	}
	// 이부분이 글 수정을 위하기도 하고 글을 작성하는 부분이기도 함
	public int update(ContentDTO dto) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		return contentDAO.update(dto);
	}
	// 글 삭제
	public int deleteByUid(int sg_id, int ct_uid, String id) {
		contentDAO = sqlSession.getMapper(ContentDAO.class);
		
		return contentDAO.deleteByUid(sg_id, ct_uid, id);
	}
	// 업로드된 파일 물리적인 삭제
	public int deleteFiles(int ct_uid , HttpServletRequest request) {
		contentFileDAO = sqlSession.getMapper(ContentFileDAO.class);
		List<ContentFileDTO> list = contentFileDAO.getFileInfosByCTUID(ct_uid);
		int cnt = 0;
		String url = request.getSession().getServletContext().getRealPath(Common.CONTENTFILEPATH); // 파일들이 저장된 경로를 가져옴
		
		if(list == null) {
			return 0;
		}
		
		for (int i = 0; i< list.size(); i++) {
			ContentFileDTO dto = list.get(i);
			File file = new File(url+"\\"+dto.getCf_file()); // 경로와 합쳐서 실제 파일에 대한 객체를 얻어옴
			if(file.exists()) { // 파일이 존재하면 삭제하고 아니면 넘어감
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
	// 에디터로부터 저장 요청이 들어오면 해당 파일을 저장
	public ContentFileDTO saveBoardFile(int ct_uid, MultipartHttpServletRequest mpRequest) {
		contentFileDAO = sqlSession.getMapper(ContentFileDAO.class);
		
		String fileName =null;
		ContentFileDTO dto = null;
		Iterator<String> filenameitr = mpRequest.getFileNames();
		String url = mpRequest.getSession().getServletContext().getRealPath(Common.CONTENTFILEPATH); // 저장할 폴더 경로 실제 경로
		File saveFolder = new File(url); // 저장 경로로 파일 객체 생성
		
		if(!saveFolder.exists()) { // 파일이 없다- 즉 경로가 없다면 생성
			try {
				saveFolder.mkdirs();
				System.out.println("저장경로의 폴더가 없었으므로 생성합니다.");
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		try {
			while(filenameitr.hasNext()) {
				fileName = filenameitr.next(); // 파일 이름 가져옴 -- ckeditor에서 upload라는 이름으로 줌
				MultipartFile file = mpRequest.getFile(fileName); // 파일 객체를 얻음
				String orgFileName = file.getOriginalFilename(); // 파일 객체로 실제 원본 이름 가져옴
				dto = new ContentFileDTO(); 
				dto.setCf_source(orgFileName);
				
				dto.setCt_uid(ct_uid);
				String orgFileExtension = orgFileName.substring(orgFileName.lastIndexOf("."));
				String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + orgFileExtension; // 저장할 이름은 랜덤하게 해준다.
				
				dto.setCf_file(storedFileName);
				contentFileDAO.saveFile(dto); // db에 해당 정보를 저장
				file.transferTo(new File(url+"\\"+storedFileName)); // 파일 객체로부터 실제 저장될 곳으로 파일을 복사해서 옮김
			}
			
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			System.out.println("게시판 "+fileName+"파일 업로드 실패");
			e.printStackTrace();
		}
		
		return dto;
	}
}
