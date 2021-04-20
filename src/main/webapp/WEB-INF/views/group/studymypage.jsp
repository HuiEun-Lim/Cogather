<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="ko">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
<!-- Style CSS -->
<link rel="stylesheet" href="../templates/groupMypageAsset/style.css">
<link rel="stylesheet" href="../CSS/common.css">
<head>
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}" />
<meta charset="UTF-8">
<title>스터디 마이페이지</title>
</head>
<body>
<%@ include file="groupcover.jsp" %>

<header class="header-area">
        <!-- Logo Area -->
        <div class="logo-area text-center">
            <div class="container h-100">
                <div class="row h-100 align-items-center">
                    <div class="col-12">
                        <h1 class='sub-title'>마이페이지</h1>
                    </div>
                </div>
            </div>
        </div>

        <!-- Nav Area -->
        <div class="original-nav-area" id="stickyNav">
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Classy Menu -->
					<div id="search-wrapper">
                        <form action="#">
                            <input type="text" id="search" placeholder="스터디 검색..">
                            <div id="close-icon"></div>
                            <input class="d-none" type="submit" value="">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- ##### Header Area End ##### -->
    <!-- Logo Area -->
        <div class="logo-area text-center">
            <div class="container h-100">
                <div class="row h-100 align-items-center">
                    <div class="col-12">
                        <h1 class='sub-title'>참여 스터디 목록</h1>
                    </div>
                </div>
            </div>
        </div>
    <!-- ##### Hero Area Start ##### -->
    <div class="hero-area">
        <!-- Hero Slides Area -->
        
    </div>
    <!-- ##### Hero Area End ##### -->
    
    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area text-center">
        <div class="container">
            <div class="row">
                <div class="col-12">
                   
               
                    <!-- Footer Social Area -->
                    <div class="footer-social-area mt-30">
                        <a href="#" data-toggle="tooltip" data-placement="top" title="Pinterest"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                        <a href="#" data-toggle="tooltip" data-placement="top" title="Facebook"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                        <a href="#" data-toggle="tooltip" data-placement="top" title="Twitter"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                        <a href="#" data-toggle="tooltip" data-placement="top" title="Dribbble"><i class="fa fa-dribbble" aria-hidden="true"></i></a>
                        <a href="#" data-toggle="tooltip" data-placement="top" title="Behance"><i class="fa fa-behance" aria-hidden="true"></i></a>
                        <a href="#" data-toggle="tooltip" data-placement="top" title="Linkedin"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
                    </div>
                </div>
            </div>
        </div>

   <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with JJeongHee by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->

    </footer>
    <!-- ##### Footer Area End ##### -->

    <!-- jQuery (Necessary for All JavaScript Plugins) -->
    <script src="../templates/groupMypageAsset/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="../templates/groupMypageAsset/js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="../templates/groupMypageAsset/js/bootstrap.min.js"></script>
    <!-- Plugins js -->
    <script src="../templates/groupMypageAsset/js/plugins.js"></script>
    <!-- Active js -->
    <script src="../templates/groupMypageAsset/js/active.js"></script>
    <script src="../JS/studymypage.js"></script>
    <script>
    	function setArgs(){
    		id = "${id}";
    		token = $("meta[name='_csrf']").attr("th:content");
			header = $("meta[name='_csrf_header']").attr("th:content");
    	}
    </script>
    
</body>
</html>