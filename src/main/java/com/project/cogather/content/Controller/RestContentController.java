package com.project.cogather.content.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.cogather.content.model.StudyBoardContentResult;
import com.project.cogather.content.service.BoardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/group/studyboard")
@RequiredArgsConstructor
public class RestContentController {
	private BoardService boardService;
	
	
}
