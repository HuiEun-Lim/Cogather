<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/cogather/CSS/login.css">
<title>회원정보수정</title>
</head>
<script>
function chkSubmit(){
	frm = document.forms['frm'];
	
	var name = frm['name'].value.trim();
	var pw = frm['pw'].value.trim();
	var pw2 = frm['pw2'].value.trim();
	
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
<h2 class="w3-center"> 회원 정보 수정 </h2>
	<div  style="height:2px; background-color:#FDBF26"></div>
</div>

<div id="wrap2">
<form name="frm" action="updateOk" method="post" onsubmit="return chkSubmit()">
<br>
<input type="hidden" name="id" value=${dto.id } readonly/>
<h5>이름</h5>
<input type="text" name="name" value=${dto.name } /><br><br>
<h5 class="required">변경할 패스워드</h5>
<input type="password" name="pw"/><br><br>
<h5 class="required">변경할 패스워드 확인</h5>
<input type="password" name="pw2"/><br><br>
<h5>전화번호</h5>
<input type="text" name="phone" value=${dto.phone } /><br><br>
<h5>e-mail</h5>
<input type="text" name="email" value=${dto.email } /><br><br>
<h5>관심태그</h5>
<input type="text" name="tag" value=${dto.tag } /><br><br>
<br>
<input type="submit" class="btn" value="수정하기" />
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
</form>
<br><br>

<br><br><br><br><br><br><br><br>


</div>
</div>

</body>
</html>