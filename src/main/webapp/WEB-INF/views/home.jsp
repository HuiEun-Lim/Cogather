<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<html>

<head>
	<title>Home</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
</head>
<body>
	<button onclick="location.href='${pageContext.request.contextPath }/studycafe/main'"> 스터디 카페</button>
	<button onclick="location.href='${pageContext.request.contextPath }/group/studygroup'"> 스터디 그룹</button>
	
</body>
</html>
