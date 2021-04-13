<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/cogather/CSS/login.css">
<link rel="shortcut icon" href="/cogather/img/favicon.png" type="image/x-icon" />
<title>login</title>
</head>
<body>
<div id="wrap">
<div class="w3-paddig-64" style="margin-top:90px" >
<h2 class="w3-center"> 로그인 </h2>
<div  style="height:2px; background-color:#FDBF26"></div>
</div>

<div id="wrap2">
<form name="frm" action="${pageContext.request.contextPath}/login" method="post">
<br>
<h5>아이디</h5>
<input type="text" name="username"/><br>
<h5>패스워드</h5>
<input type="password" name="password"/><br><br>
<input type="submit" class="btn" value="로그인"><br>
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
</form>
<br>
<div class="join">아직 코게더의 회원이 아니라면?<a href="signup" class="w3-right">회원가입</a></div>
</div>
</div>
</body>
</html>