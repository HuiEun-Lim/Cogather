<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
   
<html lang="ko">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
   <link rel="stylesheet" href="../CSS/cafemap.css">
   <link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
   <script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
   <script type="text/javascript" src="../JS/cafemap.js"></script>
   <title>오시는길</title>
</head>
<body>
	<%@ include file="../cafe/navbar.jsp"%>

    
<div id="wrap">
       <div class="w3-padding-64" style="margin-top:90px">
          <h3>오시는길</h3>
         <div class="w3-light-grey" style="height:2px; margin-bottom: 70px" >
             <div style="width:10%; height:2px; background-color:#FDBF26"></div>
         </div>
             <!-- 이미지 지도를 표시할 div 입니다 -->
            <div id="staticMap" style="width:800px;height:400px;"></div>
            <button class="w3-btn w3-amber w3-round w3-right"onClick="window.open('https://map.kakao.com/link/to/코게더스터디카페,37.500163197126824, 127.03533536432606')"><span style="font-size: 15px; color: white">카카오 길찾기</span></button>
            
           </div>
           
           <div>              
             <div id="tname">
                역삼역 스터디룸 <span style="color:#FDBF26"><b>코게더</b></span>
             </div>
            <div class="w3-light-grey" style="height:2px; margin-bottom: 30px" ></div>
            <table class="tinfo">
            <tr>
            <td class="tabledata"><img src="../img/cafe/placeholder.png" class="timg">위치</td>
            <td class="tabledata">역삼역 3번출구</td>
            </tr>
            <tr>
            <td></td>
            <td>주차불가</td>
            </tr>
            </table>
            <div class="w3-light-grey" style="height:2px; margin-bottom: 30px" ></div>
            <table class="tinfo">
            <tr>
            <td class="tabledata"><img src="../img/cafe/phone-call.png" class="timg">전화번호</td>
            <td class="tabledata">010-1234-5678</td>
            </tr>
            </table>
            <div class="w3-light-grey" style="height:2px; margin-bottom: 30px" ></div>
            <table class="tinfo">
            <tr>
            <td class="tabledata"><img src="../img/cafe/bus.png" class="timg">대중교통</td>
            <td class="tabledata"><img src="../img/cafe/bus-stop.png" class="timg">3600 146 </td>
            </tr>
            <tr>
            <td></td>
            <td class="tabledata"><img src="../img/cafe/train.png" class="timg">2호선</td>
            </tr>
            </table>
            <div class="w3-light-grey" style="height:2px; margin-bottom: 30px" ></div>
         </div>
    </div>
    
<%@ include file="../cafe/footer.jsp"%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7f36e46956483ffffb803d95f128023d"></script>
<script>
    
   myMap();

</script>
</body>
</html>