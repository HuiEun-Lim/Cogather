<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<link rel="stylesheet" href="./CSS/mypage.css">
	<link rel="shortcut icon" href="./img/favicon.png" type="image/x-icon" />
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
<title>My Page</title>
</head>

<body>
<script>

function chkDelete(id){
	// 삭제 여부, 다시 확인 하고 진행하기
	var r = confirm("정말 탈퇴하시겠습니까?");
	
	if(r){
		location.href = 'deleteOk?id=' + id;
	}
} // chkDelete

</script>
<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar w3-white" id="myNavbar">
  <div class="choice">
    <a class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right" href="javascript:void(0);" onclick="toggleFunction()" title="Toggle Navigation Menu">
      <i class="fa fa-bars"></i>
    </a>
   </div>
    <a href="${pageContext.request.contextPath}" class="w3-bar-item w3-button w3-hover-none" style="margin-top:0; margin-right:5px">
    	<img src="./img/logo_cut.png" class="logo"  >
    </a>
    <div class="choice">
    <a href="./studycafe/main" class="w3-bar-item w3-button w3-hide-small">HOME</a>
    <a href="./studycafe/info" class="w3-bar-item w3-button w3-hide-small">시설소개</a>
    <a href="./studycafe/reservation" class="w3-bar-item w3-button w3-hide-small">예약하기</a>
    <a href="./studycafe/map" class="w3-bar-item w3-button w3-hide-small">오시는 길</a>
    <sec:authorize access="isAnonymous()">
    	<a href="login" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그인</a>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
    	<form action="${pageContext.request.contextPath}/logout" method='post'>
		<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
		<button class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">로그아웃</button>
		<sec:authentication property="principal.username" var="user_id" />
    	<a href="cafemypage?id=${user_id }" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red w3-border-bottom w3-border-amber">마이페이지</a>
    	<sec:authorize access="hasRole('ROLE_ADMIN')">
    	<a href="./studycafe/adminpage" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red">관리자페이지</a>
		</sec:authorize>
        <div id="user_id" class="w3-bar-item w3-right">안녕하세요. ${user_id }님</div>
    	</form>
   	</sec:authorize>
  </div>
  </div>

  <!-- Navbar on small screens -->
  <div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium">
  	<a href="./studycafe/main" class="w3-bar-item w3-button" onclick="toggleFunction()">HOME</a>
    <a href="./studycafe/info" class="w3-bar-item w3-button" onclick="toggleFunction()">시설소개</a>
    <a href="./studycafe/reservation" class="w3-bar-item w3-button" onclick="toggleFunction()">예약하기</a>
    <a href="./studycafe/map" class="w3-bar-item w3-button" onclick="toggleFunction()">오시는 길</a>
    <sec:authorize access="isAnonymous()">
    <a href="login" class="w3-bar-item w3-button" onclick="toggleFunction()">로그인</a>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
    <a class="w3-bar-item w3-button" onclick="toggleFunction()">마이페이지</a>
    <form action="${pageContext.request.contextPath}/logout" method='post'>
		<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
		<button class="w3-bar-item w3-button" onclick="toggleFunction()">로그아웃</button>
    </form>
    </sec:authorize>
    <sec:authorize access="hasRole('ROLE_ADMIN')">
    <a href="./studycafe/adminpage" class="w3-bar-item w3-button" onclick="toggleFunction()">관리자페이지</a>
	</sec:authorize>
  </div>
