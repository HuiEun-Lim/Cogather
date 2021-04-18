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
	<meta name="keywords"
		content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

	<link rel="shortcut icon" href="img/icons/icon-48x48.png" />
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link href="../CSS/app.css" rel="stylesheet">
	
	<title>코게더 관리자 페이지</title>

</head>

<body>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="index.html">
					<span class="align-middle">코게더 관리자</span>
				</a>

				<ul class="sidebar-nav">
					<li class="sidebar-item">
						<a class="sidebar-link" href="tables-bootstrap.html">
							<i class="align-middle" data-feather="list"></i> <span class="align-middle">전체 예약 내역</span>
						</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="pages-profile.html">
							<i class="align-middle" data-feather="user"></i> <span class="align-middle">로그아웃</span>
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
												<h1 class="mt-1 mb-3">2.382</h1><br>
											</div>
										</div>
										<div class="card">
											<div class="card-body">
												<h5 class="card-title mb-4">총 예약 수</h5>
												<h1 class="mt-1 mb-3">14.212</h1><br>
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="card">
											<div class="card-body">
												<h5 class="card-title mb-4">이번달 매출</h5>
												<h1 class="mt-1 mb-3">$21.300</h1><br>
											</div>
										</div>
										<div class="card">
											<div class="card-body">
												<h5 class="card-title mb-4">이번달 예약 수</h5>
												<h1 class="mt-1 mb-3">64</h1><br>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>


						<div class="col-xl-6 col-xxl-7">
							<div class="card flex-fill w-100">
								<div class="card-header">

									<h5 class="card-title mb-0">2021년 월별 매출</h5>
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

									<h5 class="card-title mb-0">오늘 예약</h5>
								</div>
								<table class="table table-hover my-0">
									<thead>
										<tr>
											<th>예약번호</th>
											<th>시설번호</th>
											<th>예약자ID</th>
											<th class="d-none d-xl-table-cell">Start Date</th>
											<th class="d-none d-xl-table-cell">End Date</th>
											<th class="d-none d-md-table-cell">결제방법</th>
											<th class="d-none d-md-table-cell">예약취소</th>

										</tr>
									</thead>
									<tbody>
										<tr>
											<td>res_id</td>
											<td class="d-none d-md-table-cell">seat_id</td>
											<td class="d-none d-md-table-cell">ID</td>
											<td class="d-none d-xl-table-cell"><span class="badge bg-success">start_date</span></td>
											<td class="d-none d-xl-table-cell">end_date</td>
											<td class="d-none d-md-table-cell">payment</td>
											<td class="d-none d-md-table-cell"><button class="w3-red w3-text-light-grey">예약취소</button></td>
										</tr>
										<tr>
											<td>res_id</td>
											<td class="d-none d-md-table-cell">seat_id</td>
											<td class="d-none d-xl-table-cell">ID</td>
											<td class="d-none d-xl-table-cell"><span class="badge bg-warning">start_date</span></td>
											<td class="d-none d-xl-table-cell">end_date</td>
											<td class="d-none d-md-table-cell">payment</td>
											<td class="d-none d-md-table-cell"><button class="w3-red w3-text-light-grey">예약취소</button></td>
										</tr>
										<tr>
											<td>res_id</td>
											<td class="d-none d-md-table-cell">seat_id</td>
											<td class="d-none d-md-table-cell">ID</td>
											<td class="d-none d-xl-table-cell"><span class="badge bg-danger">start_date</span></td>
											<td class="d-none d-xl-table-cell">end_date</td>
											<td class="d-none d-md-table-cell">payment</td>
											<td class="d-none d-md-table-cell"><button class="w3-red w3-text-light-grey">예약취소</button></td>
										</tr>
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

	<script>
		document.addEventListener("DOMContentLoaded", function () {
			var ctx = document.getElementById("chartjs-dashboard-line").getContext("2d");
			var gradient = ctx.createLinearGradient(0, 0, 0, 225);
			gradient.addColorStop(0, "rgba(215, 227, 244, 1)");
			gradient.addColorStop(1, "rgba(215, 227, 244, 0)");
			// Line chart
			new Chart(document.getElementById("chartjs-dashboard-line"), {
				type: "line",
				data: {
					labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월",
						"12월"
					],
					datasets: [{
						label: "Sales ($)",
						fill: true,
						backgroundColor: gradient,
						borderColor: window.theme.primary,
						data: [
							2115,
							1562,
							1584,
							1892,
							1587,
							1923,
							2566,
							2448,
							2805,
							3438,
							2917,
							3327
						]
					}]
				},
				options: {
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					tooltips: {
						intersect: false
					},
					hover: {
						intersect: true
					},
					plugins: {
						filler: {
							propagate: false
						}
					},
					scales: {
						xAxes: [{
							reverse: true,
							gridLines: {
								color: "rgba(0,0,0,0.0)"
							}
						}],
						yAxes: [{
							ticks: {
								stepSize: 10
							},
							display: true,
							borderDash: [3, 3],
							gridLines: {
								color: "rgba(0,0,0,0.0)"
							}
						}]
					}
				}
			});
		});
	</script>

</body>

</html>