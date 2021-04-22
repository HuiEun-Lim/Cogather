<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/cogather/CSS/login.css">
<title>회원가입</title>
</head>
<script>
function chkSubmit(){
	frm = document.forms['frm'];
	
	var name = frm['name'].value.trim();
	var id = frm['id'].value.trim();
	var pw = frm['pw'].value.trim();
	var pw2 = frm['pw2'].value.trim();

	
	if(id == ""){
		alert("아이디는 반드시 작성해야 합니다");
        frm['id'].focus();
        return false;
	}
	
	if(pw == ""){
		alert("패스워드는 반드시 작성해야 합니다");
        return false;
	}
	
	if(pw2 == ""){
		alert("패스워드 확인은 반드시 작성해야 합니다");
        return false;
	}
	
	if(pw != pw2){
		alert("패스워드 확인이 다릅니다");
        return false;
	}
	
	if(name == ""){
		alert("이름은 반드시 입력해야 합니다.");
		frm['name'].focus();
		return false;
	}
	
	
	return true;
}
</script>

<body>
<div id="wrap">
<div class="w3-paddig-64" style="margin-top:90px" >
<h2 class="w3-center"> 회원가입 </h2>
	<div  style="height:2px; background-color:#FDBF26"></div>
</div>

<div id="wrap2">
<form name="frm" action="signupOk" method="post" onsubmit="return chkSubmit()" enctype="multipart/form-data">
<br>
<h5 class="required">아이디</h5>
<input type="text" name="id"/><br><br>
<h5 class="required">이름</h5>
<input type="text" name="name"/><br><br>
<h5 class="required">패스워드</h5>
<input type="password" name="pw"/><br><br>
<h5 class="required">패스워드 확인</h5>
<input type="password" name="pw2"/><br><br>
<h5>전화번호</h5>
<input type="text" name="phone"/><br><br>
<h5>e-mail</h5>
<input type="text" name="email"/><br><br>
<h5>관심태그</h5>
<input type="text" name="tag"/><br><br>
<div class="inputArea">
<h5>프로필 이미지</h5>
<input type="file" id="pimg" name="file" />
<div class="select_img"><img src="" /></div>
 
 <script>
  $("#pimg").change(function(){
   if(this.files && this.files[0]) {
    var reader = new FileReader;
    reader.onload = function(data) {
     $(".select_img img").attr("src", data.target.result).width(500);        
    }
    reader.readAsDataURL(this.files[0]);
   }
  });
 </script>
</div>
<br>
<input type="submit" class="btn" value="가입하기" />
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
</form>
<br><br>

<br><br><br><br><br><br><br><br>


</div>
</div>

</body>
</html>