<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글작성</title>
	<link rel="stylesheet" href="/cogather/CSS/common.css">
</head>



<body>
<div id="write_id">
<h4>글작성</h4><br><br>
<script src="/cogather/JS/ckeditor/ckeditor.js">
</script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>


<form name="frm" action="studywriteOk" method="post" enctype="multipart/form-data" onsubmit="return chkSubmit()">
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
 <input type="file" name="file">  
 <div class="form-group" style="border: 1px solid #dbdbdb;">
		
</div>
<br><br><br><br><br><br><br>
<input type="submit" value="생성" class="createbutton hover"/>
</form>

<br>

</div>
<button type="button" onclick="location.href = 'studylist'" class="listbutton hover">목록으로</button>
</body>

</html>
