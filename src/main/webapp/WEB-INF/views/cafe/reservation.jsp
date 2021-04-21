<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>

<sec:authorize access="isAnonymous()">
    	<script>
    		alert("로그인이 필요한 서비스입니다.");
    		location.href="${pageContext.request.contextPath}";
    	</script>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
    
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="../CSS/cafersv.css">
<link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="https://kit.fontawesome.com/65311e5b1a.js"
	crossorigin="anonymous"></script>
<script type="text/javascript" src="../JS/cafersv.js"></script>
<script type="text/javascript" src="../JS/seats.js"></script>
<title>예약하기</title>
</head>
<script>

var seatdates;
</script>
<body>
	<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar" id="myNavbar">
  <div class="choice">
    <a class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right" href="javascript:void(0);" onclick="toggleFunction()" title="Toggle Navigation Menu">
      <i class="fa fa-bars"></i>
    </a>
   </div>
    <a href="#" class="w3-bar-item w3-button w3-hover-none" style="margin-top:0; margin-right:5px">
    	<img src="../img/logo_cut.png" class="logo"  >
    </a>
    <div class="choice">
    <a href="main" class="w3-bar-item w3-button w3-hide-small">HOME</a>
    <a href="info" class="w3-bar-item w3-button w3-hide-small">시설소개</a>
    <a href="reservation" class="w3-bar-item w3-button w3-hide-small w3-border-bottom w3-border-amber">예약하기</a>
    <a href="map" class="w3-bar-item w3-button w3-hide-small">오시는 길</a>
    <sec:authorize access="isAnonymous()">
    	<a href="../login" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그인</a>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
    	<form action="${pageContext.request.contextPath}/logout" method='post'>
		<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
		<button class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그아웃</button>
    	<a href="cafemypage?id=${user_id }" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">마이페이지</a>
    	<sec:authorize access="hasRole('ROLE_ADMIN')">
    	<a href="adminrsv" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">관리자페이지</a>
		</sec:authorize>
		<sec:authentication property="principal.username" var="user_id" />
        <div id="user_id" class="w3-bar-item w3-right">안녕하세요. ${user_id }님</div>
    	</form>
   	</sec:authorize>
  </div>
  </div>

  <!-- Navbar on small screens -->
  <div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium">
  	<a href="main" class="w3-bar-item w3-button" onclick="toggleFunction()">HOME</a>
    <a href="info" class="w3-bar-item w3-button" onclick="toggleFunction()">시설소개</a>
    <a href="reservation" class="w3-bar-item w3-button" onclick="toggleFunction()">예약하기</a>
    <a href="map" class="w3-bar-item w3-button" onclick="toggleFunction()">오시는 길</a>
    <sec:authorize access="isAnonymous()">
    <a href="../login" class="w3-bar-item w3-button" onclick="toggleFunction()">로그인</a>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">마이페이지</a>
    <form action="${pageContext.request.contextPath}/logout" method='post'>
		<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
		<button class="w3-bar-item w3-button" onclick="toggleFunction()">로그아웃</button>
    </form>
    </sec:authorize>
    <sec:authorize access="hasRole('ROLE_ADMIN')">
    <a href="adminrsv" class="w3-bar-item w3-button" onclick="toggleFunction()">관리자페이지</a>
	</sec:authorize>
  </div>
</div>

	<div id="wrap">
		<div class="w3-padding-64" style="margin-top: 90px">
			<h3>예약하기</h3>
			<div class="w3-light-grey" style="height: 2px; margin-bottom: 50px">
				<div style="width: 10%; height: 2px; background-color: #FDBF26"></div>
			</div>
			<div class="optitle">시설선택</div><br>
			<input type="radio" id="room" name="seats"
				value="4000" onclick="checkroom()" required>
				<label for="room" class = "optent">스터디룸</label>
			<input type="radio" id="private" name="seats" value="1600"
				onclick="checkprivate()">
				<label for="private" class = "optent">개인좌석</label>
			<form name="frm" action="rsvOk.do" method="post"
				onsubmit="return chkSubmit()">
				<div id="pickSeat">
				</div>
				<br><br>
				<span id = "chkseatagain"></span>
				<div class="letters">
				<br>&#42;선택하신 좌석은 예약 후에는 변경하실 수 없습니다.
				아래는 해당 좌석의 예약내역입니다.&#42;<br><br></div>
				<div id="chkdates">
					<table class="w3-table w3-bordered w3-round-xlarge w3-centered w3-card" style="width: 50%">
						<tbody>
						</tbody>	
					</table>
				</div>
				<sec:authentication property="principal.username" var="user_id" />
				<br><input type="hidden" id="ID" name="ID" value="${user_id }" readonly>
				<input type="text" id="seat_id" name="seat_id" style="visibility : hidden" required>

				<div class="optitle">날짜선택</div><br>
				<label class = "optent">시작 날짜</label>
				<input type="datetime-local" id="startdate"	name="startdate" required><br>
				<label class = "optent">종료 날짜</label> <input
					type="datetime-local" id="enddate" name="enddate" required>
				<div class="optitle">결제방법선택</div><br>
				<div class="letters">&#42;결제방법 선택시 예약이 자동으로 완료가 됩니다&#42;</div><br>
				<input id="kakaopaybtn" type="submit" name = "payment" value="카카오페이" formaction="rsvOk.do">
				<input id="onsitebtn" type="submit" name = "payment" value="현장결제" formaction="onsitersvOk.do">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
			</form>
		</div>
	</div>
	<!-- Footer -->
	<footer class="w3-center w3-black w3-padding-64">
		<a href="#wrap" class="w3-button w3-light-grey"><i
			class="fa fa-arrow-up w3-margin-right"></i>To the top</a>
		<div class="w3-xlarge w3-section w3-center">
			<table style="color: white">
				<tr>
					<th>대표자 정보</th>
					<th style="width: 10px"></th>
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

function getDates(seat_id){

	$.ajax({
		url:"${pageContext.request.contextPath}/studycafe/dateResult?seat_id="+seat_id,
		type: "GET",
		cache: false,
		success: function(data, status){
			if(status == "success"){
				if(data.status == "success"){
					seatdates = data;
					printRsv(data);
				}
				
				else if(data.status == "fail"){
					seatdates = data;
					$('#chkdates tbody').html("다른 예약내역이 없습니다");				}
			}
		}
	})
}

function printRsv(data){
	var result = "";
	for(var i=0; i<data['chkdates'].length;i++){
		result += "<tr><td>"+data['chkdates'][i].seat_id+"</td><td>"+data['chkdates'][i].start_date+"</td><td>"+data['chkdates'][i].end_date+"</td></tr>";
	}
	$('#chkdates tbody').html(result);
}

</script>

</body>
</html>
</sec:authorize>
