package com.project.cogather.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.time.Duration;
import java.time.LocalDateTime;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cogather.domain.CafeDTO;
import com.project.cogather.service.CafeService;

@Controller
@RequestMapping("/studycafe")
public class CafeController {
	
	private CafeService cafeService;
	String ID;
	String seat_id;
	LocalDateTime start_date;
	LocalDateTime end_date;
	long price;
	long hours;
	String rsv_tid;
	
	@Autowired
	public void setCafeService(CafeService cafeService) {
		this.cafeService = cafeService;
	}
	
	@RequestMapping("/main")
	public String studymain(Model model) {
		return "cafe/main";
	}
	
	@RequestMapping("/info")
	public String studyinfo(Model model) {
		return "cafe/info";
	}
	
	@RequestMapping("/map")
	public String studymap(Model model) {
		return "cafe/map";
	}
	
	@RequestMapping("/reservation")
	public String reservation(Model model) {
		
		return "cafe/reservation";
	}
	
	@RequestMapping("/kakaopay")
	@ResponseBody
	public String kakaopay() {
		try {
			URL addrs = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection conn = (HttpURLConnection) addrs.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "KakaoAK 0d8ab7645584e6e849e393632311ab22");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			String param="cid=TC0ONETIME&partner_order_id=res01&partner_user_id="+ID+"&item_name="+seat_id+"&quantity=1&total_amount="+price+"&tax_free_amount=0&approval_url=http://localhost:8090/cogather/studycafe/map&cancel_url=http://localhost:8090/cogather/studycafe/info&fail_url=http://localhost:8090/cogather/studycafe/reservation";
			OutputStream out = conn.getOutputStream();
			DataOutputStream dout = new DataOutputStream(out);
			dout.writeBytes(param);
			dout.flush();
			dout.close();
			
			int result = conn.getResponseCode();
			
			InputStream in;
			if(result == 200) {
				System.out.println("성공");
				in = conn.getInputStream();
			} else {
				in = conn.getErrorStream();
			}
			InputStreamReader read = new InputStreamReader(in);
			BufferedReader buff = new BufferedReader(read);
			return buff.readLine();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "{\"result\":\"NO\"}";
	}
	
	@RequestMapping("/rsvOk")
	public String rsvOk(CafeDTO dto, Model model, HttpServletRequest request) {
		model.addAttribute("result", cafeService.write(dto));
		ID = request.getParameter("ID");
		seat_id = request.getParameter("seat_id");
		start_date = dto.getStart_date();
		end_date = dto.getEnd_date();
		Duration duration = Duration.between(start_date, end_date);
		hours = (duration.toMinutes()/60);
		System.out.println(hours+"시간 걸림");
		price = (cafeService.getprice(dto)) * hours;
		return "cafe/rsvOk";
	}
	
	@RequestMapping("/adminrsv")
	public String list(Model model) {
		model.addAttribute("list", cafeService.list());
		return "cafe/adminrsv";
	}
	
//	@RequestMapping("/test")
//	public String test(Model model) {
//		return "cafe/test";
//	}
	
	@GetMapping("/deleteOk.do")
	public String deleteOk(int res_id, Model model) {
		model.addAttribute("result", cafeService.deleteByUid(res_id));
		return "cafe/deleteOk";
	}
	
	@RequestMapping("/kakaocancel")
	@ResponseBody
	public String kakaocancel() {
		try {
			URL addrs = new URL("https://kapi.kakao.com/v1/payment/cancel");
			HttpURLConnection conn = (HttpURLConnection) addrs.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "KakaoAK 0d8ab7645584e6e849e393632311ab22");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			String param="cid=TC0ONETIME&tid=T2887013932310687733&cancel_amount=4000&cancel_tax_free_amount=0";
			OutputStream out = conn.getOutputStream();
			DataOutputStream dout = new DataOutputStream(out);
			dout.writeBytes(param);
			dout.flush();
			dout.close();
			
			int result = conn.getResponseCode();
			
			InputStream in;
			if(result == 200) {
				System.out.println("성공");
				in = conn.getInputStream();
			} else {
				in = conn.getErrorStream();
			}
			InputStreamReader read = new InputStreamReader(in);
			BufferedReader buff = new BufferedReader(read);
			return buff.readLine();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "{\"result\":\"NO\"}";
	}
	
	@RequestMapping(value="/test", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getTidtest(HttpServletRequest request) {
		String rsv_tid = request.getParameter("rsv_tid");
		System.out.println(rsv_tid+"tid임");
		int thisres_id = cafeService.getlastid();
		cafeService.setrsvTid(thisres_id, rsv_tid);
		return "카카오페이 결제를 완료하고 해당 창을 닫아주세요";
	}
}
