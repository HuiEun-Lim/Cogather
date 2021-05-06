<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<html>

<head>
	<title>Home</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="../CSS/common.css">
	<link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<!-- Navbar (sit on top) -->


<%@ include file="kigroupcover.jsp" %> 



<script>

   // 생략	

	$(document).on('click', '#btnSearch', function(e){

		e.preventDefault();

	
		var url="../group/studylist";
		
		
		url = url+"?nowPage=${paging.startPage }&cntPerPage=${paging.cntPerPage}";
		 
		url = url + "&searchType=" + $('#searchType').val();

		url = url + "&keyword=" + $('#keyword').val();
	
		
		location.href = url;

		console.log(url);

	});	
	$(document).keypress(function (event) {
	    if (event.keyCode === 13) {
	        $("#btnSearch").click();
	    }
	})
</script>

 


<b>스터디 방 총 개수 :${paging.total }</b>
  	<c:choose>
			<c:when test="${ empty list || fn:length(list)==0 }">
			
			</c:when>
			<c:otherwise>
				<ul class="row" id="myUl">
				<c:forEach var="dto" items="${list}">
				
				<li class="column" style="word-break: break-all;overflow:auto">
				
				
					<a href="../group/studyview?sg_id=${dto.sg_id}" style="text-decoration:none;"><img src="../img/group/${dto.file_name}" style="float:right;
	left:-40%; position:relative;border: 2px solid #ddd;background: url(/cogather/img/borderdesign.jpg); border-radius: 50px;padding: 5px;" width="20%" height="50px" onerror="this.src='/cogather/img/logo.png'">
					</a></div><br><br>
					  <p><a href="../group/studyview?sg_id=${dto.sg_id}" style="text-decoration:none;float:left;
	right:-32%; position:relative;word-break: break-all;">방번호:${dto.sg_id}</a></p><br>
	 <p><a href="../group/studyview?sg_id=${dto.sg_id}" style="text-decoration:none;float:left;
	right:-30%; position:relative;word-break: break-all;">이름:${dto.sg_name}</a></p><br>
    				 <p><a href="../group/studyview?sg_id=${dto.sg_id}" style="text-decoration:none;float:left;
	right:-30%; position:relative;word-break: break-all;">주제:${dto.sg_tag}</a></p>
    				 
  				</li>
  				
				</c:forEach>
				
			</c:otherwise>
		</c:choose> 
 <div class="clear"></div>
 <div style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="../group/studylist?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b style="display: inline;border: 1px solid #FFFFFF; ;margin:0 5px 0 0;background-color:#ffd43b;padding:5px">${p}</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="../group/studylist?nowPage=${p}&cntPerPage=${paging.cntPerPage}&keyword=${paging.keyword}">${p}</a>
				</c:when>
			</c:choose>
			
		</c:forEach>
		
		
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="../group/studylist?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
		</c:if>
	</div>
<c:if test="${user_id ne null}">
<button onclick="location.href='../group/studywrite'" class="writebutton hover">글작성</button>
</c:if>
<!-- <input type="text" id="myInput" onkeyup="myFunction()" placeholder="스터디주제 검색" href="#" class="#" style="border: 2px solid #ffd43b;">
 -->	<!-- 지울 내용들 테스트중 -->
	<div class="form-group row justify-content-center">
			<div class="w300" style="padding-right:10px">

				<input type="text" class="form-control form-control-sm" placeholder="스터디 주제 검색 또는 방번호 검색" name="keyword" id="keyword" style="border: 2px solid #ffd43b;margin:0 0 0 10px;width:30%;height:40px;">




				<button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" style="background:white;border:none;">
					<img src="../img/group/search.png" class="search"  >
				</button>
			</div>
		</div>
</div>

</body>
</html>