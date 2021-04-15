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
<script>
function chkSubmit(){
	frm = document.forms['frm'];
	
	var sg_name = frm['sg_name'].value.trim();
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
<script src="/cogather/JS/ckeditor/ckeditor.js">
</script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<form name="frm" action="studyupdateOk" method="post" enctype="multipart/form-data" onsubmit="return chkSubmit()">
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
썸네일 업로드:&nbsp
<input type="file" name="uploadFile" id="uploadFile" value="${list[0].file_name}" required/>

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
  
  function chkDeleteFile(sgf_id){
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
	function loadingPage(data){
		$("#filelist").text("");
	}
 </script>
카톡방 주소:&nbsp&nbsp
<input type="text" name="kko_url" style="width:20%;height:30px;" value="${list[0].kko_url}"/><br><br>


<c:forEach var="file" items="${files}">
</c:forEach> 
<div class="file_input">
<label>

첨부파일: &nbsp&nbsp<img src="/cogather/img/group/yellowfile.png" class="search" ><input type="file" style="display:none" name="file" onchange="javascript:document.getElementById('file_route').value=this.value" required>
<input type="text" name="filetext" readonly="readonly" id="file_route">
</label>
</div>
<div style="border: 1px solid #dbdbdb;">
			
			<c:forEach var="file" items="${files}">
				<a href="#" style="color:#ffd43b" onclick="fn_fileDown('${file.SG_ID}'); return false;">
				<div id="filelist">
				(${file.SGF_ID})${file.SGF_ORG_FILE_NAME}</a>
				<button style="background-color:white;border:0px" onclick="chkDeleteFile(${file.SGF_ID }); return false;"><img src="/cogather/img/group/yellowx.png" class="search" ></button>
			</div>
			</c:forEach>
			
		<%-- 	<a href="#" onclick="fn_fileDown('${file[0].sg_id}'); return false;">FF${file[0].sg_id}</a>${file[0].sgf_file_size}<br>
		 --%>	
		</div>
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
