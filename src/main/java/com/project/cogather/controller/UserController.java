package com.project.cogather.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.project.cogather.domain.UserDTO;
import com.project.cogather.service.UserService;
import com.project.cogather.studygroup.model.StudyGroupDTO;
import com.project.cogather.util.UploadFileUtils;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;

	
	@GetMapping("/accessError")
	public String accessDenied(Authentication auth, Model model) {
		System.out.println("access Denied : " + auth);
		model.addAttribute("msg", "접근 권한 거부");
		
		return "user/accessError";
	}
	
	@RequestMapping("/signup")
	public String cafeSignup(Model model) {
		return "user/signup";
	}
	
	@RequestMapping("/signupOk")
	public String cafeSignupOk(UserDTO dto, MultipartFile file, Model model, HttpServletRequest request) throws IOException, Exception {
		
//		String imgUploadPath = uploadPath + File.separator + "pimgUpload";
		String imgUploadPath = request.getSession().getServletContext().getRealPath("img/member/pimgUpload");
		String fileName = null;
		System.out.println(file.getSize());
		if(file.getSize() != 0) {
			System.out.println("test1");
		 fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes());
		 dto.setPimg_url("img/member/pimgUpload" + File.separator + fileName);
		} else {
			System.out.println("test2");
		 dto.setPimg_url("img/member/default.jpg");
		}

		model.addAttribute("result", userService.signup(dto));
		return "user/signupOk";
	}
	
//	@GetMapping("/login")
//	public String cafeLogin(Model model) {
//		return "cafeuser/login";
//	}
	
	@GetMapping("/login")
	public String loginInput(String error, String logout, Model model, HttpServletRequest request) {
		System.out.println("error: " + error);
		System.out.println("logout: " + logout);

		// 요청 시점의 사용자 URI 정보를 Session의 Attribute에 담아서 전달(잘 지워줘야 함)
				// 로그인이 틀려서 다시 하면 요청 시점의 URI가 로그인 페이지가 되므로 조건문 설정
				String uri = request.getHeader("Referer");
				if (!uri.contains("/login")) {
					request.getSession().setAttribute("prevPage",
							request.getHeader("Referer"));
				}
		return "user/login";
	}
	
	@GetMapping("/logout")
	public String logoutGET() {
		System.out.println("GET: custom logout");
		return "user/logout";
	}
	
	@PostMapping("/logout")
	public void logoutPost() {
		System.out.println("POST: custom logout");
	}
	
	@GetMapping("/mypage")
	public String view(String id, Model model) {
		model.addAttribute("dto", userService.selectByID(id));
		model.addAttribute("list", userService.myrsvID(id));
		model.addAttribute("group", userService.mygroupID(id));
		model.addAttribute("sgroup", userService.mygroupName(id));
		return "user/mypage";
	}
	
	@RequestMapping("/userEdit")
	public String update(String id, Model model) {
		model.addAttribute("dto", userService.selectByID(id));
		return "user/userUpdate";
	}
	
	@PostMapping("/updateOk")
	public String updateOk(UserDTO dto, Model model) {
		model.addAttribute("result", userService.update(dto));
		model.addAttribute("dto", dto.getId());
		return "user/updateOk";
	}
	
	@GetMapping("/deleteOk")
	public String deleteOk(String id, Model model) {
		model.addAttribute("result", userService.deleteAuth(id));
		model.addAttribute("result", userService.deleteById(id));
		SecurityContextHolder.clearContext();
		return "user/deleteOk";
	}
	
	
	
}
