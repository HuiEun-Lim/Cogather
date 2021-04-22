<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
   
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="../CSS/cafeinfo.css">
	<link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
	<script type="text/javascript" src="../JS/cafeinfo.js"></script>
	<title>시설소개</title>
</head>
<body>
	<%@ include file="../cafe/navbar.jsp"%>

    
    <div id="wrap">
    	<div class="w3-padding-64" style="margin-top:90px">
    	<h3>이용요금 안내 </h3>
		<div class="w3-light-grey" style="height:2px; margin-bottom: 70px" >
    		<div style="width:10%; height:2px; background-color:#FDBF26"></div>
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
              <td>4000원</td>
            </tr>
            <tr>
              <td>1인좌석</td>
              <td>1600원</td>
            </tr>
          </table>
        </div>
        
        <div class="w3-padding-64" style="margin-top:40px">
    	<h3>이용시설 안내 </h3>
		<div class="w3-light-grey" style="height:2px; margin-bottom: 20px" >
    		<div style="width:10%; height:2px; background-color:#FDBF26"></div>
		</div>
		각 시설의 자세한 사진은 사진 위에 있는 돋보기로 확대해서 보실 수 있습니다.
		</div>
		
		<table>
		<tr>
		<td>
		<div class="img-magnifier-container" style="margin-bottom:100px">
  			<img id="myimage" src="../img/cafe/info_room2.jpg" width="500" height="300" alt="room">
				</div>
		</td>
		<td valign="top" class="expln">
			<div><h2>스터디룸</h2><br><br>
			스터디룸은 최대 5인까지 입장가능합니다.<br>빔프로젝터, 화이트보드, 공기청정기, 시스템 에어컨이 설치되어 있습니다.<br>
			조명의 밝기를 조절할 수 있습니다.
			</div>
		</td>
		</tr>
		<tr>
		<td>
		<div class="img-magnifier-container" style="margin-bottom:100px">
  			<img id="myimage2" src="../img/cafe/info_seats.jpg" width="500" height="300" alt="person">
				</div>
		</td>
		<td valign="top" class="expln">
			<div><h2>개인좌석</h2><br><br>
				개인좌석은 총 24석 있으며 전자기기 충전을 할수있는 콘센트가 함께있습니다. 개인이 조절가능한 스탠드도 있습니다.
			</div>
						
		</td>
		</tr>
	</table>
	    </div>
    <%@ include file="../cafe/footer.jsp"%>

    <script>
    window.onscroll = function() {myFunction()};
	function myFunction() {
	    var navbar = document.getElementById("myNavbar");
	    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
	        navbar.className = "w3-bar" + " w3-card-2" + " w3-white";
	    } else {
	        navbar.className = navbar.className.replace(" w3-card-2 w3-animate-top w3-white w3-hover-border-bottom w3-border-amber", "");
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