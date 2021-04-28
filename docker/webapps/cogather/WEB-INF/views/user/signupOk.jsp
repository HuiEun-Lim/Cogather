<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      

<c:choose>
	<c:when test="${result == 0 }">
		<script>
			alert("가입 실패");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("가입성공! \n코게더의 가족이 되신 걸 환영합니다~!");
			location.href = "${pageContext.request.contextPath}/studycafe/main";
		</script>
	</c:otherwise>
</c:choose>