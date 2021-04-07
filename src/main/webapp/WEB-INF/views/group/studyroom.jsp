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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="${pageContext.request.contextPath }/JS/chat.js"></script>
<script src="${pageContext.request.contextPath }/JS/studyroomMember.js"></script>

</head>
<body>
	<div class="room">
		<nav id="room-menu">
			<h2 id="room-title">${studyGroupBYSGID[0].sg_name }</h2>
			<span id="enter-cnt-head">참여인원</span><span id="enter-cnt"></span>
			<button id="outroom" class="btn btn-danger" onclick="outroom()">퇴실하기</button>
			<div class="clear-both"></div>
		</nav>
		<div class="content-body">

			<div class="container">
				<div class="left">
					<div class="user-list"></div>

				</div>

				<div class="center"></div>

				<div class="right">
					<div class="chatting-section">
						<div class="chatbox">
							<ul id="msgArea"></ul>
						</div>

						<form id="sendMessage" name="sendMessage">
							<input id="message-input" class="form-control" type="text">
							<button class="btn btn-warning message-send" onclick="formSend()">전송</button>
						</form>
					</div>


				</div>
				<div class="clear-both"></div>

				<div id="sg_id">${sg_id }</div>
				<div id="id">${id }</div>
				<div id="contextPath">${pageContext.request.contextPath }</div>
			</div>


		</div>
	</div>


	<script>
		
	</script>
</body>
</html>