</div>
<div id="wrap">
	<main class="content">
	<div class="container-fluid p-0">
	<div class="w3-padding-64" style="margin-top:90px">
    	<h3>마이 페이지 </h3>
		<div class="w3-light-grey" style="height:2px; margin-bottom: 30px" >
    		<div style="width:10%; height:2px; background-color:#FDBF26"></div>
		</div>
		<div class="row">
			<div class="col-md-4 col-xl-3">
				<div class="card mb-3">
					<div class="card-header">
						<h4 class="card-title mb-0">Profile</h4>
					</div>
					<div class="card-body text-center">
						<img src="<%=request.getContextPath() %>/${dto.pimg_url}" class="img-fluid rounded-circle mb-2" style="object-fit: cover; width:128px; height:128px" />
						<h5 class="card-title mb-0">${dto.id}</h5>
						<div class="text-muted mb-2">${dto.name}</div>
						<br>
						<div>
						<button onclick="location.href='userEdit?id=${dto.id}'" class="btn-primary">정보 수정하기</button>
						<button onclick="chkDelete('${dto.id}')" class="btn-primary">탈퇴하기</button>
						</div>
					</div>
					<br>
					<hr class="my-0" />
					<div class="card-body">
						<h4 class="h6 card-title">Info</h4>	
						<h5><i class="fas fa-mobile-alt"></i>&nbsp; 전화번호</h5>
							<c:choose>
								<c:when test="${dto.phone == null}">정보 없음</c:when>
								<c:when test="${dto.phone != null}">${dto.phone }</c:when>
								</c:choose>
							<h5><i class="fas fa-envelope-open-text"></i>&nbsp; e-mail</h5>
							<c:choose>
							<c:when test="${dto.email eq null}">정보 없음</c:when>
							<c:when test="${dto.email != null}">${dto.email }</c:when>
							</c:choose><br>
					</div>
					<hr class="my-0" />
					<div class="card-body">
						<h4 class="h6 card-title">관심태그</h4><br>
						<c:choose>
							<c:when test="${dto.tag eq null}">정보 없음</c:when>
							<c:when test="${dto.tag != null}">${dto.tag }</c:when>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="col-md-8 col-xl-9">
				<div class="card">
					<div class="card-header">
						<h5 class="card-title mb-0"><i class="far fa-calendar-check"></i>&nbsp; 예약 정보</h5>
					</div>
					<div class="card-body h-100">
		<table class="w3-table w3-bordered w3-centered w3-large w3-card-4">
		<tr class="w3-amber">
			<th>예약번호</th>
			<th>예약좌석</th>
			<th>예약시작날짜</th>
			<th>예약종료날짜</th>
			<th>결제방법</th>
		</tr>

		<c:choose>
		<c:when test="${empty list || fn:length(list) == 0 }">
		<tr><td colspan="5">예약 정보 없음</td></tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="list" items="${list }">
				<tr>
					<td>${list.res_id }</td>
					<td>${list.seat_id }</td>
					<td>${list.getStart_dateTime() }</td>
					<td>${list.getEnd_dateTime() }</td>
					<td>${list.payment }</td>
				</tr>			
			</c:forEach>
		</c:otherwise>
		</c:choose>
	</table><br><br>
	<div class="move">
	<p><i class="fas fa-check"></i>&nbsp;같이 공부할 공간을 찾고 싶다면 <a href="./studycafe/reservation">코게더 스터디 카페 예약으로 가기</a></p>
	</div>
	<br>
					</div>
				</div>

				<div class="card">
					<div class="card-header">
						<h5 class="card-title mb-0"><i class="fas fa-users"></i>&nbsp;가입한 그룹</h5>
					</div>
					<div class="card-body h-100">
		<table class="w3-table w3-bordered w3-centered w3-large w3-card-4">
		<tr class="w3-amber">
			<th>그룹ID</th>
			<th>그룹명</th>
			<th>권한</th>
		</tr>

		<c:choose>
		<c:when test="${empty group || fn:length(group) == 0 }">
		<tr><td colspan="3">가입한 그룹 없음</td></tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="i" begin="0" end= "${fn:length(group) }" step="1" >
			
				<tr>
					<td>${group[i].sg_id }</td>
					<td>${sgroup[i].sg_name }</td>
					<td>${group[i].g_auth }</td>
				</tr>			
			</c:forEach>
		</c:otherwise>
		</c:choose>
	</table>
	<br><br>
	<div class="move">
	<p><i class="fas fa-check"></i>&nbsp;같이 공부할 사람들 찾고 싶다면 <a href="${pageContext.request.contextPath}/group/studygroup">코게더 스터디 그룹으로 가기</a></p>
	</div>
	<br>
					</div>
				</div>
			</div>
			
			
		</div>
	</div>
	</div>
	</main>
</div>

<script>

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