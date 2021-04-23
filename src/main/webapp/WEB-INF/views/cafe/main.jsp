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
	<title>Main</title>
</head>
<body>
<%@ include file="../cafe/navbar.jsp"%>

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
<div class="picket-wrapper">
		<div class="where"></div>
		<img id="picket" src="../img/arrow-right.png">
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
  <div class="mySlides fadeout">

    <img src="../img/cafe/main_lobby.jpg" class="slimg">
  </div>

  <div class="mySlides fadeout">
    <img src="../img/cafe/main_seats.jpg" class="slimg">
  </div>

  <div class="mySlides fadeout">
    <img src="../img/cafe/main_room.jpg" class="slimg">
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

<%@ include file="../cafe/footer.jsp"%>

<script>
	//Change style of navbar on scroll
	window.onscroll = function() {myFunction()};
	function myFunction() {
	    var navbar = document.getElementById("myNavbar");
	    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
	        navbar.className = "w3-bar" + " w3-card-2" + " w3-animate-top" + " w3-black" + " w3-hover-light-gray";
	    } else {
	        navbar.className = navbar.className.replace(" w3-card-2 w3-animate-top w3-black w3-hover-light-gray", "");
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
	// 피켓 버튼 애니메이션
	var txt = "스터디그룹"
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
				location.href= "../group/studygroup";
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
