<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<title>Home</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="../CSS/common.css">
<link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
</head>
<body>
	<!-- Navbar (sit on top) -->

	<%@ include file="kigroupcover.jsp"%>

	<br>
	<br>
	

	<c:choose>
		<c:when test="${ empty list || fn:length(list)==0 }">

		</c:when>
		<c:otherwise>
		<c:if test="${user_id eq null}">
			로그인을 부탁 드립니다.
		</c:if>
<c:if test="${user_id ne null}">
<h5 style="text-align: left; margin: 10px 0 0 50px">최근 스터디</h5>
			<c:forEach var="dto" items="${list}">
				<ul id="myUl" class="row">
					<li class="column"><a
						href="../group/studyview?sg_id=${dto.sg_id}"
						style="text-decoration: none;"><img
							src="/cogather/img/group/upload/${dto.file_name}"
							style="float: right; left: -40%; position: relative; border: 2px solid #ddd; background: url(/cogather/img/borderdesign.jpg); border-radius: 50px; padding: 5px;"
							width="20%" height="50px"
							onerror="this.src='/cogather/img/logo.png'"> </a>
					</div>
						<br>
					<br>
						<p>
							<a href="../group/studyview?sg_id=${dto.sg_id}"
								style="text-decoration: none; float: right; left: -40%; position: relative;">방번호:${dto.sg_id}</a>
						</p>
						<br>
						<p>
							<a href="../group/studyview?sg_id=${dto.sg_id}"
								style="text-decoration: none; float: right; left: -40%; position: relative;">주제:${dto.sg_tag}</a>
						</p></li>
			</c:forEach>
			
				<li class="column new_div">
					<h5 style="text-align: center;">신규 스터디 생성</h5>
					<button
						style="border: none; float: right; left: -40%; position: relative;class="button_add">
						<img src="/cogather/img/group/add.png" class="add"
							onclick="location.href='/cogather/group/studywrite'">
					</button>
					<p></p>

				</li>

				</ul>
			</c:if>
			<br>
			<br>
			
			<h5 style="font-family: monospace;">오늘의 명언</h5>
			<div style="display: flex;">
				<div 
					style="width: 310px; height: 130px; padding: 15px; background-color: white; box-shadow: 10px 10px; font-family: serif;">
					싫은 일은 참지말고 적극적으로 부딪쳐라. 그것이 마음이 편해지는 첫걸음이다. <br>-알랭-
				</div>
				<hr>
			</div>
			
		</c:otherwise>
		
	</c:choose>
	
	<br>
	<br>
	<br>

</body>
</html>