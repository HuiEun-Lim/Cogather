<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html lang="ko">
<html>

<head>
	<title>Home</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="/cogather/CSS/common.css">
	
</head>
<body>
<!-- Navbar (sit on top) -->
<div id="wrap">
<div class="w3-top">
  <div class="w3-bar" id="myNavbar">
    <a class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right" href="javascript:void(0);" onclick="toggleFunction()" title="Toggle Navigation Menu">
      <i class="fa fa-bars"></i>
    </a>
    <a href="/cogather/group/studygroup" class="w3-bar-item w3-button">
    	<img src="/cogather/img/logo_cut.png" class="logo"  >
    </a>
    <a href="/cogather/group/studylist" class="w3-bar-item w3-button w3-hide-small">스터디목록</a>
    <a href="/cogather/group/studywrite" class="w3-bar-item w3-button w3-hide-small">스터디만들기</a>
   
     <a href="#" class="w3-bar-item w3-button w3-hide-small">마이페이지</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red login">로그인</a>
  </div>

  <!-- Navbar on small screens -->
  <div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium">
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">스터디목록</a>
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">스터디만들기</a>
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction() login">마이페이지</a>
  </div>
</div>


<img src="/cogather/img/group/studygroupmain.jpg" width="100%" height="300px" >

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

<br><br>
<h5>최근 스터디</h5>

<c:choose>
			<c:when test="${ empty list || fn:length(list)==0 }">
			
			</c:when>
			<c:otherwise>
				
				<c:forEach var="dto" items="${list}">
				<ul id="myUl" class="row">
				<li class="column">
   					 
    				 <p>방번호:${dto.sg_id}</p>
    				 <p>스터디명:${dto.sg_tag}</p>
  				</li>
  				
				</c:forEach>
				<li class="column new_div">
   					 <h5 style="text-align:center">신규 스터디 생성</h5>
   					 <button style="border:none;class="button_add"><img src="/cogather/img/group/add.png" class="add"onclick="location.href='/cogather/group/studywrite'" ></button>
				  	<p></p>
				  	
  				</li>
				</ul>
				
			</c:otherwise>
		</c:choose>
</div>

</body>
</html>