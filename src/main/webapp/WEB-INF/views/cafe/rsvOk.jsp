<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      

<c:choose>
	<c:when test="${result == 0 }">
		<script>
			alert("예약 실패!!!!!!");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>예약확인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="/cogather/JS/cafersv.js"></script>

</head>
<body>
			<div class="w3-button" id="apibtn"><img src="/cogather/img/kakaopaybtn.png"></div>

</body>
</html>
	</c:otherwise>
</c:choose>


























