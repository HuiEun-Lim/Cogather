<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>스터디 방</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/CSS/studyroom.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="${pageContext.request.contextPath }/JS/chat.js"></script>
<script src="${pageContext.request.contextPath }/JS/studyroomMember.js"></script>

</head>
<body>

	<div class="content-body">
		<div id="sg_id">${sg_id }</div>
		<div id="id">${id }</div>
		<div id="contextPath">${pageContext.request.contextPath }</div>
		<div class="container">
			<div class="left">
			
			</div>
			<button onclick="outroom()">퇴실하기</button>
			<div class="center"></div>
			<div class="right chatbox ">
				<div class="chatting-section">
					<ul id="msgArea"></ul>
				</div>
				<form id="sendMessage" name="sendMessage">
					<input id="message-input" type="text">
					<button onclick="formSend()">전송</button>
				</form>

			</div>
			<div class="clear-both"></div>
			

		</div>
	</div>


	<script>
		
	</script>
</body>
</html>