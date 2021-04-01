<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>방 퇴실 확인</title>
</head>
<body>
<c:choose>
	<c:when test="${result == 0 }">
		<script>
			alert("문제가 발생");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("방을 나갑니다.");
			location.href="studygroup";
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>