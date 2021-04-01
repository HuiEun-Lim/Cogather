<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
   
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="/cogather/CSS/cafeinfo.css">
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
	<script type="text/javascript" src="/cogather/JS/cafeinfo.js"></script>
	<title>시설소개</title>
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
		      <a href="info" class="w3-bar-item w3-button w3-hide-small w3-border-bottom w3-border-amber">시설소개</a>
		      <a href="#" class="w3-bar-item w3-button w3-hide-small">예약하기</a>
		      <a href="#" class="w3-bar-item w3-button w3-hide-small">오시는 길</a>
		      <a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그인</a>
		   </div>
	    </div>	  
	    <!-- Navbar on small screens -->
	    <div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium">
	      <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">시설소개</a>
	      <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">예약하기</a>
	          <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">오시는 길</a>
	      <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">로그인</a>
	    </div>
    </div>
    
    <div id="wrap">
    	<div class="w3-padding-64" style="margin-top:90px">
    	<h3>이용요금 안내 </h3>
		<div class="w3-light-grey" style="height:2px; margin-bottom: 70px" >
    		<div  style="width:10%; height:2px; background-color:#FDBF26"></div>
		</div>
		    <p>각 시설별로 1시간당 이용요금이 다르니 예약 전에 확인해주세요</p>
        <table class="w3-table w3-bordered w3-centered w3-large w3-card-4">
            <thead>
              <tr class="w3-amber">
                <th style="width:500px">시설</th>
                <th style="width:500px">1시간당 요금</th>
              </tr>
            </thead>
            <tr>
              <td>스터디룸</td>
              <td>2000원</td>
            </tr>
            <tr>
              <td>1인좌석</td>
              <td>1100원</td>
            </tr>
          </table>
        </div>
        
        <div class="w3-padding-64" style="margin-top:40px">
    	<h3>이용시설 안내 </h3>
		<div class="w3-light-grey" style="height:2px; margin-bottom: 20px" >
    		<div  style="width:10%; height:2px; background-color:#FDBF26"></div>
		</div>
		각 시설의 자세한 사진은 사진 위에 있는 돋보기로 확대해서 보실 수 있습니다.
		</div>
		
		<table>
		<tr>
		<td>
		<div class="img-magnifier-container" style="margin-bottom:100px">
  			<img id="myimage" src="/cogather/img/cafe/room.jpg" width="500" height="300" alt="room">
				</div>
		</td>
		<td class="expln">
			<div><h3>스터디룸</h3>
			스터디룸은 최대 5인까지 입장가능하며 빔프로젝터, 화이트보드, 공기청정기, 시스템 에어컨이 설치되어 있습니다.			
			</div>
		</td>
		</tr>
		<tr>
		<td>
		<div class="img-magnifier-container" style="margin-bottom:100px">
  			<img id="myimage2" src="/cogather/img/cafe/room.jpg" width="500" height="300" alt="person">
				</div>
		</td>
		<td class="expln">
			<div><h3>개인좌석</h3>
				개인좌석은 총 30석 정도 있으면 전자기기 충전을 할수있는 콘센트가 함께있습니다. 개인이 조절가능한 스탠드도 있습니다.
			</div>
						
		</td>
		</tr>
	</table>
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
    <td>cogather@gmail.com</td>
    <td></td>
    <td>스터디그룹 http:.....</td>
    </tr>
    </table>
    
  </div>
</footer>
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
    /* Execute the magnify function: */
    magnify("myimage", 3);
    /* Specify the id of the image, and the strength of the magnifier glass: */
    magnify("myimage2", 3);
    </script>
	
</body>
</html>