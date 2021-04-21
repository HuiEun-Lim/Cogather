<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
   
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
	<link href="../CSS/app.css" rel="stylesheet">
	<script type="text/javascript" src="../JS/adminrsv.js"></script>
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
	<title>예약현황</title>
</head>
<body>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="adminpage">
					<span class="align-middle">코게더 관리자</span>
				</a>
				<ul class="sidebar-nav">
					<li class="sidebar-item">
						<a class="sidebar-link" href="adminrsv">
							<i class="align-middle" data-feather="list"></i> <span class="align-middle">전체 예약 내역</span>
						</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="main">
							<i class="align-middle" data-feather="book"></i> <span class="align-middle">스터디카페 바로가기</span>
						</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${pageContext.request.contextPath}/group/studygroup">
							<i class="align-middle" data-feather="users"></i> <span class="align-middle">스터디그룹 바로가기</span>
						</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${pageContext.request.contextPath}/group/studygroup">
							<i class="align-middle" data-feather="settings"></i> <span class="align-middle">스터디그룹 관리자페이지</span>
						</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="">
							<i class="align-middle" data-feather="log-out"></i> <span class="align-middle">로그아웃</span>
						</a>
					</li>
				</ul>
			</div>
		</nav>
    
    	<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<a class="sidebar-toggle d-flex">
					<i class="hamburger align-self-center"></i>
				</a>
			</nav>
			<main class="content">
				<div class="container-fluid p-0">
				<div class="row">
						<div class="col-12 col-lg-12 col-xxl-12 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">전체예약내역</h5>
									        <input type="text" id="search" class="w3-right" placeholder="search..">
									
								</div>
								<table class="table table-hover my-0" id="alltable">
									<thead>
										<tr>
											<th>예약번호</th>
									    	<th>회원ID</th>
									    	<th>좌석번호</th>
									    	<th>시작시간</th>
									    	<th>종료시간</th>
									    	<th>결제방법</th>
									    	<th>예약취소</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
								    	<c:when test="${empty list || fn:length(list) == 0 }">
								    	</c:when>
								    	<c:otherwise>
								    		<c:forEach var="dto" items="${list }">
								    		<tr>
								    		<td>${dto.res_id }</td>
								    		<td>${dto.ID} </td>
								    		<td>${dto.seat_id} </td>
								    		<td>${dto.getStart_dateTime()} </td>
								    		<td>${dto.getEnd_dateTime()} </td>
								    		<td>${dto.payment} </td>
								    		<td><button class="w3-red w3-text-light-grey" onclick="chkDelete(${dto.res_id })">예약취소</button></td>
								    		</tr>
								    		</c:forEach>
								    	</c:otherwise>
								    	</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</main>
    	</div>
	 </div>
    <!-- Footer -->
<footer class="w3-center w3-black w3-padding-64">
  <a href="wrap" class="w3-button w3-light-grey"><i class="fa fa-arrow-up w3-margin-right"></i>To the top</a>
  <div class="w3-xlarge w3-section w3-center">
    <table>
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
    

<script src="../JS/app.js"></script>
<script>
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
</script>
<script>
    var $rows = $('#alltable tr');
	$('#search').keyup(function() {
	    
	    var val = '^(?=.*\\b' + $.trim($(this).val()).split(/\s+/).join('\\b)(?=.*\\b') + ').*$',
	        reg = RegExp(val, 'i'),
	        text;
	    
	    $rows.show().filter(function() {
	        text = $(this).text().replace(/\s+/g, ' ');
	        return !reg.test(text);
	    }).hide();
	});
</script>
</body>
</html>