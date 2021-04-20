<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>   
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글작성</title>
	<link rel="stylesheet" href="/cogather/CSS/common.css">
</head>
<script>
function chkSubmit(){
	frm = document.forms['frm'];
	
	var sg_name = frm['sg_name'].value.trim();
	var sg_max = frm['sg_max'].value.trim();
	var sg_info = frm['sg_info'].value.trim();
	var sg_tag = frm['sg_tag'].value.trim();
	var kko_url = frm['kko_url'].value.trim();
	var length;
	var str;
	
	var numreg =  /^[0-9]*$/;
	if(sg_name == ""){
		alert("스터디 이름은 반드시 입력해야 합니다");
		frm['sg_name'].focus();
		return false;	
	}
	if(sg_name.length >=12){
		alert("스터디 이름에 글자수가 너무 많아요..");
		return false;
	}
	if(sg_tag.length >=30){
		alert("스터디 주제에 글자수가 너무 많아요..");
		return false;
	}
	if(sg_max >10){
		alert("인원수 초과 10명 이하로 해주세요 ");
		return false;
	}
	if(sg_max== ""){
		alert("제한 인원수는 반드시 입력해야 합니다");
		frm['sg_max'].focus();
		return false;
	}
	if(sg_tag == ""){
		alert("주제는 반드시 입력해야 합니다");
		frm['sg_tag'].focus();
		return false;
	}
	
	if(kko_url == ""){
		alert("카카오 오픈 채팅방을 만들어주세요그리고 링크를 복사해 주세요 ");
		frm['kko_url'].focus();
		return false;
	}
	if(!numreg.test(sg_max)){
		alert("제한 인원수는 숫자여야 합니다");
		return false;
	}
	
	return true;
	
}
</script>
<body>
<%@ include file="groupcover.jsp" %>
<div id="write_id">
<h4>글작성</h4><br><br>
<script src="/cogather/JS/ckeditor/ckeditor.js">
</script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<form name="frm" action="studywriteOk" method="post" enctype="multipart/form-data" onsubmit="return chkSubmit()">
아이디:&nbsp&nbsp
<input type="text" name="id" style="width:20%;height:30px;" value="${user_id }"><br><br>
스터디 이름:&nbsp&nbsp
<input type="text" name="sg_name" style="width:20%;height:30px;" /><br><br>
제한 인원수:&nbsp&nbsp
<input type="text" name="sg_max" style="width:20%;height:30px;"/><br><br>
주제:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<input type="text" name="sg_tag" style="width:20%;height:30px;"/><br><br>
&nbsp&nbsp
그룹 정보:<textarea name="sg_info" id="editor1" style="width:640;height:600;margin:0 0 0 0px;"></textarea><br><br>
<script>
	CKEDITOR.replace('editor1',
			{
		width:'100%',
		height:'300px',
		allowedContent:true,
		//filebrowserUploadUrl:'${pageContext.request.contextPath}/studywriteOk'
		toolbar:[['Bold','-','italic','Underline','Font','FontSize'],['NumberedList'],['SpellChecker','Copy','Paste','PasteText','TextColor','BGColor','Link']]
		

	});

</script>
카톡방 주소:&nbsp&nbsp
<input type="text" name="kko_url" style="width:20%;height:30px;"/><br><br>
썸네일 업로드:&nbsp
<input type="file" name="uploadFile" id="uploadFile"/>

<div class="select_img"><img src=""></div>
 <script>
  $("#uploadFile").change(function(){
   if(this.files && this.files[0]) {
    var reader = new FileReader;
    reader.onload = function(data) {
     $(".select_img img").attr("src", data.target.result).width(500);        
    }
    reader.readAsDataURL(this.files[0]);
   }
  });
 </script>
첨부파일:  <input type="file" name="file">  
 <div class="form-group" style="border: 1px solid #dbdbdb;">
		
</div>
<br><br><br><br><br><br><br>

<input type="submit" value="생성" class="createbutton hover"/>

<input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/> 
</form>

<br>

</div>
<button type="button" onclick="location.href = 'studylist'" class="listbutton hover">목록으로</button>
</body>

</html>
