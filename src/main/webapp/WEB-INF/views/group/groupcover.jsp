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
	<div id="wrap">
		<div class="w3-top">
			<div class="w3-bar" id="myNavbar">
				<a
					class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right"
					href="javascript:void(0);" onclick="toggleFunction()"
					title="Toggle Navigation Menu"> <i class="fa fa-bars"></i>
				</a> <a href="/cogather/group/studygroup" class="w3-bar-item w3-button">
					<img src="/cogather/img/logo_cut.png" class="logo">
				</a> <a href="/cogather/group/studylist"
					class="w3-bar-item w3-button w3-hide-small">스터디목록</a> <a
					href="/cogather/group/studywrite"
					class="w3-bar-item w3-button w3-hide-small">스터디만들기</a>

				<sec:authorize access="isAnonymous()">
					<a href="../login"
						class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그인</a>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<form action="${pageContext.request.contextPath}/logout"
						method='post'>
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
						<button
							class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그아웃</button>
						<sec:authentication property="principal.username" var="user_id" />
						<a
							href="${pageContext.request.contextPath}/group/studymypage?id=${user_id }"
							class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">마이페이지</a>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<a href="adminrsv"
								class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">관리자페이지</a>
						</sec:authorize>

						<div id="user_id" class="w3-bar-item w3-right">안녕하세요.
							${user_id }님</div>
					</form>
				</sec:authorize>
			</div>

			<!-- Navbar on small screens -->
			<div id="navDemo"
				class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium">
				<a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">스터디목록</a>
				<a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">스터디만들기</a>
				<a href="#" class="w3-bar-item w3-button"
					onclick="toggleFunction() login">마이페이지</a>
			</div>
		</div>

		<img id='cover-img' src="/cogather/img/group/studygroupmain.jpg">
		
	</div>
	<script>
	//Change style of navbar on scroll
	window.onscroll = function() {myFunction()};
	function myFunction() {
	    var navbar = document.getElementById("myNavbar");
	    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
	        navbar.className = "w3-bar" + " w3-card-2" + " w3-animate-top" + " w3-white" + " w3-hover-light-gray";
	    } else {
	        navbar.className = navbar.className.replace(" w3-card-2 w3-animate-top w3-white w3-hover-light-gray", "");
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