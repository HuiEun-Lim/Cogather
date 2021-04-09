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
	String payment;
	int price;
	
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
		System.out.println("아이디는:" + ID + "| 좌석번호는" + price + "|결제방법은" + payment);

		try {
			URL addrs = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection conn = (HttpURLConnection) addrs.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "KakaoAK 0d8ab7645584e6e849e393632311ab22");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			String param="cid=TC0ONETIME&partner_order_id=res01&partner_user_id="+ID+"&item_name="+seat_id+"&quantity=1&total_amount="+price+"&tax_free_amount=0&approval_url=http://localhost:8080/cogather/studycafe/main&cancel_url=http://localhost:8080/cogather/studycafe/info&fail_url=http://localhost:8080/cogather/studycafe/map";
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
		payment = request.getParameter("payment");
		price = cafeService.getprice(dto);
		System.out.println("아이디는:" + ID + "| 가격은" + price + "|결제방법은" + payment);
		return "cafe/rsvOk";
	}
	
	@RequestMapping("/adminrsv")
	public String list(Model model) {
		model.addAttribute("list", cafeService.list());
		return "cafe/adminrsv";
	}
	
	@GetMapping("/deleteOk.do")
	public String deleteOk(int res_id, Model model) {
		model.addAttribute("result", cafeService.deleteByUid(res_id));
		return "cafe/deleteOk";
	}
}