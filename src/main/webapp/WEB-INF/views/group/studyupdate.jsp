<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<c:choose>
	<c:when test="${empty list || fn:length(list) == 0 }">
		<script>
			alert("해당 정보가 삭제되거나 없습니다");
			history.back();
		</script>
	</c:when>
	
	<c:otherwise>

    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>수정</title>
	<link rel="stylesheet" href="/cogather/CSS/common.css">
</head>

<body>

<div id="write_id">
<h2>수정</h2>
<script src="/cogather/JS/ckeditor/ckeditor.js">
</script>

<form name="frm" action="studyupdateOk" method="post" onsubmit="return chkSubmit()">
<input type="hidden" name="sg_id" value="${list[0].sg_id}"/>
스터디 이름:&nbsp&nbsp
<input type="text" name="sg_name" style="width:20%;height:30px;" value="${list[0].sg_name}"/><br><br>
스터지 주제: <input type="text" name="sg_tag" style="width:20%;height:30px;" value="${list[0].sg_tag}"/><br><br>
그룹 정보:<textarea name="sg_info" id="editor1" style="width:640;height:600;margin:0 0 0 0px;">${list[0].sg_info}</textarea><br><br>
<script>
	CKEDITOR.replace('editor1',
			{
		width:'100%',
		height:'300px',
		allowedContent:true,
		//filebrowserUploadUrl:'${pageContext.request.contextPath}/studywriteOk'
		toolbar:[['Bold','Italic'],['NumberedList']]
	});

</script>
카톡방 주소:&nbsp&nbsp
<input type="text" name="kko_url" style="width:20%;height:30px;" value="${list[0].kko_url}"/><br><br>
<br><br>
<input type="submit" value="수정" class="updatebutton"/>
</form>
<button onclick="history.back();" class="yesterdaybutton">이전으로</button>
<button onclick="location.href='studylist'" class="listupdate">목록보기</button>
<br>
</div>
</body>
</html>

	</c:otherwise>
</c:choose>
