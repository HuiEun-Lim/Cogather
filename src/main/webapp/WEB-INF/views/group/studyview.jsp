<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="/cogather/CSS/common.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

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
<title>읽기</title>
</head>
<script>
	function openWin(){
		window.open('${list[0].kko_url}', "kakaoTalk", "width=1000, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 

	}
	
</script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<!-- lightbox2 제이퉈리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.1/css/lightbox.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.1/js/lightbox.min.js"></script>
<script>

function chkDelete(sg_id){
	// 삭제 여부, 다시 확인 하고 진행하기
	var r = confirm("삭제하시겠습니까?");
	
	if(r){
		location.href = 'studydeleteOk?sg_id=' + sg_id;
	}
} // chkDelete
function fn_fileDown(sg_id){
	var formObj = $("form[name='readForm']");
	$("#SG_ID").attr("value", sg_id);
	formObj.attr("action", "/cogather/group/fileDown");
	formObj.submit();  
//	location.href = '/cogather/group/fileDown';
	
}
lightbox.option({
    resizeDuration: 200,
    wrapAround: true,
    disableScrolling: false,
    fitImagesInViewport:false
})
</script>
<body>
<div id="wrap">
<div class="w3-top">
  <div class="w3-bar" id="myNavbar">
    <a class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right" href="javascript:void(0);" onclick="toggleFunction()" title="Toggle Navigation Menu">
      <i class="fa fa-bars"></i>
    </a>
    <a href="/cogather/group/studygroup" class="w3-bar-item w3-button">
    	<img src="/cogather/img/logo_cut.png" class="logo"  >
    </a>
    <a href="/cogather/group/studylist" class="w3-bar-item w3-button w3-hide-small">스터디목록</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small">스터디만들기</a>
    
    <a href="#" class="w3-bar-item w3-button w3-hide-small">마이페이지</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-red login">로그인</a>
  </div>

  <!-- Navbar on small screens -->
  <div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium">
    <a href="#" class="w3-bar-item w3-button studylist" onclick="toggleFunction()">스터디목록</a>
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction()">스터디만들기</a>
    <a href="#" class="w3-bar-item w3-button" onclick="toggleFunction() login">마이페이지</a>
  </div>
</div>
<img src="/cogather/img/group/studygroupmain.jpg" width="100%" height="300px" >
		<br><br>
	<div id="row" style=" display: -ms-flexbox; /* IE10 */display: flex;-ms-flex-wrap: wrap; /* IE10 */flex-wrap: wrap;">
		<div id="text_content">
		<b id="name_id" style="color:#ffd43b;float:middle;"><br>스터디 이름: </b><b>${list[0].sg_name }</b><br>
		<b id="name_id" style="color:#ffd43b;float:middle;">스터디 주제 : </b> <b>${list[0].sg_tag }</b><br>
		<b id="name_id" style="color:#ffd43b;float:middle;">인원수: </b><b>${list[0].sg_max }</b><br> 
		<b id="name_id" style="color:#ffd43b;float:middle;">스터디 소개: </b><br>
		
		<hr>
		<div>
		${list[0].sg_info }
		</div>
		<section id="container">
		<b id="name_id" style="color:#ffd43b;float:middle;">이미지 보기: </b><b> </b><br> 
		<!-- light box2  제이쿼리 -->
		<hr>
		<c:if test="${list[0].file_name ne null}" >
		<a href="/cogather/img/group/upload/${list[0].file_name}" data-lightbox="example-set">
			<img src="/cogather/img/group/upload/${list[0].file_name}" width="20%" height="50px">(이미지 클릭시 확대)
			</a>
		
	 			<%-- ${list[0].fileName}
			 --%>
		</c:if>
		<br><br><br>
		<form name="readForm" role="form" method="post">
		
			<input type="hidden" id="SG_ID" name="SG_ID" value="">
		
		</form>
		<div style="border: 1px solid #dbdbdb;">
			
			<c:forEach var="file" items="${files}">
				<a href="#" onclick="fn_fileDown('${file.SG_ID}'); return false;">${file.SGF_ORG_FILE_NAME}</a><br>
			
			</c:forEach>
		<%-- 	<a href="#" onclick="fn_fileDown('${file[0].sg_id}'); return false;">FF${file[0].sg_id}</a>${file[0].sgf_file_size}<br>
		 --%>	
		</div>
		
		<br><!-- location.href='${list[0].kko_url} -->
		<button type="submit" onclick="openWin();" style="background-color:white;border:0px"><img src="/cogather/img/group/kakao.png"></button>
		
		</div>
		
		<div id="main" style="-ms-flex: 70%; /* IE10 */flex: 70%;padding: 50px;float:right;border: 1px solid black;text-align:center;">
		<button onclick="location.href='#'" class="viewbutton hover">참가자목록</button>
		<br><br><br><br>
			dldl
			d;sd;
			sdfsdf
			sfssdsdffff
		</div>
	</div>

	
		
	


	
		<br><br><br><br><br><br><br><br><br>
		
		<button onclick="location.href='studyupdate?sg_id=${list[0].sg_id }'" style="border :0;outline:0;color:white;width:100px;height:50px;position:relative;float:right;left:-50%;
	margin:0 10px 0 0;" class="viewbutton hover">수정하기</button>
		<button onclick="location.href='studylist'" class="listbutton hover">목록보기</button>
		<button onclick="chkDelete(${list[0].sg_id })" style="background-color:#ffd43b;border :0;outline:0;color:white;width:100px;height:50px;position:relative;float:right;left:-50%;
	margin:0 10px 0 0;" class="viewbutton hover">삭제하기</button>
		<button onclick="location.href='#'" class="enterbutton hover" style="color:white;float:right;background-color:#ffd43b;border :0;
	outline:0;width:100px;
	height:50px;">방입장</button>
	</section>
</body>
</html>
				
	</c:otherwise>
</c:choose>
