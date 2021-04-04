<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>방입장 권한 확인</title>
<script src="${pageContext.request.contextPath }/JS/chat.js"></script>
</head>
<body>
<c:choose>
	<c:when test="${result == 0 }">
		<script>
			alert("입장하시려는 방에 대한 입장 권한이 없습니다.");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("방에 입장합니다");
			
			location.href="studyroom?sg_id=${sg_id}&id=${id}";
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>