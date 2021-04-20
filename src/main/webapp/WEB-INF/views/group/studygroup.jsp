<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!DOCTYPE html>
<html lang="ko">

<head>
	<title>Home</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="../CSS/common.css">
	<link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
</head>
<body>
<!-- Navbar (sit on top) -->

<%@ include file="groupcover.jsp" %>

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
<br><br><br>

</body>
</html>