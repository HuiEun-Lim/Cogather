package com.project.cogather.content.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.cogather.common.AjaxResult;
import com.project.cogather.content.model.ContentDTO;
import com.project.cogather.content.model.StudyBoardContentResult;
import com.project.cogather.content.service.BoardService;
import com.project.cogather.members.model.MembersDTO;
import com.project.cogather.members.service.MembersService;

import lombok.RequiredArgsConstructor;

@RequestMapping("group/studyboard")
@RestController
public class RestContentController {
	@Autowired
	private BoardService boardService;
	@Autowired
	private MembersService membersService;
	// 특정 방의 게시글의 몇 번째 페이지, 페이지당 몇개 씩 보일 것인지
	@GetMapping("/{sg_id}/page/{page}/{pageRows}")
	public StudyBoardContentResult list(
				@PathVariable int sg_id,	
				@PathVariable int page,
				@PathVariable int pageRows
			) {
		StudyBoardContentResult result = new StudyBoardContentResult();
		List<ContentDTO> list = null;
		StringBuffer message = new StringBuffer();
		
		String status = "FAIL";
		
		int writePages = 10;
		int totalPage = 0;
		int totalCnt = 0;
		
		try {
			totalCnt = boardService.countAll(sg_id);
			totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
			
			int from  = (page - 1) * pageRows + 1;
			
			list = boardService.list(from, pageRows, sg_id);
			
			if(list == null) {
				message.append("데이터 없음");
			}else {
				result.setCnt(list.size());
				result.setData(list);
				status = "OK";
			}
			
		} catch(Exception e) {
			message.append("트랜잭션 에러: " + e.getMessage());
			
		}
		result.setStatus(status);
		result.setMessage(message.toString());
		
		result.setPage(page);
		result.setTotalPage(totalPage);
		result.setWritePages(writePages);
		result.setPageRows(pageRows);
		result.setTotalCnt(totalCnt);

		return result;
	}

	// 특정 방의 특정 게시글
	@GetMapping("/{sg_id}/detail/{ct_uid}")
	public StudyBoardContentResult detail(@PathVariable int sg_id, @PathVariable int ct_uid) {
		StudyBoardContentResult result = new StudyBoardContentResult();
		List<ContentDTO> list = null;
		List<MembersDTO> member = null;
		StringBuffer message = new StringBuffer();

		String status = "FAIL";

		try {
			list = boardService.viewByUid(sg_id, ct_uid);
			
			if (list == null || list.size() == 0) {
				message.append("게시글 데이터 없음/");
			} else {
				member = membersService.selectMemberById(list.get(0).getId());
				if(member == null || member.size() == 0) {
					message.append("멤버정보 없음/");
				}else {
					result.setCnt(list.size());
					result.setData(list);
					result.setMember(member);
					status = "OK";
				}
			}

		} catch (Exception e) {
			message.append("트랜잭션 에러: " + e.getMessage());

		}

		result.setStatus(status);
		result.setMessage(message.toString());
		return result;
	}

	@PostMapping("")
	public AjaxResult write(ContentDTO dto) {
		AjaxResult result = new AjaxResult();
		int cnt = 0;
		StringBuffer message = new StringBuffer();
		String status = "FAIL";

		cnt = boardService.insert(dto);

		if (cnt == 0) {
			message.append("트랜잭션 실패: 게시글 저장 실패");
		} else {
			status = "OK";
		}
		result.setStatus(status);
		result.setMessage(message.toString());
		result.setCnt(cnt);

		return result;
	}

	@PutMapping("")
	public AjaxResult update(ContentDTO dto) {
		AjaxResult result = new AjaxResult();
		int cnt = 0;
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		cnt = boardService.update(dto);
		
		if (cnt == 0) {
			message.append("트랜잭션 실패: 게시글 수정 실패");
		} else {
			status = "OK";
		}
		result.setStatus(status);
		result.setMessage(message.toString());
		result.setCnt(cnt);

		return result;
	}

	@DeleteMapping("")
	public AjaxResult deleteByUid(int sg_id, int ct_uid, String id) {
		AjaxResult result = new AjaxResult();
		int cnt = 0;
		StringBuffer message = new StringBuffer();
		String status = "FAIL";

		cnt = boardService.deleteByUid(sg_id, ct_uid, id);

		if (cnt == 0) {
			message.append("트랜잭션 실패: 게시글 수정 실패");
		} else {
			status = "OK";
		}
		result.setStatus(status);
		result.setMessage(message.toString());
		result.setCnt(cnt);

		return result;
	}
}
