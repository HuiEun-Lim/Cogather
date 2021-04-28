<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon" />
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link href="../CSS/app.css" rel="stylesheet">
	<script type="text/javascript" src="../JS/adminpage.js"></script>	
	
	<title>코게더 관리자 페이지</title>
</head>

<body>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="adminpage">
					<span class="align-middle">코게더 관리자</span>
				</a>
				<ul class="sidebar-nav">
					<li class="sidebar-item">
						<a class="sidebar-link" href="adminrsv">
							<i class="align-middle" data-feather="list"></i> <span class="align-middle">전체 예약 내역</span>
						</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="main">
							<i class="align-middle" data-feather="book"></i> <span class="align-middle">스터디카페 바로가기</span>
						</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${pageContext.request.contextPath}/group/studygroup">
							<i class="align-middle" data-feather="users"></i> <span class="align-middle">스터디그룹 바로가기</span>
						</a>
					</li>
				</ul>
			</div>
		</nav>

		<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<a class="sidebar-toggle d-flex">
					<i class="hamburger align-self-center"></i>
				</a>
			</nav>

			<main class="content">
				<div class="container-fluid p-0">
					<div class="row">
						<div class="col-xl-6 col-xxl-5 d-flex">
							<div class="w-100">
								<div class="row">
									<div class="col-sm-6">
										<div class="card">
											<div class="card-body">
												<h5 class="card-title mb-4">총매출</h5>
												<h1 class="mt-1 mb-3" style="font-size: 35px" id="totalsales"></h1><br>
											</div>
										</div>
										<div class="card">
											<div class="card-body">
												<h5 class="card-title mb-4">총 예약 수</h5>
												<h1 class="mt-1 mb-3" style="font-size: 35px" id="totalcnt"></h1><br>
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="card">
											<div class="card-body">
												<h5 class="card-title mb-4">이번달 매출</h5>
												<h1 class="mt-1 mb-3" style="font-size: 35px" id="thismonthsales"></h1><br>
											</div>
										</div>
										<div class="card">
											<div class="card-body">
												<h5 class="card-title mb-4">이번달 예약 수</h5>
												<h1 class="mt-1 mb-3" style="font-size: 35px" id="thismonthcnt"></h1><br>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-6 col-xxl-7">
							<div class="card flex-fill w-100">
								<div class="card-header">
									<h5 class="card-title mb-0">2021년 연간 매출</h5>
								</div>
								<div class="card-body py-3">
									<div class="chart chart-sm">
										<canvas id="chartjs-dashboard-line"></canvas>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-12 col-lg-8 col-xxl-12 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">오늘 예약 내역</h5>
								</div>
								<table class="table table-hover my-0" id="todayrsvtable">
									<thead>
										<tr>
											<th>예약번호</th>
											<th>시설번호</th>
											<th>예약자ID</th>
											<th class="d-none d-xl-table-cell">Start Date</th>
											<th class="d-none d-xl-table-cell">End Date</th>
											<th class="d-none d-md-table-cell">결제방법</th>
										</tr>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
	<script src="../JS/app.js"></script>

</body>

</html>