<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="../CSS/cafemain.css">
	<link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
	<title>Main</title>
</head>
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
    <a href="#home" class="w3-bar-item w3-button w3-hide-small">HOME</a>
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
    	<a href="../cafemypage?id=${user_id }" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">마이페이지</a>
    	<sec:authorize access="hasRole('ROLE_ADMIN')">
    	<a href="adminrsv" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">관리자페이지</a>
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

<div class="bgimg w3-display-container " id="home">
	<div class="w3-display-middle w3-center" style="white-space:nowrap;">
	<span class="w3-padding-small w3-jumbo w3-text-white w3-wide w3-animate-opacity" >코게더</span><br>
	<span class="w3-padding-large w3-xxlarge w3-text-white w3-wide w3-animate-opacity" >함께 꿈을 모으는 곳</span>
	</div>
</div>
<div id="wrap">
	<div class="w3-row-padding w3-padding-top-64">
	     <div class="w3-col s4 w3-center"><p class="info"><img src="../img/cafe/24.png" class="infoimg"><br>24시간 영업<br>언제나 이용 가능</p></div>   
	     <div class="w3-col s4 w3-center"><p class="info"><img src="../img/cafe/muted.png" class="infoimg"><br>조용한 공간<br>집중하기 좋은 장소</p></div>
	     <div class="w3-col s4 w3-center"><p class="info"><img src="../img/cafe/charger.png" class="infoimg"><br>충전기, 독서대 등<br>편의물품 무료제공</p></div>
	</div>
	

<div class="w3-paddig-64" style="margin-top:90px" >
<h3> 매장 둘러보기 </h3>
<div class="w3-light-grey" style="height:2px" >
    <div  style="width:10%; height:2px; background-color:#FDBF26"></div>
</div>
</div>

<!-- Slideshow container -->
<div class="slideshow-container w3-padding-top-64">

  <!-- Full-width images with number and caption text -->
  <div class="mySlides fade">
    <img src="../img/cafe/mainback.png" class="slimg">
  </div>

  <div class="mySlides fade">
    <img src="../img/cafe/charger.png" class="slimg">
  </div>

  <div class="mySlides fade">
    <img src="../img/cafe/muted.png" class="slimg">
  </div>

  <!-- Next and previous buttons -->
  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
  <a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>
<br>

<!-- The dots/circles -->
<div style="text-align:center">
  <span class="dot" onclick="currentSlide(1)"></span>
  <span class="dot" onclick="currentSlide(2)"></span>
  <span class="dot" onclick="currentSlide(3)"></span>
</div>
</div>

<br><br><br><br><br><br><br><br><br><br>


<!-- Footer -->
<footer class="w3-center w3-black w3-padding-64">
  <a href="#home" class="w3-button w3-light-grey"><i class="fa fa-arrow-up w3-margin-right"></i>To the top</a>
  <div class="w3-xlarge w3-section w3-center">
    <table style="color:white">
    <tr>
    <th>대표자 정보</th>
    <th style="width:10px"></th>
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
    <td>cogather@gmail.com</td>
    <td></td>
    <td>스터디그룹 http:.....</td>
    </tr>
    </table>
  </div>
</footer>

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
	
	var slideIndex = 1;
	showSlides(slideIndex);

	// Next/previous controls
	function plusSlides(n) {
	  showSlides(slideIndex += n);
	}

	// Thumbnail image controls
	function currentSlide(n) {
	  showSlides(slideIndex = n);
	}

	function showSlides(n) {
	  var i;
	  var slides = document.getElementsByClassName("mySlides");
	  var dots = document.getElementsByClassName("dot");
	  if (n > slides.length) {slideIndex = 1}
	  if (n < 1) {slideIndex = slides.length}
	  for (i = 0; i < slides.length; i++) {
	      slides[i].style.display = "none";
	  }
	  for (i = 0; i < dots.length; i++) {
	      dots[i].className = dots[i].className.replace(" active", "");
	  }
	  slides[slideIndex-1].style.display = "block";
	  dots[slideIndex-1].className += " active";
	}
	
</script>

</body>
</html>
