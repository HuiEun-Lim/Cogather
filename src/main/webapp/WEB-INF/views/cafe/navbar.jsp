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
	<link rel="stylesheet" href="../CSS/cafemain.css">
	<link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
</head>
<body>
<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar w3-white" id="myNavbar">
  <div class="choice">
    <a class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right" href="javascript:void(0);" onclick="toggleFunction()" title="Toggle Navigation Menu">
      <i class="fa fa-bars"></i>
    </a>
   </div>
    <a href="${pageContext.request.contextPath}" class="w3-bar-item w3-button w3-hover-none" style="margin-top:0; margin-right:5px">
       <img src="../img/logo_cut.png" class="logo"  >
    </a>
    
    <div class="choice">
    <a href="main" class="w3-bar-item w3-button w3-hide-small">HOME</a>
    <a href="info" class="w3-bar-item w3-button w3-hide-small">시설소개</a>
    <a href="reservation" class="w3-bar-item w3-button w3-hide-small">예약하기</a>
    <a href="map" class="w3-bar-item w3-button w3-hide-small">오시는 길</a>
    <sec:authorize access="isAnonymous()">
    	<a href="../login" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그인</a>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
    	<form action="${pageContext.request.contextPath}/logout" method='post'>
		<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
		<button class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그아웃</button>
		<sec:authentication property="principal.username" var="user_id" />
    	<a href="../mypage?id=${user_id }" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">마이페이지</a>
    	<sec:authorize access="hasRole('ROLE_ADMIN')">
    	<a href="adminpage" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">관리자페이지</a>
		</sec:authorize>
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
    <a href="../mypage?id=${user_id }" class="w3-bar-item w3-button" onclick="toggleFunction()">마이페이지</a>
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
<script>
	//Change style of navbar on scroll
	window.onscroll = function() {myFunction()};
	function myFunction() {
	    var navbar = document.getElementById("myNavbar");
	    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
	        navbar.className = "w3-bar" + " w3-card-2" + " w3-white" + " w3-hover-light-gray";
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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- 	피켓버튼 -->
	
	<script>
	// 피켓 버튼 애니메이션
		var txt = "스터디 카페"
		var i = 0;
		var speed = 100;
		$(function(){
			
			$("#picket").on({
				mouseenter: function(){
					typeWriter();
					$(this).css("cursor", "pointer");
					$(this).animate({left: '0px'},1000);
				},
				mouseleave: function(){
					$("div.where").html("");
					i = 0;
					$(this).animate({left: '-60px'},1000);
				},
				click: function(){
					location.href= "../studycafe/main";
				}
				
			})
		});
		function typeWriter(){
			if (i < txt.length){
				$(".where").html($(".where").html() + txt.charAt(i));
				i++;
				setTimeout(typeWriter, speed);
			}
		}
		</script>
</body>
</html>