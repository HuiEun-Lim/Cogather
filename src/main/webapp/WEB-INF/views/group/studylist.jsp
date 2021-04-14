<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
   
<!DOCTYPE html>
<html lang="ko">
<html>

<head>
	<title>studylist</title>
	
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
    <a href="#" class="w3-bar-item w3-button w3-hide-small">스터디만들기</a>
    
    <a href="#" class="w3-bar-item w3-button w3-hide-small">마이페이지</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red login">로그인</a>
  </div>

  <!-- Navbar on small screens -->
  <div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium">
    <a href="#" class="w3-bar-item w3-button studylist" onclick="toggleFunction()">스터디목록</a>
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">스터디만들기</a>
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction() login">마이페이지</a>
  </div>
</div>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

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
	
	$(document).keypress(function (event) {
	    if (event.keyCode === 13) {
	        $("#btnSearch").click();
	    }
	})
</script>
<br><br>

<script>

   // 생략	

	$(document).on('click', '#btnSearch', function(e){

		e.preventDefault();

	
		var url="/cogather/group/studylist";
		
		
		url = url+"?nowPage=${paging.startPage }&cntPerPage=${paging.cntPerPage}";
		 
		url = url + "&searchType=" + $('#searchType').val();

		url = url + "&keyword=" + $('#keyword').val();
	
		
		location.href = url;

		console.log(url);

	});	

</script>

 

<br>스터디 목록들<br>
<b>스터디 방 총 개수 :${paging.total }</b>
  	<c:choose>
			<c:when test="${ empty list || fn:length(list)==0 }">
			
			</c:when>
			<c:otherwise>
				<ul class="row" id="myUl">
				<c:forEach var="dto" items="${list}">
				
				<li class="column">
				
	
				
				

					<img src="/cogather/img/group/upload/${dto.file_name}" width="20%" height="50px" >
					  <p>방번호:${dto.sg_id}</p>
    				 <p><a href="/cogather/group/studyview?sg_id=${dto.sg_id}">스터디주제:${dto.sg_tag}</a></p>
    				 
  				</li>
  				
				</c:forEach>
				</div>
			</c:otherwise>
		</c:choose> 
 <div class="clear"></div>
 <div style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="/cogather/group/studylist?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b style="display: inline;border: 1px solid #FFFFFF; ;margin:0 5px 0 0;background-color:#ffd43b;padding:5px">${p}</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/cogather/group/studylist?nowPage=${p}&cntPerPage=${paging.cntPerPage}&keyword=${paging.keyword}">${p}</a>
				</c:when>
			</c:choose>
			
		</c:forEach>
		
		
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/cogather/group/studylist?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
		</c:if>
	</div>
<button onclick="location.href='/cogather/group/studywrite'" class="writebutton hover">글작성</button>

<!-- <input type="text" id="myInput" onkeyup="myFunction()" placeholder="스터디주제 검색" href="#" class="#" style="border: 2px solid #ffd43b;">
 -->	<!-- 지울 내용들 테스트중 -->
	<div class="form-group row justify-content-center">
			<div class="w300" style="padding-right:10px">

				<input type="text" class="form-control form-control-sm" placeholder="스터디 주제 검색 또는 방번호 검색" name="keyword" id="keyword" style="border: 2px solid #ffd43b;margin:0 0 0 50px;width:30%;height:40px;">




				<button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" style="background:white;border:none;">
					<img src="/cogather/img/group/search.png" class="search"  >
				</button>
			</div>
		</div>
</div>

</body>
</html>