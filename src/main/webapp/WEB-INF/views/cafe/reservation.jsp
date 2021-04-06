<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.util.Date" %>   
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="/cogather/CSS/cafersv.css">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
	<script type="text/javascript" src="/cogather/JS/cafersv.js"></script>
	<title>예약하기</title>
</head>
<script>
function chkSubmit(){
	frm = document.forms['frm'];
	
	var name=frm['name'].value.trim();
	var subject = frm['subject'].value.trim();

	if(name == ""){
		alert("작성자 란은 반드시 입력해야 합니다.");
		frm['name'].focus();
		return false;
	}
	if(subject == ""){
		alert("제목은 반드시 작성해야 합니다");
        frm["subject"].focus();
        return false;
	}
	return true;
}

</script>
<body>
	<!-- Navbar (sit on top) -->
	<div class="w3-top w3-border-bottom w3-border-light-gray">
	    <div class="w3-bar" id="myNavbar">
		    <div class="choice">
		      <a class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right" href="javascript:void(0);" onclick="toggleFunction()" title="Toggle Navigation Menu">
		        <i class="fa fa-bars"></i>
		      </a>
		     </div>
	      <a href="#" class="w3-bar-item w3-button w3-hover-none" style="margin-top:0; margin-right:5px">
	          <img src="/cogather/img/logo_cut.png" class="logo"  >
	      </a>
	      <div class="choice">
		      <a href="main" class="w3-bar-item w3-button">HOME</a>
		      <a href="info" class="w3-bar-item w3-button w3-hide-small">시설소개</a>
		      <a href="reservation" class="w3-bar-item w3-button w3-hide-small w3-border-bottom w3-border-amber">예약하기</a>
		      <a href="map" class="w3-bar-item w3-button w3-hide-small">오시는 길</a>
		      <a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그인</a>
		   </div>
	    </div>	  
	    <!-- Navbar on small screens -->
	    <div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium">
	      <a href="info" class="w3-bar-item w3-button" onclick="toggleFunction()">시설소개</a>
	      <a href="reservation" class="w3-bar-item w3-button" onclick="toggleFunction()">예약하기</a>
	      <a href="map" class="w3-bar-item w3-button" onclick="toggleFunction()">오시는 길</a>
	      <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">로그인</a>
	    </div>
    </div>
    
    <div id="wrap">
    	<div class="w3-padding-64" style="margin-top:90px">
	    	<h3>예약하기</h3>
			<div class="w3-light-grey" style="height:2px; margin-bottom: 70px" >
	    		<div style="width:10%; height:2px; background-color:#FDBF26"></div>
			</div>
			<div id="ctest"></div>
			<form name="frm" action="writeOk.do" method="post" onsubmit="return chkSubmit()">
				<input type="text" id="ID" name="ID" value="t1">
				<label>시설선택</label>
					<select id="seat_id" name="seat_id">
					  <option value="room01">단체룸</option>
					  <option value="person01">개인좌석</option>
					</select>
				  
				<h3>날짜선택</h3>
				<label>시작 날짜</label>
				<input type="datetime-local" id="startdate" name="startdate">
				<label>종료 날짜</label>
				<input type="datetime-local" id="enddate" name="enddate">
				<label>결제방법선택</label>
				<input type="text" id="payment" name="payment" value="네이버페이">
					<input type="submit" value="Submit">
			</form>
			<div class="w3-button" id="apibtn">카카오페이</div>
	     </div>
	        
	       
	 </div>
    <!-- Footer -->
<footer class="w3-center w3-black w3-padding-64">
  <a href="#home" class="w3-button w3-light-grey"><i class="fa fa-arrow-up w3-margin-right"></i>To the top</a>
  <div class="w3-xlarge w3-section w3-center">
    <table style="color:white">
    <tr>
    <th>대표자 정보</th>
    <th style="width:10px"></th>
    <th>코게더 정보</th>
    </tr>
    <tr>
    <td>코게더팀장</td>
    <td></td>
    <td>코게더 스터디카페</td>
    </tr>
    <tr>
    <td>p.h. 010-1234-5678</td>
    <td></td>
    <td>서울특별시 강남구 역삼로?</td>
    </tr>
    <tr>
    <td>cogather@gmail.com</td>
    <td></td>
    <td>스터디그룹 http:.....</td>
    </tr>
    </table>
    
  </div>
</footer>
    

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7f36e46956483ffffb803d95f128023d"></script>
<script>

window.onscroll = function() {myFunction()};
function myFunction() {
    var navbar = document.getElementById("myNavbar");
    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
        navbar.className = "w3-bar" + " w3-card-2" + " w3-animate-top" + " w3-black" + " w3-hover-light-gray";
    } else {
        navbar.className = navbar.className.replace(" w3-card-2 w3-animate-top w3-black w3-hover-light-gray", "");
    }
}

// Used to toggle the menu on small screens when clicking on the menu button
function toggleFunction() {
    var x = document.getElementById("navDemo");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}

	

</script>
</body>
</html>