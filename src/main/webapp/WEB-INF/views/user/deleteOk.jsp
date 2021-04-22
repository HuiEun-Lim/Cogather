<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<c:choose>
	<c:when test="${result == 0 }">
		<script>
			alert("이건 아니야!!\n가지마세요!!ㅠㅠ");
			locatioin.href= "${pageContext.request.contextPath}";
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("그동안 감사했습니다. \n좋은 인연으로 다시 만나요!!");
			location.href = "${pageContext.request.contextPath}"; <%-- 삭제후에는 list 로 가자 --%>
		</script>
	</c:otherwise>
</c:choose>