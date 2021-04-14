<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/cogather/CSS/cafersv.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="https://kit.fontawesome.com/65311e5b1a.js"
	crossorigin="anonymous"></script>
<script type="text/javascript" src="/cogather/JS/cafersv.js"></script>
<script type="text/javascript" src="/cogather/JS/seats.js"></script>
<title>예약하기</title>
</head>
<script>

var seatdates;
function chkSubmit(){
	frm = document.forms['frm'];
	
	var seatid = frm['seat_id'].value.trim();
	var startd = new Date(frm['startdate'].value.trim());
	var endd = new Date(frm['enddate'].value.trim());
	var diffTime = (endd.getTime() - startd.getTime())/(1000 * 60*60);
		
	if(seatid == ""){
		alert("좌석을 반드시 선택해야합니다.");
		return false;
		
	}
	
	if(diffTime < 1 || diffTime > 72){
		alert("시간 확인하세요");
		return false;
	}
	chkdates();
	
	function chkdates(){
		$.ajax({
			url:"${pageContext.request.contextPath}/studycafe/dateResult?seat_id="+seatid,
			type: "GET",
			cache: false,
			success: function(data, status){
				if(status == "success"){
					if(data.status == "success"){
						seatdates = data;
						chkrsvdate(data)
					}
				}
			}
		})
	}
	function chkrsvdate(data){
		for(var i=0; i<data['chkdates'].length;i++){
			var resdate = (data['chkdates'][i].start_date).split(/[- :]/);
			var resdate2 = new Date(Date.UTC(t[0], t[1]-1, t[2], t[3], t[4], t[5]));
			alert("예약허쉴");
			alert(resdate2);
			if((data['chkdates'][i].start_date).getTime() - startd.getTime() <= 0 &&(data['chkdates'][i].end_date).getTime() - startd.getTime() >= 0){ // 시작 날짜가 같거나 이후다
				temp = seatdates['chkdates'][i].start_date - startd;
				alert(temp);
				return false;
			}
		
			else if((data['chkdates'][i].start_date).getTime() - endd.getTime() <= 0 && (data['chkdates'][i].end_date).getTime() - endd.getTime() >= 0){
				alert("이미 예약된 자리입니다.");
				return false;
			}
		}
	}
	
	
}
</script>
<body>
	<!-- Navbar (sit on top) -->
	<div class="w3-top w3-border-bottom w3-border-light-gray">
		<div class="w3-bar" id="myNavbar">
			<div class="choice">
				<a
					class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right"
					href="javascript:void(0);" onclick="toggleFunction()"
					title="Toggle Navigation Menu"> <i class="fa fa-bars"></i>
				</a>
			</div>
			<a href="#" class="w3-bar-item w3-button w3-hover-none"
				style="margin-top: 0; margin-right: 5px"> <img
				src="/cogather/img/logo_cut.png" class="logo">
			</a>
			<div class="choice">
				<a href="main" class="w3-bar-item w3-button">HOME</a>
				<a href="info" class="w3-bar-item w3-button w3-hide-small">시설소개</a>
				<a href="reservation" class="w3-bar-item w3-button w3-hide-small w3-border-bottom w3-border-amber">예약하기</a>
				<a href="map" class="w3-bar-item w3-button w3-hide-small">오시는 길</a>
				<a href="login"	class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그인</a>
			</div>
		</div>
		<!-- Navbar on small screens -->
		<div id="navDemo"
			class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium">
			<a href="info" class="w3-bar-item w3-button" onclick="toggleFunction()">시설소개</a>
			<a href="reservation" class="w3-bar-item w3-button" onclick="toggleFunction()">예약하기</a>
			<a href="map" class="w3-bar-item w3-button" onclick="toggleFunction()">오시는	길</a>
			<a href="login" class="w3-bar-item w3-button" onclick="toggleFunction()">로그인</a>
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
				<br>선택하신 좌석은 예약후에는 변경하실 수 없습니다. 
				<br><input type="text" id="ID" name="ID" value="t1">
				<input type="text" id="seat_id" name="seat_id" style="visibility : hidden" required>

				<div class="optitle">날짜선택</div><br>
				<label class = "optent">시작 날짜</label>
				<input type="datetime-local" id="startdate"	name="startdate" required><br>
				<label class = "optent">종료 날짜</label> <input
					type="datetime-local" id="enddate" name="enddate" required>
				<div class="optitle">결제방법선택</div><br>
				<input type="text" id="kakaopay" name="payment" value="카카오페이" readonly><br><br>
				<input type="submit" value="예약하기">
			</form>
			
			<div id="chkdates">
			<table>
				<thead>
				<tr>
				<th>시설번호</th>
				<th>예약시작</th>
				<th>예약종료</th>
				</tr>
				</thead>
				<tbody>
				
				</tbody>
							
			</table>
			</div>
		</div>


	</div>
	<!-- Footer -->
	<footer class="w3-center w3-black w3-padding-64">
		<a href="#home" class="w3-button w3-light-grey"><i
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