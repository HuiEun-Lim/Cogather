<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:choose>
	<c:when test="${empty list || fn:length(list) == 0 }">
		<script>
			/* alert("해당 정보가 삭제되거나 없습니다");
			history.back(); */
		</script>
	</c:when>
	
	<c:otherwise>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<title>읽기</title>
</head>
<script>
	function openWin(){
		window.open('${list[0].kko_url}', "kakaoTalk", "width=1000, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 

	}
	function openMail(){
		location.href = 'mailSending';
	}

</script>
<link rel="stylesheet" href="/cogather/CSS/common.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<!-- lightbox2 제이퉈리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.1/css/lightbox.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/CSS/studyview.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.1/js/lightbox.min.js"></script>

<script>
var staticid;
function chkDelete(sg_id){
	// 삭제 여부, 다시 확인 하고 진행하기
	var r = confirm("삭제하시겠습니까?");
	
	if(r){
		location.href = 'studydeleteOk?sg_id=' + sg_id;
	}
} // chkDelete
function loadingPage(data){
	$("#filelist").text("");
}
function chkDeleteFile(sgf_id){
	// 삭제 여부, 다시 확인 하고 진행하기
	/* var r = confirm("삭제하시겠습니까?");
	
	if(r){
		location.href = 'studydeleteFileOk?sg_id=' + sg_id;
	} */
	
	$.ajax({
		url: "studydeleteFileOk?sgf_id=" + sgf_id,
		type: "GET",
		cache: false,
		success: function(data, status) {
			if (status == "success") {
				alert("삭제 성공");
				loadingPage(data);
			}
		}
	});
} // chkDelete

function fn_fileDown(sgf_id){
	var formObj = $("form[name='readForm']");
	$("#SGF_ID").attr("value", sgf_id);
	formObj.attr("action", "../group/fileDown");
	formObj.submit();  
//	location.href = '/cogather/group/fileDown';
	
}

lightbox.option({
    resizeDuration: 200,
    wrapAround: true,
    disableScrolling: false,
    fitImagesInViewport:false
})


function registerRoom(nowid){
	
	$.ajax({
		url: "./MemberStudyRest/ms/${list[0].sg_id}/"+nowid,
		type: "GET",
		cache: false,
		success: function(data, status) {
			if (status == "success") {
				alert("가입 신청하였습니다");
			}
		}
	});
}

function UpdateCrew(countstu){
	
	console.log("count"+countstu);

	console.log("인원수"+${list[0].sg_max });
	var countmax=${list[0].sg_max };
	console.log("sdfsdfsdfwerwe"+staticid);
	if(countmax >countstu){
	var token = $('meta[name="_csrf"]').attr("content");
	var header = $('meta[name="_csrf_header"]').attr("content");
	$.ajax({
		url: "./MemberStudyRest/ms/${list[0].sg_id}/"+staticid,
		type: "PUT",
		beforeSend: function(xhr) {
	        xhr.setRequestHeader("AJAX", true);

	        xhr.setRequestHeader(header, token);
	     },
		cache: false,
		success: function(data, status) {
			if (status == "success") {
				alert("스터디원  수락");
			}
		}
	});
	}else if(countmax <=countstu){
		alert("스터디원  초과");
		return -1;
	}
	
}

function loadMember(nowid){
	console.log("지나감");
	console.log(nowid);
	var token = $('meta[name="_csrf"]').attr("content");
	var header = $('meta[name="_csrf_header"]').attr("content");
	$.ajax({
		url: "./MemberStudyRest/${list[0].sg_id}",
		type: "GET",
		beforeSend: function(xhr) {
	        xhr.setRequestHeader("AJAX", true);

	        xhr.setRequestHeader(header, token);
	     },
		cache: false,
		success: function(data, status) {
			if (status == "success") {
				if(data.status == "OK"){
					updateMemberList(data,nowid);	
				}
				
			}
		}
	});
}



function updateMemberList(data,id){
	var result = "";

	console.log("updatemember"+id);
	
	result += "<h4>현재 가입자</h4>";

	
	for(var i =0; i < data.rdata.length; i++){
		console.log("qqqqqqq");
		result += "<li>" +"<img class='member-thumbnail'src='${pageContext.request.contextPath }/"+ data.rmember[i].pimg_url+"'>"+"<span class='member-name'>"+data.rdata[i].id+"</span></li>";
	}
	result+="<hr>";
	result += "<h4>가입 신청중</h4>"
	
	for(var i = 0; i < data.cdata.length; i++){
		console.log("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"+id);
		id=data.cmember[i].id;
		
		 result += "<li>" +"<img class='member-thumbnail' src='${pageContext.request.contextPath }/"+ data.cmember[i].pimg_url+"'>"+"<span class='member-name'>"+data.cdata[i].id+"</span></li>";
 		 accept(id);
		 
	}
	
	$(".member-list ul").html(result);
}
 
function accept(id){
	/* console.log($(this).attr('btn-id'));
	console.log($(this).attr('type'));  */
	
	var token = $('meta[name="_csrf"]').attr("content");
	var header = $('meta[name="_csrf_header"]').attr("content");
	console.log("보안1"+token);
	console.log("보안2"+header);
	console.log("accept()"+id);
	
	console.log('지나감222');
	staticid = id;
	console.log('전역'+staticid);
	/* UpdateCrew(); */
	/*  $.ajax({
		beforeSend: function(xhr) {
	        xhr.setRequestHeader("AJAX", true);
	        //for csrf
	        xhr.setRequestHeader(header, token);
	     },
		url: "./MemberStudyRest/ms/${list[0].sg_id}/"+id,
		type: "GET",
		cache: false,
		success: function(data, status) {
			if (status == "success") {
				if(data.status=="OK"){
					alert("가입승인 완료");
				}
			} 
		}
	}); */
}

 
function getCookie(name) {
	  var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	  return value? value[2] : null;
}

$(function(){
	$("[name='id']").val(getCookie('user_id'));
})



</script>
<body>
<%@ include file="kigroupcover.jsp" %>
		<br><br>
	<div id="row" style=" display: -ms-flexbox; /* IE10 */display: flex;-ms-flex-wrap: wrap; /* IE10 */flex-wrap: wrap;">
		<div id="text_content">
		<img src="/cogather/img/group/crown.png" class="search"><b style="color:#ffd43b;float:left;">방장: ${list[0].id}</b><br> 
		<b id="name_id" style="color:#ffd43b;float:middle;"><br>스터디 이름: </b><b>${list[0].sg_name }</b>
		<b id="name_id" style="color:#ffd43b;float:middle;">스터디 주제 : </b> <b>${list[0].sg_tag }</b>
		<b id="name_id" style="color:#ffd43b;float:middle;">인원수: </b><b>${list[0].sg_max }</b><br> 
		<hr>
		<b id="name_id" style="color:#ffd43b;float:middle;">스터디 소개: </b><br>
		
		
		
		
		
		<div>
		${list[0].sg_info }
		<%-- ${countpage.ctotal } --%>
		</div>
		<section id="container">
		<hr>
		<b id="name_id" style="color:#ffd43b;float:middle;">이미지 보기: </b><b> </b><br> 
		<!-- light box2  제이쿼리 -->
		
		<c:if test="${list[0].file_name ne null}" >
		<a href="../img/group/${list[0].file_name}" data-lightbox="example-set">
			<img src="../img/group/${list[0].file_name}" width="20%" height="50px" title='(이미지 클릭시 확대)'>
			</a>
		
	 			<%-- ${list[0].fileName}
			 --%>
		</c:if>
		<br><br><br>
		<form name="readForm" role="form" method="post">
		
			<input type="hidden" id="SG_ID" name="SG_ID" value="">
			<input type="hidden" id="SGF_ID" name="SGF_ID" value="">
			<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/> 
		</form>
		<div style="border: 1px solid #ffd43b;">
			
			<c:forEach var="file" items="${files}">
				<a href="#" onclick="fn_fileDown('${file.SGF_ID}'); return false;">
				<div id ="filelist">
				(${file.SGF_ID})${file.SGF_ORG_FILE_NAME}</a>
				
				<button style="background-color:white;border:0px" onclick="chkDeleteFile(${file.SGF_ID })"><img src="/cogather/img/group/yellowx.png" class="search" ></button>
				</div>
			</c:forEach>
			
		<%-- 	<a href="#" onclick="fn_fileDown('${file[0].sg_id}'); return false;">FF${file[0].sg_id}</a>${file[0].sgf_file_size}<br>
		 --%>	
		</div>
		
		<br><!-- location.href='${list[0].kko_url} -->
		<button type="submit" onclick="openWin();" style="background-color:white;border:0px"><img src="/cogather/img/group/kakao.png"></button>
		<button type="submit"  onclick="openMail()" style="background-color:white;border:0px"><img src="/cogather/img/group/mail.png"></button>
		<c:if test="${user_id eq list[0].id}">
		<button onclick="UpdateCrew('${countpage.ctotal }')" style="color:white;float:center;background-color:#ffd43b;width:100px;
	height:60px;border:0px">Study with Me</button> 
		</c:if>
		</div>
	
			
		<div id="main" class="member-list-container">
	 <button onclick="loadMember('${user_id}')" class="viewbutton hover" style="color:white;float:center;background-color:#ffd43b;border :0;
	outline:0;width:180px;
	height:30px;"><i class="fa fa-refresh fa-spin"></i> 참가자 목록</button> 
		
		<div class="member-list">
		
			<ul>
			
			</ul>
		</div>
		<br><br><br><br>
			
		</div>
	</div>

	
		
	


	
		<br><br><br><br><br><br><br><br><br>
		<c:if test="${user_id eq list[0].id}">
		
		<button onclick="location.href='studyupdate?sg_id=${list[0].sg_id }'" style="border :0;outline:0;color:white;width:100px;height:50px;position:relative;float:right;left:-50%;
	margin:0 10px 0 0;" class="viewbutton hover">수정하기</button>
		</c:if>
		
		<button onclick="location.href='studylist'" class="listbutton hover">목록보기</button>
		<c:if test="${user_id eq list[0].id}">
		
		<button onclick="chkDelete(${list[0].sg_id })" style="background-color:#ffd43b;border :0;outline:0;color:white;width:100px;height:50px;position:relative;float:right;left:-50%;
	margin:0 10px 0 0;" class="viewbutton hover">삭제하기</button>
	
		</c:if>
		<c:if test="${user_id ne list[0].id}">
		<c:if test="${user_id ne null}">
		<button onclick="registerRoom('${user_id}')" class="viewbutton hover" style="color:white;float:right;background-color:#ffd43b;border :0;
	outline:0;width:100px;
	height:50px;">방입장 신청</button> 
	</c:if>
		</c:if>
	
	
	
		<form action="roomenterOk" name="enterRoom" method="post">
			<input type="hidden" name="sg_id" value="${sg_id }">
			<input type="hidden" name="id" value="getCookie('user_id')">
			<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/> 
			<c:if test="${user_id ne null}">
			<button type="submit" id="enterRoom" class="enterbutton hover" style="color:white;float:right;background-color:#ffd43b;border :0;
			outline:0;width:100px;height:50px;">방입장</button>
			</c:if>
		</form>
	</section>

</body>
</html>
				
	</c:otherwise>
</c:choose>
