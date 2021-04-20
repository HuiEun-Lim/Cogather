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
		<script>
			alert("예약 성공, 금액은 현장에서 결제해주세요");
			location.href = "map";
		</script>
	</c:otherwise>
</c:choose>