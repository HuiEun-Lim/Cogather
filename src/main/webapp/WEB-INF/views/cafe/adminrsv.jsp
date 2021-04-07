<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
   
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="/cogather/CSS/cafeinfo.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="/cogather/JS/adminrsv.js"></script>
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
	<title>예약현황</title>
</head>
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
		      <a href="reservation" class="w3-bar-item w3-button w3-hide-small">예약하기</a>
		      <a href="map" class="w3-bar-item w3-button w3-hide-small">오시는 길</a>
		      <a href="adminrsv" class="w3-bar-item w3-button w3-hide-small w3-border-bottom w3-border-amber">예약현황</a>
		      <a href="login" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그인</a>
		   </div>
	    </div>	  
	    <!-- Navbar on small screens -->
	    <div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium">
	      <a href="info" class="w3-bar-item w3-button" onclick="toggleFunction()">시설소개</a>
	      <a href="reservation" class="w3-bar-item w3-button" onclick="toggleFunction()">예약하기</a>
	      <a href="map" class="w3-bar-item w3-button" onclick="toggleFunction()">오시는 길</a>
	      <a href="login" class="w3-bar-item w3-button" onclick="toggleFunction()">로그인</a>
	    </div>
    </div>
    
    <div id="wrap">
    	<div class="w3-padding-64" style="margin-top:90px">
    	<h3>예약 현황 </h3>
		<div class="w3-light-grey" style="height:2px; margin-bottom: 70px" >
    		<div style="width:10%; height:2px; background-color:#FDBF26"></div>
		</div>
		
    	<table class="w3-table w3-bordered w3-centered w3-large w3-card-4">
    	<tr class="w3-amber">
    	<th>예약번호</th>
    	<th>회원ID</th>
    	<th>좌석번호</th>
    	<th>시작날짜</th>
    	<th>종료날짜</th>
    	<th>결제방법</th>
    	<th>예약취소</th>
    	</tr>
    	
    	<c:choose>
    	<c:when test="${empty list || fn:length(list) == 0 }">
    	</c:when>
    	<c:otherwise>
    		<c:forEach var="dto" items="${list }">
    		<tr>
    		<td>${dto.res_id }</td>
    		<td>${dto.ID} </td>
    		<td>${dto.seat_id} </td>
    		<td>${dto.start_date} </td>
    		<td>${dto.end_date} </td>
    		<td>${dto.payment} </td>
    		<td><button class="w3-red w3-text-light-grey" onclick="chkDelete(${dto.res_id })">예약취소</button></td>
    		</tr>
    		</c:forEach>
    	</c:otherwise>
    	</c:choose>
    	</table>
    	</div>
	 </div>
    <!-- Footer -->
<footer class="w3-center w3-black w3-padding-64">
  <a href="#home" class="w3-button w3-light-grey"><i class="fa fa-arrow-up w3-margin-right"></i>To the top</a>
  <div class="w3-xlarge w3-section w3-center">
    <table>
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