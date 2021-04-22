<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      

<c:choose>
	<c:when test="${result == 0 }">
		<script>
			alert("예약 실패!!!!!!");
			history.back();
		</script>
	</c:when>
	<c:otherwise>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>예약확인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="../JS/cafersv.js"></script>
<link rel="stylesheet" href="../CSS/receipt.css">
</head>
<body>
<%
String s_date = request.getParameter("startdate");
s_date = s_date.replace("T", "\n"); 
String e_date = request.getParameter("enddate");
e_date = e_date.replace("T", "\n"); 
%>
<table class="body-wrap">
    <tbody><tr>
        <td></td>
        <td class="container" width="600">
            <div class="content">
                <table class="main" width="100%" cellpadding="0" cellspacing="0">
                    <tbody><tr>
                        <td class="content-wrap aligncenter">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tbody><tr>
                                    <td class="content-block">
                                        <h2>${param.ID}님의 예약</h2>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="content-block">
                                        <table class="invoice">
                                            <tbody>
                                            <tr>
                                                <td>
                                                    <table class="invoice-items" cellpadding="0" cellspacing="0">
                                                        <tbody><tr>
                                                            <td>예약한 시설 번호</td>
                                                            <td class="alignright">
                                                            ${param.seat_id} </td>
                                                        </tr>
                                                        <tr>
                                                            <td>시작 시간</td>
                                                            <td class="alignright" style="width:300px"><%out.print(s_date);%></td>
                                                        </tr>
                                                        <tr>
                                                            <td>종료 시간</td>
                                                            <td class="alignright"><%out.print(e_date);%></td>
                                                        </tr>
                                                    </tbody></table>
                                                </td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="content-block">
                                    아래 버튼을 눌러 카카오페이 결제를 진행해주세요
									<div class="w3-button" id="apibtn" style="margin-top: 20px">
									<img src="../img/cafe/kakaopaybtn.png">
									</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="content-block">
                                        Company Inc. Cogather Studycafe & Studygroup
                                    </td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                </tbody></table>
                <div class="footer">
                    <table width="100%">
                        <tbody><tr>
                            <td class="aligncenter content-block">Questions? Email <a href="mailto:">support@cogather.inc</a></td>
                        </tr>
                    </tbody></table>
                </div></div>
        </td>
        <td></td>
    </tr>
</tbody></table>
</body>
</html>
	</c:otherwise>
</c:choose>