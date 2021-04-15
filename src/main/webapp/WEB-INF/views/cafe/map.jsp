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
   <link rel="stylesheet" href="../CSS/cafemap.css">
   <script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
   <script type="text/javascript" src="../JS/cafemap.js"></script>
   <title>오시는길</title>
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
    <a href="main" class="w3-bar-item w3-button w3-hide-small">HOME</a>
    <a href="info" class="w3-bar-item w3-button w3-hide-small">시설소개</a>
    <a href="reservation" class="w3-bar-item w3-button w3-hide-small">예약하기</a>
    <a href="map" class="w3-bar-item w3-button w3-hide-small w3-border-bottom w3-border-amber">오시는 길</a>
    <sec:authorize access="isAnonymous()">
    	<a href="../login" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그인</a>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
    	<form action="${pageContext.request.contextPath}/logout" method='post'>
		<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
		<button class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그아웃</button>
    	<a href="cafemypage?id=${user_id }" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">마이페이지</a>
    	<sec:authorize access="hasRole('ROLE_ADMIN')">
    	<a href="adminrsv" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">관리자페이지</a>
		</sec:authorize>
		<sec:authentication property="principal.username" var="user_id" />
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
    
<div id="wrap">
       <div class="w3-padding-64" style="margin-top:90px">
          <h3>오시는길</h3>
         <div class="w3-light-grey" style="height:2px; margin-bottom: 70px" >
             <div style="width:10%; height:2px; background-color:#FDBF26"></div>
         </div>
             <!-- 이미지 지도를 표시할 div 입니다 -->
            <div id="staticMap" style="width:800px;height:400px;"></div>
            <button class="w3-btn w3-amber w3-round w3-right"onClick="window.open('https://map.kakao.com/link/to/코게더스터디카페,37.500163197126824, 127.03533536432606')"><span style="font-size: 15px; color: white">카카오 길찾기</span></button>
            
           </div>
           
           <div>              
             <div id="tname">
                역삼역 스터디룸 <span style="color:#FDBF26"><b>코게더</b></span>
             </div>
            <div class="w3-light-grey" style="height:2px; margin-bottom: 30px" ></div>
            <table class="tinfo">
            <tr>
            <td class="tabledata"><img src="/cogather/img/cafe/placeholder.png" class="timg">위치</td>
            <td class="tabledata">역삼역 3번출구</td>
            </tr>
            <tr>
            <td></td>
            <td>주차불가</td>
            </tr>
            </table>
            <div class="w3-light-grey" style="height:2px; margin-bottom: 30px" ></div>
            <table class="tinfo">
            <tr>
            <td class="tabledata"><img src="/cogather/img/cafe/phone-call.png" class="timg">전화번호</td>
            <td class="tabledata">010-1234-5678</td>
            </tr>
            </table>
            <div class="w3-light-grey" style="height:2px; margin-bottom: 30px" ></div>
            <table class="tinfo">
            <tr>
            <td class="tabledata"><img src="/cogather/img/cafe/bus.png" class="timg">대중교통</td>
            <td class="tabledata"><img src="/cogather/img/cafe/bus-stop.png" class="timg">3600 146 </td>
            </tr>
            <tr>
            <td></td>
            <td class="tabledata"><img src="/cogather/img/cafe/train.png" class="timg">2호선</td>
            </tr>
            </table>
            <div class="w3-light-grey" style="height:2px; margin-bottom: 30px" ></div>
         </div>
    </div>
    <!-- Footer -->
<footer class="w3-center w3-black w3-padding-64">
  <a href="wrap" class="w3-button w3-light-grey"><i class="fa fa-arrow-up w3-margin-right"></i>To the top</a>
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
    

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7f36e46956483ffffb803d95f128023d"></script>
<script>
    window.onscroll = function() {myFunction()};
	function myFunction() {
	    var navbar = document.getElementById("myNavbar");
	    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
	        navbar.className = "w3-bar" + " w3-card-2" + " w3-white";
	    } else {
	        navbar.className = navbar.className.replace(" w3-card-2 w3-animate-top w3-white w3-hover-border-bottom w3-border-amber", "");
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
   myMap();

</script>
</body>
</html>