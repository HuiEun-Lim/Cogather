<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<html>

<head>
	<title>Home</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="shortcut icon" href="./img/favicon.png" type="image/x-icon" />
	<script src="https://kit.fontawesome.com/65311e5b1a.js" crossorigin="anonymous"></script>
	<style>
	            #bg{
	                position: fixed;
	                right: 0;
	                bottom: 0;
	                min-width: 100%;
	                min-height: 100%;
	            }
	            .slogan{
	                background-color: rgb(0,0,0,0.5);
	                color: white;
	                padding-left: 60px;
	                padding-right: 60px;
	                text-align: center;
	                /*가운데에 위치하도록 조정*/
	                position: absolute;
	                top: 50%;
	                left: 50%;
	                transform: translate(-50%, -50%);/*자기자신을 조정*/
	            }
	            h1{
	                font-style: italic;
	                font-family: "Book Antiqua", cursive;
	                margin-bottom: 0;
	            }
	            h3{
	                border-top: 1px solid white;
	                border-bottom: 1px solid white;
	                padding: 10px 0 10px 0;
	                margin-top:0;
	            }
	            p{
	                color: crimson;
	                font-size: 130%;
	            }
	            .slogan>button{
	                border: 2px solid white;
	                padding : 10px 25px;
	                font-weight: bold;
	                cursor:pointer;
	                color: white;
	                background-color: rgba(0,0,0,0);
	            }
	            .slogan>button:hover{
	                background-color:white;
	                color:black;
	            }
	            
	        </style>
	</head>
	<body>
	<video autoplay loop muted id="bg">
	            <source src="./img/home_video.mp4" type="video/mp4">
	        </video>
	        <div class="slogan">
	            <h1>Study with</h1>
	            <h3><img src="./img/logo_cut.png" style="width: 100px"></h3>
				<button onclick="location.href='${pageContext.request.contextPath }/studycafe/main'"> 스터디 카페</button>
				<button onclick="location.href='${pageContext.request.contextPath }/group/studygroup'"> 스터디 그룹</button><br><br>
	        </div>
</body>
</html>
