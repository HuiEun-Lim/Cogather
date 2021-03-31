<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html lang="ko">
<head>
	<title>Home</title>
</head>
<body>
<h1>
	안녕하세요
</h1>

<P>  The time on the server is ${serverTime}. </P>
<img src="<spring:url value='/resources/img/group/mediation.JPG'/>" width="200" >

</body>
</html>
