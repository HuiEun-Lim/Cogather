<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      

<c:choose>
	<c:when test="${result == 0 }">
		<script>
			alert("수정 실패");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("회원정보수정 성공~\n새로운 마음가짐으로 화이팅!!");
			location.href = "${pageContext.request.contextPath}/mypage";
		</script>
	</c:otherwise>
</c:choose>