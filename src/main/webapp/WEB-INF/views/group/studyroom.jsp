<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<title>스터디 방</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/CSS/studyroom.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="../templates/roomAssets/css/tooplate.css">
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
	th:content="${_csrf.headerName}" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- insert nav -->
				<nav id="room-menu">
					<h2 id="room-title">${studyGroupBYSGID[0].sg_name }</h2>
					<button id="outroom" class="btn btn-danger">퇴실하기</button>

					<div class="clear-both"></div>
				</nav>
				<div id="enter-cnt-head">참여인원</div>
				<span id="enter-cnt"></span>
			</div>

		</div>
		<!-- row -->
		<div class="row tm-content-row tm-mt-big">
			<div class="tm-col tm-col-small">
				<div class="bg-white tm-block">
					<div class="row">
						<div class="user-list"></div>
					</div>
					<!-- insert content-->
				</div>
			</div>
			<div class="tm-col tm-col-big">
				<div class="bg-white tm-block">
					<div class="row">
						<div class="col-12">
							<div class="board-container">
								<h2 class="board-title">${studyGroupBYSGID[0].sg_name }</h2>
								<h2 class="board-subtitle">게시판</h2>
								<div id="board-list" class="board-list">

									<div class="board-option">
										<div class="ele-left" id="pageinfo"></div>
										<div class="ele-right" id="pageRows"></div>
									</div>
									<table class="table">
										<caption>
											<span class="blind">게시물 목록</span>
										</caption>
										<colgroup>
											<col>
											<col style="width: 90px">
										</colgroup>
										<thead>
											<tr id="simpleTableTitle">
												<th scope="col">제목</th>
												<th scope="col">조회</th>
											</tr>
										</thead>
										<tbody>

										</tbody>
									</table>

									<div class="board-list">
										<div class="ele-right">
											<button type="button" class="btn btn-warning" id="btnWrite">글작성</button>
										</div>
									</div>
									<div class="clear-both"></div>
									<%-- 페이징 --%>
									<div class="paging-center">
										<ul class="pagination" id="pagination"></ul>
									</div>

								</div>
								<!-- board-list end  -->
								<div class="clear-both"></div>

								<div id="write-mode">
									<form id="frmWrite" method="post" enctype="Multipart/form-data">
										<div class="container">
											<input id="content-uid" type="hidden" name="ct_uid" value="0">
											<div class="form-group">
												<label class="col-sm-2" for="title">제목</label> <input
													class="form-control" type="text" id="ct_title"
													autocomplete="off" placeholder="제목을 입력해주세요" name="ct_title">
											</div>
											<input type="hidden" id="roomNumber" name="sg_id"
												value="${sg_id }"> <input type="hidden" id="userid"
												name="id" value="${id }"> <label
												class="control-label col-sm-2" for="ct_content">내용</label>
											<textarea name="ct_content" id="editor1"
												style="width: 640; height: 600; margin: 0 0 0 0px;"></textarea>
											<br> <br> <input type="hidden"
												name="${_csrf.parameterName}" value="${_csrf.token}" />
											<div class="btn_group_write">
												<button disabled="disabled" id="write-list" type="button"
													class="btn btn-secondary ele-left">목록</button>
												<button disabled="disabled" id="write-send" type="button"
													class="btn btn-success ele-right">작성</button>
											</div>
											<div class="btn_group_update">
												<button disabled="disabled" id="update-cancel" type="button"
													class="btn btn-danger ele-left">취소</button>
												<button disabled="disabled" id="update-send" type="button"
													class="btn btn-success ele-right">수정</button>
											</div>
										</div>

									</form>
								</div>
								<!-- end wirte-mode -->
								<div id="view-mode">
									<div class="btn_group_view">
										<button disabled="disabled" id="view-list" type="button"
											class="btn btn-secondary ele-right">목록</button>
										<button disabled="disabled" id="view-update" type="button"
											class="btn btn-secondary ele-right">수정</button>
										<button disabled="disabled" id="view-delete" type="button"
											class="btn btn-secondary ele-right">삭제</button>
										<button disabled="disabled" id="view-write" type="button"
											class="btn btn-success ele-right">글작성</button>
										<div class="clear-both"></div>
									</div>
									<div class="article-header">
										<h3 class="view-title"></h3>
										<div class="writer-info"></div>
									</div>
									<div class="article-container"></div>
									<div class="comment-box">
										<div class="comment_option">
											<h3 class="comment_title">
												댓글 <span>0</span>개
											</h3>

										</div>
										<div class="comment-input-container">
											<div class="comment-writer-info"></div>
											<i class="fas fa-sync-alt fa-spin comment_refresh_button"></i>
											<textarea class="comment_content" placeholder="댓글을 작성해주세요"></textarea>
											<a role="button" id="comment-register"
												class="comment-register">등록</a>
										</div>
										<ul class="comment-list">

										</ul>
									</div>
								</div>
								<!-- end view-mode -->
							</div>
							<!-- end board-container -->
						</div>
						<!-- end col-12 -->
					</div>

				</div>
			</div>
			<div class="tm-col tm-col-middle">
				<div class="bg-white tm-block">
					<h2 class="board-title">채팅</h2>
					<div class="row stretch">
						<div class="chatting-section">
							<ul id="msgArea"></ul>
						</div>

					</div>
					<div class="row">
						<form id="sendMessage" name="sendMessage">
							<textarea id="message-input" autocomplete="off"
								class="form-control" type="text"></textarea>
							<button type="submit" class="btn btn-warning message-send"
								onclick="formSend()">전송</button>
						</form>
						<div class="clear-both"></div>
					</div>

					<!-- insert content-->
				</div>
			</div>
		</div>
		<footer class="row tm-mt-small">
			<div class="col-12 font-weight-light">
				<p class="d-inline-block tm-bg-black text-white py-2 px-4">
					Copyright &copy; 2018. Created by <a href="http://www.tooplate.com"
						class="text-white tm-footer-link">Tooplate</a> | Distributed by <a
						href="https://themewagon.com" class="text-white tm-footer-link">ThemeWagon</a>
				</p>
			</div>
		</footer>
	</div>

	<script src="https://kit.fontawesome.com/a6e7d7d152.js"
		crossorigin="anonymous"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	<script src="/cogather/JS/ckeditor/ckeditor.js"></script>
	<script src="${pageContext.request.contextPath }/JS/studyroomMember.js"></script>
	<script src="${pageContext.request.contextPath }/JS/studyroomBoard.js"></script>

	<script>
		$(function(){
			setArgs();
			// 브라우저 새로고침 및 해당 키들에 대한 이벤트 감지하고 경고 문구 날려줌 
			window.addEventListener('beforeunload', (event) => {
			  // 표준에 따라 기본 동작 방지
			  event.preventDefault();
			  // Chrome에서는 returnValue 설정이 필요함
			  event.returnValue = '';
			});
			
			// bfcache(back/forward cache) 브라우저 측에서 최적화하는 방식으로 
			// 앞으로가기나 뒤로가기가 발생할때 즉시 화면을 보여주는 역할을 함 
			// unload, beforeunload와 호환해서 동작되지 않음 
			// bfcache 방식을 보기 가장 좋은 방식은 pageshow, pagehide 이벤트
			// unload는 bfcache 이전에 발생하기 때문에 bfcache를 쓸경우 쓰면 안됨
			// visibilitychange의 hidden state를 사용하는 방법도 있다고는 함
			
			
			$(window).on("pagehide", function(event){ 
				if(currentMode == 'write-mode'){
					var writeFormData = new FormData();
					writeFormData.append('sg_id','${sg_id}');
					writeFormData.append('id','${id}');
					writeFormData.append('ct_uid',$("#write-mode [name='ct_uid']").val());
					writeFormData.append('_csrf', token);
					navigator.sendBeacon(contextPath + '/group/studyboard/delete', writeFormData);
				}
				disconnect();
				var data = new FormData();
				data.append('sg_id','${sg_id}');
				data.append('id','${id}');
				data.append('_csrf', token); // csrf 토큰 값 리퀘스트 파라미터에 담기

				navigator.sendBeacon("./MemberStudyRest/ms/roomoutOk",data)
				
			});
		}); 	
		function setArgs(){
			sg_id = '${sg_id}';
			id = '${id}';
			contextPath = '${pageContext.request.contextPath }';
			token = $("meta[name='_csrf']").attr("th:content");
			header = $("meta[name='_csrf_header']").attr("th:content");
			console.log("sg_id: " + sg_id)
			console.log("id: " + id)
			console.log("contextPath: " + contextPath);
		}
	</script>
</body>
</html>