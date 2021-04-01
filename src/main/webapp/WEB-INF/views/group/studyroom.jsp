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
var members = {};
$(function(){
	getMembers();
});
// 스터디에 참여하고 있는 멤버들 데이터를 가져옴
function getMembers(){
		$.ajax({
			url:"./MemberStudyRest/ms/"+${sg_id},
			type: "GET",
			cache: false,
			success: function(data, status){
				if(status == "success"){
					if(updateMembers(data)){
								
					}
				}
			}
		}
			
		);
	}
function updateMembers(jsonObj){
	var result = "" // 결과
	var userId = "${id}";
	var msData = jsonObj['msdata'];
	var mData = jsonObj['mdata'];
	if(jsonObj.status == "OK"){
		for(var i = 0; i<msData.length; i++ ){
			if(msData[i].id == userId){
				console.log("hi?");
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
function setTimer(time, userId){
	var timer = {};
	var date = time.split(' ');
	var time = date[1].split(':');
	date = date[0].split('-');
	timer['timerId'] = setInterval("calTime()",2000);
	timer['entime'] = new Date(date[0], date[1]-1,date[2],time[0],time[1]);
	timer['time'] = '0시간 0분';
	members[userId] = timer;
}
function calTime(){
	var now = new Date();
	for(var i in members){
		var sub = now-members[i]['entime']
		var time = Math.floor(sub/1000/60);
		var strTime = Math.floor(time/60) + "시간 " + time%60+"분";
		members[i]['time'] = strTime;
	}
	getMembers();
}
function outroom(){
	clearInterval(members["${id}"]['timerId']);
	delete members["${id}"];
	location.href="roomoutOk?sg_id=${sg_id}&id=${id}";
}
</script>
</body>
</html>