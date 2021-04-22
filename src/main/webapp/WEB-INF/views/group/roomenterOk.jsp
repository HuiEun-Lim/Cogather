<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>방입장 권한 확인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<sec:authorize access="isAnonymous()">
	<script>
		alert("로그인을 해주십시오");
		history.back();
	</script>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
	<c:choose>
	<c:when test="${result == 0 }">
		<script>
			alert("입장하시려는 방에 대한 입장 권한이 없습니다.");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
		<form action="studyroom" name="enterRoom" method="post">
			<input type="hidden" name="sg_id" value="${sg_id }">
			<input type="hidden" name="id" value="${id }">
			<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/> 
		</form>
		<script>
			$("[name='enterRoom']").submit();
		</script>
	</c:otherwise>
</c:choose>
		
</sec:authorize>
</body>
</html>