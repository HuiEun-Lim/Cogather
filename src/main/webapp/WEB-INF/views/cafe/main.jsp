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
  <div class="choice">
    <a class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right" href="javascript:void(0);" onclick="toggleFunction()" title="Toggle Navigation Menu">
      <i class="fa fa-bars"></i>
    </a>
   </div>
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
	<div class="w3-row-padding w3-padding-top-64">
	     <div class="w3-col s2 w3-center"><p></p></div>
	     <div class="w3-col s2 w3-center"><p><img src="/cogather/img/cafe/24.png" style="width: 80px"><br>노트북, 핸드폰 충전기 그외 편의물품</p></div>
	          <div class="w3-col s1 w3-center"><p></p></div>    
	     <div class="w3-col s2 w3-center"><p><img src="/cogather/img/cafe/muted.png" style="width: 80px"></p></div>
	          <div class="w3-col s1 w3-center"><p></p></div>
	     <div class="w3-col s2 w3-center"><p><img src="/cogather/img/cafe/charger.png" style="width: 80px"></p></div>
	     <div class="w3-col s2 w3-center"><p></p></div>
	</div>
<div id="wrap">
	
	dnkadna
	ksnak
	ksnakc
	knknksan
	
</div>
<!-- Slideshow container -->
<div class="slideshow-container">

  <!-- Full-width images with number and caption text -->
  <div class="mySlides fade">
    <div class="numbertext">1 / 3</div>
    <img src="/cogather/img/cafe/mainback.png" style="width:100%">
  </div>

  <div class="mySlides fade">
    <div class="numbertext">2 / 3</div>
    <img src="/cogather/img/cafe/mainback.png" style="width:100%">
  </div>

  <div class="mySlides fade">
    <div class="numbertext">3 / 3</div>
    <img src="/cogather/img/cafe/mainback.png" style="width:100%">
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
