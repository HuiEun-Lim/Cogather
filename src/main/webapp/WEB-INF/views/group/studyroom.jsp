<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>스터디 방 </title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/CSS/studyroom.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<%-- <script src="${pageContext.request.contextPath }/JS/studymember.js"></script> --%>

</head>
<body>
<div class="left">

</div>
<div class="center">
</div>
<div class="right">
</div>
<%-- <c:choose> --%>
<%-- 	<c:when test="${empty studyMemberdetails || fn:length(studyMemberdetails) == 0}"> --%>
<!-- 	<h2>참여인원 없음 생성자는 어디감?</h2> -->
<%-- 	</c:when> --%>
<%-- 	<c:otherwise> --%>
<!-- 		<div> -->
<%-- 			총인원수 : ${fn:length(studyMemberdetails) } 명 --%>
<!-- 		</div> -->
<%-- 		<c:forEach var="dto" items="${studyMemberdetails }" > --%>
<%-- 		<c:if test="${dto.id == id }"> --%>
<!-- 			<div> -->
<%-- 				<img src="${pageContext.request.contextPath }/${dto.pimg_url}" class="pimg"> --%>
<%-- 				<div>${dto.id }</div> --%>
<%-- 				<div id=${dto.id }>타이머</div> --%>
<!-- 			</div> -->
<%-- 		</c:if> --%>
			
<%-- 		</c:forEach> --%>
		
<%-- 		<c:forEach var="dto" items="${studyMemberdetails }" > --%>
<%-- 		<c:if test="${dto.id != id }"> --%>
<!-- 			<div> -->
<%-- 				<img src="${pageContext.request.contextPath }/${dto.pimg_url}" class="pimg"> --%>
<%-- 				<div>${dto.id }</div> --%>
<%-- 				<div id=${dto.id }>타이머</div> --%>
<!-- 			</div> -->
<%-- 		</c:if> --%>
			
<%-- 		</c:forEach> --%>
<%-- 	</c:otherwise> --%>
<%-- </c:choose> --%>
<button onclick="outroom()">퇴실하기</button>

<script>
// js 파일을 별도로 분리하게되면 jstl과 EL를 사용할 수 없음
// 컴파일하는 순서가 달라서 어쩔 수 없이 jsp 내부에 두었음

var members = {}; // 타이머를 저장하기 위한 전역 변수 
$(function(){
	getMembers(); // 현제 db에 들어와있는 상태를 가진 유저들 목록을 표시하고 타이머 준비
});
// 스터디에 참여하고 있는 멤버들 데이터를 가져옴
function getMembers(){
		$.ajax({
			url:"./MemberStudyRest/ms/"+${sg_id},
			type: "GET",
			cache: false,
			success: function(data, status){
				if(status == "success"){
					updateMembers(data);
				}
			}
		}
			
		);
	}
// json 데이터로 받은 유저 목록을 표시
function updateMembers(jsonObj){
	var result = "" // 결과
	var userId = "${id}";
	var msData = jsonObj['msdata'];
	var mData = jsonObj['mdata'];
	if(jsonObj.status == "OK"){
		for(var i = 0; i<msData.length; i++ ){
			if(msData[i].id == userId){
				
				if(members[msData[i].id] == null){
					setTimer(msData[i].entime, msData[i].id);
				}
				result = result+ 
				"<div>"+
					"<img class='pimg' src='${pageContext.request.contextPath}/"+ mData[i].pimg_url+"'>"+
					"<div> "+ msData[i].id +" </div>" +
					"<div id='timer-"+msData[i].id+"'> 타이머:"+"<h3>"+members[msData[i].id]['time']+"</h3>" +"</div>"+
				"</div>";
				break;
			}
		}
		
		for(var i = 0; i<msData.length; i++ ){
			if(msData[i].id != userId){
				if(members[msData[i].id] == null){
					setTimer(msData[i].entime, msData[i].id);
				}
				result = result+
				"<div>"+
					"<img class='pimg' src='${pageContext.request.contextPath}/"+ mData[i].pimg_url+"'>"+
					"<div> "+ msData[i].id +" </div>" +
					"<div id='timer-"+msData[i].id+"'> 타이머:"+"<h3>"+members[msData[i].id]['time']+"</h3>" +"</div>"+
				"</div>"
			}
		}
		
		$("div.left").html(result);
		return true;
	}else{
		alert("아무도 방에 들어오지 않았음");
		history.back();
		return false;
	}
}
// 기본 타이머 세팅 1초마다 업데이트
function setTimer(time, userId){
	var timer = {};
	var date = time.split(' ');
	var time = date[1].split(':');
	date = date[0].split('-');
	timer['timerId'] = setInterval("calTime()",1000);
	timer['entime'] = new Date(date[0], date[1]-1,date[2],time[0],time[1]);
	timer['time'] = '0:0:0';
	members[userId] = timer;
}
// 입장시간과 현재 시간의 차이를 계산하는 함수
function calTime(){
	var now = new Date();
	for(var i in members){
		var sub = now-members[i]['entime']
		var hour = Math.floor((sub % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
		var minute = Math.floor((sub % (1000 * 60 * 60)) / (1000 * 60));
		var second =  Math.floor((sub % (1000 * 60)) / 1000);

		var strTime = hour + ":" + minute+":"+second;
		members[i]['time'] = strTime;
	}
	
	updateTime();
}
// 각 유저별 타이머를 업데이트 하는 함수
function updateTime(){
	for(var i in members){
		$("div#timer-"+i+" h3").text(members[i]['time']);
		
	}
}
// 방나가기 - 타이머 시간을 누적시간으로 변환 
function outroom(){
	clearInterval(members["${id}"]['timerId']);
	var temp = members["${id}"]['time'].split(':');
	var time = new Date(2021,0,2,temp[0],temp[1],temp[2]);
	storeAcctime(time);
	delete members["${id}"];
	location.href="roomoutOk?sg_id=${sg_id}&id=${id}";
}
// 타이머 시간 누적시간으로 저장 요청
function storeAcctime(time){
	console.log("hi");
	$.ajax({
		url:"./MemberStudyRest/ms/acctime",
		type: "PUT",
		data: "sg_id=${sg_id}&id=${id}&acctime="+time.toISOString(),
		cache: false,
		success: function(data, status){
			if(status == "success"){
				if( data.status == "OK"){
					alert("누적시간 저장 성공")
				}
			}
		}
	});
}
</script>
</body>
</html>