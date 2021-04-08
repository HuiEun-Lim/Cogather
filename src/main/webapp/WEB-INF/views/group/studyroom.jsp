<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>스터디 방</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/CSS/studyroom.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/a6e7d7d152.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/cogather/JS/ckeditor/ckeditor.js"></script>
<script src="${pageContext.request.contextPath }/JS/chat.js"></script>
<script src="${pageContext.request.contextPath }/JS/studyroomMember.js"></script>
<script src="${pageContext.request.contextPath }/JS/studyroomBoard.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<div class="room">
		<nav id="room-menu">
			<h2 id="room-title">${studyGroupBYSGID[0].sg_name }</h2>
			<span id="enter-cnt-head">참여인원</span><span id="enter-cnt"></span>
			<button id="outroom" class="btn btn-danger" onclick="outroom()">퇴실하기</button>
			<div class="clear-both"></div>
		</nav>
		<div class="content-body">

			<div class="container">
				<div class="left">
					<div class="user-list"></div>

				</div>
				<div class="clear-both"></div>
				
				<div class="center">
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
								<col style="width:88px">
								<col>
								<col style="width:118px">
								<col style="width:80px">
								<col style="width:68px">
							</colgroup>
							<thead>
								<tr id="simpleTableTitle">
									<th scope="col">  </th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>								
									<th scope="col">작성일</th>								
									<th scope="col">조회</th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
						
						<div class="board-list">
							<div class="ele-right">
								<button type="button" class="btn btn-warning" id="btnWrite" >글작성</button>
							</div>
						</div>
						<div class="clear-both"></div>
						<%-- 페이징 --%>
						<div class="paging-center">
							<ul class="pagination" id="pagination"></ul>
						</div>
						
					</div> <!-- board-list end  -->
					<div class="clear-both"></div>
					
					<div id="write-mode">
						<form id="frmWrite"  method="post">
							<div class="container">
							<input id="content-uid" type="hidden" name="ct_uid" value="0">
								<div class="form-group">
									<label class="col-sm-2" for="title">제목:</label>
									<input class="form-control" type="text" id="ct_title" placeholder="제목을 입력해주세요" name="ct_title">
								</div>
									<input type="hidden" id="roomNumber" name="sg_id" value="${sg_id }">
									<input type="hidden" id="userid" name="id" value="${id }">
									<label class="control-label col-sm-2" for="ct_content">내용</label>
									<textarea name="ct_content" id="editor1" style="width:640;height:600;margin:0 0 0 0px;"></textarea><br><br>
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
								
								<div class="btn_group_write">
									<button disabled="disabled" id="write-list" type="button" class="btn btn-secondary ele-left">목록</button>
									<button disabled="disabled" id="write-send" type="button" class="btn btn-success ele-right" onclick="chkWrite()">작성</button>
								</div>
								<div class="btn_group_update">
									<button disabled="disabled" id="update-cancel" type="button" class="btn btn-danger ele-left">취소</button>
									<button disabled="disabled" id="update-send" type="button" class="btn btn-success ele-right">수정</button>
								</div>
							</div>
							
						</form>
					</div>
					<div id="view-mode">
						<div class="btn_group_view">
							<button disabled="disabled" id="view-list" type="button" class="btn btn-secondary ele-right">목록</button>
							<button disabled="disabled" id="view-update" type="button" class="btn btn-secondary ele-right">수정</button>
							<button disabled="disabled" id="view-delete" type="button" class="btn btn-secondary ele-right">삭제</button>
							<button disabled="disabled" id="view-write" type="button" class="btn btn-success ele-right">글작성</button>
						</div>
						<div class="article-header">
							<h3 class= "view-title"></h3>
							<div class="writer-info"></div>
						</div>
						<div class="article-container">
						
						</div>
						<div class="comment-info"></div>
						<div class="comment-box"></div>
					</div>
					
				</div>

				<div class="right">
					<div class="chatting-section">
						<div class="chatbox">
							<ul id="msgArea"></ul>
						</div>

						<form id="sendMessage" name="sendMessage">
							<input id="message-input" class="form-control" type="text">
							<button type="submit" class="btn btn-warning message-send" onclick="formSend()">전송</button>
						</form>
					</div>


				</div>
				<div class="clear-both"></div>

				<div id="sg_id">${sg_id }</div>
				<div id="id">${id }</div>
				<div id="contextPath">${pageContext.request.contextPath }</div>
			</div>


		</div>
	</div>


	<script>
		
	</script>
</body>
</html>