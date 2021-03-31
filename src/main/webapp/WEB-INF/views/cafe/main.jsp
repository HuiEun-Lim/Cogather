<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="/cogather/CSS/cafemain.css">
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
	<title>Main</title>
</head>
<body>
<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar" id="myNavbar">
    <a class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right" href="javascript:void(0);" onclick="toggleFunction()" title="Toggle Navigation Menu">
      <i class="fa fa-bars"></i>
    </a>
    <a href="#" class="w3-bar-item w3-button w3-hover-none" style="margin-top:0; margin-right:5px">
    	<img src="/cogather/img/logo_cut.png" class="logo"  >
    </a>
    <div class="choice">
    <a href="#home" class="w3-bar-item w3-button">HOME</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small">시설소개</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small">예약하기</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small">오시는 길</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그인</a>
  </div>
  </div>

  <!-- Navbar on small screens -->
  <div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium">
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">시설소개</a>
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">예약하기</a>
        <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">오시는 길</a>
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">로그인</a>
  </div>
</div>

<div class="bgimg w3-display-container " id="home">
	<div class="w3-display-middle w3-center" style="white-space:nowrap;">
	<span class="w3-padding-small w3-jumbo w3-text-white w3-wide w3-animate-opacity" >코게더</span><br>
	<span class="w3-padding-large w3-xxlarge w3-text-white w3-wide w3-animate-opacity" >함께 꿈을 모으는 곳</span>
	</div>
</div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


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
