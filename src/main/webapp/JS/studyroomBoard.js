var page = 1;// 현제 페이지
var pageRows = 10; // 페이지당 글의 개수
var viewItem = undefined; // 가장 최근에 view 한 글의 데이터
var contextPath = undefined; // 컨텍스트 경로
var username = undefined; // 유저 이름
var roomId = undefined; // 방 번호

$(function(){
	contextPath = $("#contextPath").text();
	username = $("#id").text(); 
	roomId = $("#sg_id").text();
	
	
	
	loadBoard(page); // 페이지 최초 로딩
	
	$(".board-list #btnWrite").click(function(){
		togglePage("write-mode"); // 글작성화면 모드로 전환
	});
	$("#view-mode #view-write").click(function(){
		togglePage("write-mode"); // 글작성화면 모드로 전환
	});
	$("#write-list").click(function(){
		chkDelete();
		togglePage("list-mode"); // 본래 리스트 화면으로 
	});
	$("#view-list").click(function(){
		loadBoard(window.page);  // 현재 페이지 목록 다시 로딩
		togglePage("list-mode");// 본래 리스트 화면으로
	});
	$("#write-send").click(function (event){
		event.preventDefault();
		chkUpdate();
	})
	$("#view-delete").click(function(event){
		event.preventDefault();
		chkDelete(); // 삭제
	});
	
	$("#view-update").click(function(event){
		event.preventDefault();
		togglePage("update-mode");
	});
	$("#update-cancel").click(function(){
		togglePage("view-mode");
	});
	$("#update-send").click(function(event){
		event.preventDefault();
		chkUpdate();
	});
	$("#comment-register").click(function(event){
		event.preventDefault();
		sendComment();
	});
	$(".comment-box i").click(function(event){
		event.preventDefault();
		loadComments(viewItem.data[0].ct_uid);
	});
	
});

function loadBoard(page){
	togglePage("list-mode");
	$.ajax({
        url : contextPath+"/group/studyboard/"+roomId+"/page/"+page+"/"+pageRows,
        type : "GET",
        cache : false,
        success : function(data, status){
            if(status == "success"){
                if(updateList(data)){   // application/json 이면 이미 parse 되어 있다.
                    // 업데이트된 list 에 view 동작 이벤트 가동
                    addViewEvent();
                    // ★ 만약 위 코드를 $(document).ready() 에 두면 동작 안할것이다!
                }
            }else{
	console.log("fail");
}
        }
    });  // end $.ajax()
}

function updateList(jsonObj){
	var result = "";
	
	if(jsonObj.status == "OK"){
		var count = jsonObj.cnt;
		window.page = jsonObj.page;
		window.pageRows = jsonObj.pagerows;
		
		var datas = jsonObj.data; 
		
		for(var i = 0; i<count; i++){
			result += "<tr>\n";
			result += "<td>"+ datas[i].ct_uid+"</td>\n";
			result += "<td><span class='content-title' data-uid='"+datas[i].ct_uid+"'>"+ datas[i].ct_title+"<img src='"+contextPath+"/img/group/comment.png' class='comment-icon'><span>[0]</span>"+"</span></td>\n";
			result += "<td><span>"+ datas[i].id+"</span></td>\n";
			result += "<td>"+ datas[i].regdate+"</td>\n";
			result += "<td><span data-viewcnt='"+datas[i].ct_uid+"'>"+ datas[i].ct_viewcnt+"</span></td>\n";
			result += "</tr>\n";
		}
		$("div.board-list tbody").html(result); // 목록 업데이트
		
		// 페이지 정보 업데이트
		// 왼쪽 위 사이드에 페이지, 전체 글 정보 표시
		$("#pageinfo").text(jsonObj.page + "/" + jsonObj.totalpage + "페이지, " + jsonObj.totalcnt + "개의 글");
		
		// 오른쪽 위에 게시글 옵션
		var txt = "";
		txt +="<select id='rows' onchange='changePageRows()'>\n";
		txt += "<option " + ((window.pageRows == 10) ? "selected" : "") + " value='10'>" + "10개씩</option>\n";
        txt += "<option " + ((window.pageRows == 20) ? "selected" : "") + " value='20'>" + "20개씩</option>\n";
        txt += "<option " + ((window.pageRows == 50) ? "selected" : "") + " value='50'>" + "50개씩</option>\n";
        txt += "<option " + ((window.pageRows == 100) ? "selected" : "") + " value='100'>" + "100개씩</option>\n";
        txt += "</select>\n";
        $("#pageRows").html(txt);

		// 페이징 정보 업데이트
		
		var pagination = buildPagination(jsonObj.writepages, jsonObj.totalpage, jsonObj.page);
		$("#pagination").html(pagination);
		return true; // 목록 업데이트 성공 상태 반환
	}else{
		alert("내용이 없음");
		return false;
	}
} // updateList() end

function buildPagination(writePages, totalPage, curPage){
	var str = "";   // 최종적으로 페이징에 나타날 HTML 문자열 <li> 태그로 구성
	
	// 페이징에 보여질 숫자들 (시작숫자 start_page ~ 끝숫자 end_page)
    var start_page = ( (parseInt( (curPage - 1 ) / writePages ) ) * writePages ) + 1;
    var end_page = start_page + writePages - 1;

    if (end_page >= totalPage){
    	end_page = totalPage;
    }
    
  //■ << 표시 여부
	if(curPage > 1){
		str += "<li><a onclick='loadBoard(" + 1 + ")' class='tooltip-top' title='처음'><i class='fas fa-angle-double-left'></i></a></li>\n";
	}
	
  	//■  < 표시 여부
    if (start_page > 1) 
    	str += "<li><a onclick='loadBoard(" + (start_page - 1) + ")' class='tooltip-top' title='이전'><i class='fas fa-angle-left'></i></a></li>\n";
    
    //■  페이징 안의 '숫자' 표시	
	if (totalPage > 1) {
	    for (var k = start_page; k <= end_page; k++) {
	        if (curPage != k)
	            str += "<li><a onclick='loadBoard(" + k + ")'>" + k + "</a></li>\n";
	        else
	            str += "<li><a class='active tooltip-top' title='현재페이지'>" + k + "</a></li>\n";
	    }
	}
	
	//■ > 표시
    if (totalPage > end_page){
    	str += "<li><a onclick='loadBoard(" + (end_page + 1) + ")' class='tooltip-top' title='다음'><i class='fas fa-angle-right'></i></a></li>\n";
    }

	//■ >> 표시
    if (curPage < totalPage) {
        str += "<li><a onclick='loadBoard(" + totalPage + ")' class='tooltip-top' title='맨끝'><i class='fas fa-angle-double-right'></i></a></li>\n";
    }

    return str;
} // end buildPagination();

//<select> 에서 pageRows 값 변경할때마다
function changePageRows(){
    window.pageRows = $("#rows").val();
    loadBoard(window.page);
}

function togglePage(mode){
	if (mode == "write-mode"){
		$(".board-list").hide();
		$("#view-mode").hide();
		$("#write-mode").show();
		
		$(".article-header .writer-info").html('');
		$(".article-container").html('');
		
		$(".btn_group_write #write-list").attr("disabled",false);
		$(".btn_group_write #write-send").attr("disabled",false);
		$(".btn_group_view #view-list").attr("disabled", true);
		$(".btn_group_view #view-update").attr("disabled", true);
		$(".btn_group_view #view-delete").attr("disabled", true);
		$(".btn_group_view #view-write").attr("disabled", true);
		$(".btn_group_update #update-cancel").attr("disabled",true);
		$(".btn_group_update #update-send").attr("disabled",true);
		$(".btn_group_update #update-cancel").hide();
		$(".btn_group_update #update-send").hide();
		$(".comment-list").html('');
		createTempContent();
// 										CKFinder.setupCKEditor(editor);
	}
	if(mode == "list-mode"){
		
		$("#write-mode").hide();
		$("#view-mode").hide();
		$(".board-list").show();
		
		$(".article-header .writer-info").html('');
		$(".article-container").html('');
		
		$(".btn_group_write #write-list").attr("disabled",true);
		$(".btn_group_write #write-send").attr("disabled",true);
		$(".btn_group_view #view-list").attr("disabled", true);
		$(".btn_group_view #view-update").attr("disabled", true);
		$(".btn_group_view #view-delete").attr("disabled", true);
		$(".btn_group_view #view-write").attr("disabled", true);
		$(".btn_group_update #update-cancel").attr("disabled",true);
		$(".btn_group_update #update-send").attr("disabled",true);
		$(".btn_group_update #update-cancel").hide();
		$(".btn_group_update #update-send").hide();
		$("#write-mode [name='ct_uid']").val('');
		$(".comment-list").html('');
	}
	
	if(mode == "view-mode"){
		$("#write-mode").hide();
		$(".board-list").hide();
		
		
		
		$(".btn_group_write #write-list").attr("disabled",true);
		$(".btn_group_write #write-send").attr("disabled",true);
		$(".btn_group_view #view-list").attr("disabled", false);
		$(".btn_group_view #view-write").attr("disabled", false);
		$(".btn_group_update #update-cancel").attr("disabled",true);
		$(".btn_group_update #update-send").attr("disabled",true);
		$(".btn_group_update #update-cancel").hide();
		$(".btn_group_update #update-send").hide();
		
		if(viewItem.member[0].id == username){
			$(".btn_group_view #view-update").show();
			$(".btn_group_view #view-delete").show();
			$(".btn_group_view #view-update").attr("disabled", false);
			$(".btn_group_view #view-delete").attr("disabled", false);
		}else{
			$(".btn_group_view #view-update").hide();
			$(".btn_group_view #view-delete").hide();
			$(".btn_group_view #view-update").attr("disabled", true);
			$(".btn_group_view #view-delete").attr("disabled", true);
		}
		
		$("#view-mode").show();
		
		$("#view-mode .view-title").text(viewItem.data[0].ct_title);
		var userinfo = 
			"<img src='"+contextPath+"/"+viewItem.member[0].pimg_url+"'>"+
			"<div class='profile-area'>" +
				"<div class='profile-info'>"+
					viewItem.member[0].id +
				"</div>"+ 
				"<div class='article-info'>"+
					"<span>"+
						viewItem.data[0].regdate+
					"</span>"+
					"<span>"+
						"조회 "+viewItem.data[0].ct_viewcnt+
					"</span>"+
				"</div>"+
			"</div>"
			;
		$(".article-header .writer-info").html(userinfo);
		$(".article-container").html(viewItem.data[0].ct_content);
		$("#write-mode [name='ct_uid']").val(viewItem.data[0].ct_uid);
		loadComments(viewItem.data[0].ct_uid);
	}
	
	if(mode == "update-mode"){
		$(".board-list").hide();
		$("#view-mode").hide();
		$("#write-mode").show();
		
		$(".article-header .writer-info").html('');
		$(".article-container").html('');
		
		$(".btn_group_write #write-list").attr("disabled",true);
		$(".btn_group_write #write-send").attr("disabled",true);
		$(".btn_group_view #view-list").attr("disabled", true);
		$(".btn_group_view #view-update").attr("disabled", true);
		$(".btn_group_view #view-delete").attr("disabled", true);
		$(".btn_group_view #view-write").attr("disabled", true);
		$(".btn_group_update #update-cancel").attr("disabled",false);
		$(".btn_group_update #update-send").attr("disabled",false);
		$(".btn_group_write #write-list").hide();
		$(".btn_group_write #write-send").hide();
		$(".btn_group_update #update-cancel").show();
		$(".btn_group_update #update-send").show();
		
		$("#write-mode #ct_title").val(viewItem.data[0].ct_title);
		$("#write-mode [name='ct_uid']").val(viewItem.data[0].ct_uid);
		
		CKEDITOR.replace('editor1',
		{
			width:'100%',
			height: '450px',
			allowedContent: true,
			uploadUrl: contextPath+'/group/studyboard/file/'+viewItem.data[0].ct_uid+"?responseType=json"
		});
		
		CKEDITOR.instances.editor1.setData(viewItem.data[0].ct_content);
		
		
	}
}

// 게시글 작성 모드 일 때 임시 게시글 생성하고 게시글 id 받아오기
function createTempContent(){
	var data = $("#frmWrite").serialize();
	
    $.ajax({
        url : contextPath+"/group/studyboard/",
        type : "POST",
        cache : false,
        data : data,  // POST 로 ajax request 할 경우 data 에 parameter 넘기기
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
					$("#frmWrite #ct_title").val("");
					$("#frmWrite #editor1").val("");
					
					$("#write-mode [name='ct_uid']").val(data.data[0].ct_uid);
					
					CKEDITOR.replace('editor1',
					{
						width:'100%',
						height: '450px',
						allowedContent: true,
						uploadUrl: contextPath+'/group/studyboard/file/'+$("#write-mode [name='ct_uid']").val()+"?responseType=json"
					
					});
					CKEDITOR.instances.editor1.setData("");
                } else {
                    alert("INSERT 실패 " + data.status + " : " + data.message);
                }
            }
        }

    });  // end $ajax()
}
// 게시글 id가 받아진다면 파일 업로드 하는 url에 게시글 id 포함해서 보내기 - ckeditor가 바라는 형태에 맞춰서 진행하기

// 만약 게시글 작성이 완료되지 않는다면 업로드된 파일 삭제 및 게시글 삭제 
// -> chkDelete() 로 처리함

//AJAX 로 폼의 데이터를 전송할 때 CKEDITOR로 변환 된 textarea값을 다시 변경해줘야 데이터가 전달된다.

function CKupdate(){

    for ( instance in CKEDITOR.instances )
        CKEDITOR.instances[instance].updateElement();


}
// list-mode의 타이틀 클릭시 view-mode로 바꿈 
function addViewEvent(){
	$(".content-title").click(function(){
		
		$.ajax({
			url: contextPath+"/group/studyboard/"+sg_id+"/detail/" + $(this).attr("data-uid"),
			type: "GET",
			cache: false,
			success: function(data, status){
				if(status == "success"){
					if(data.status == "OK"){
						// 글 읽어 오기는 성공
						window.viewItem = data; //전역변수로 데이터 전달
						togglePage("view-mode"); // 글 읽기 페이지로 변경
						
						$(".board-list table [data-viewcnt='"+viewItem.data[0].ct_uid+"']").text(viewItem.data[0].ct_viewcnt);
					}
				}
			}
		});
	});
}
function view(ct){
	$.ajax({
			url: contextPath+"/group/studyboard/"+sg_id+"/detail/" + ct,
			type: "GET",
			cache: false,
			success: function(data, status){
				if(status == "success"){
					if(data.status == "OK"){
						// 글 읽어 오기는 성공
						window.viewItem = data; //전역변수로 데이터 전달
						togglePage("view-mode"); // 글 읽기 페이지로 변경
						
						$(".board-list table [data-viewcnt='"+viewItem.data[0].ct_uid+"']").text(viewItem.data[0].ct_viewcnt);
					}
				}
			}
		});
}
// 게시글 삭제
function chkDelete() {
	var data = {
		"sg_id": roomId,
		"ct_uid": $("#write-mode [name='ct_uid']").val(),
		"id": username
	}
	$.ajax({
		url: contextPath + "/group/studyboard/",    // URL : /board
		type: "DELETE",
		data: data,
		cache: false,
		success: function(data, status) {
			if (status == "success") {
				if (data.status == "OK") {
//					alert("DELETE성공: " + data.cnt + "개");
					$("#write-mode [name='ct_uid']").val(0);
					loadBoard(window.page);  // 현재 페이지 목록 다시 로딩
					CKEDITOR.instances.editor1.setData('');
				} else {
					alert("DELETE실패: " + data.message);
					return false;
				}
			}
		}
	});
}

// 게시글 수정
function chkUpdate(){
	CKupdate();
    var data = $("#frmWrite").serialize();
	var ct = $("#write-mode [name='ct_uid']").val();
    $.ajax({
        url : contextPath+"/group/studyboard/",
        type : "PUT",
        cache : false,
        data : data,  // PUT 로 ajax request 할 경우 data 에 parameter 넘기기
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
                    alert("update 성공 " + data.cnt + "개:" + data.status);
					$("#frmWrite #ct_title").val("");
					$("#frmWrite #editor1").val("");
					CKEDITOR.instances.editor1.setData("");
                    view(ct);
                } else {
                    alert("INSERT 실패 " + data.status + " : " + data.message);
                }
            }
        }

    });  // end $ajax() 
}

function sendComment(){
	var data = {
		'ct_uid':viewItem.data[0].ct_uid, 
		'id' : username,
		'reply': $('.comment_content').val()
		}
		
	$.ajax({
        url : contextPath+"/group/studyboard/comments",
        type : "POST",
        cache : false,
        data : data, 
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
                    alert("댓글 작성 완료");
					loadComments(viewItem.data[0].ct_uid);
					$('.comment_content').val('');
                } else {
                    alert("INSERT 실패 " + data.status + " : " + data.message);
                }
            }
        }

    });  // end $ajax() 
}


function loadComments(ct_uid){
	$.ajax({
        url : contextPath+"/group/studyboard/comments/"+ct_uid,
        type : "GET",
        cache : false,
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
					showComments(data);
                } else {
                    console.log("댓글 없음");
                }
            }
        }

    });  // end $ajax() 	
}
function showComments(jsonObj){
	var result = "";
	var members = {};
	for(var i=0;i<jsonObj.members.length; i++){
		members[jsonObj.members[i].id] = jsonObj.members[i];
	}
	
	var writer = "";
	writer += "<img src='"+contextPath+"/"+members[username].pimg_url+"'>";
	writer += "<div>"+username+"</div>";
	$(".comment-writer-info").html(writer);
	
	for(var i=0;i <jsonObj.cnt; i++){
		result += "<li id='"+jsonObj.data[i].cm_uid+"comment' class='comment'>";
		result += "<img src='"+contextPath+"/"+members[jsonObj.data[i].id].pimg_url+"'>";
		result += "<div class='comment-writer'>"+jsonObj.data[i].id+"</div>";
		result += "<div class='comment-body-wrapper'>"; 
		result += "<div class='comment-content'>"+jsonObj.data[i].reply+"</div>";	
		result += "<div class='comment-time'>" + jsonObj.data[i].regdate+"</div>";
		if(username == jsonObj.data[i].id){
			result += "<a id='"+jsonObj.data[i].cm_uid+"fix' class='comment-fix-btn'>수정</a>";
			result += "<a id='"+jsonObj.data[i].cm_uid+"del' class='comment-del-btn'>삭제</a>";
			result += "</div>";
			result += "<div class='edit-dialog'></div>";
			result += "</li>";
		}else{
			result += "</div>"
			result += "</li>";	
		}
		
	}
	$("ul.comment-list").html(result);
	
	$(".comment-info span").text(jsonObj.cnt);
	$(".comment a.comment-del-btn").click(function(event){
		event.preventDefault();
		var v = $(this).attr('id').split('del');
		v = v[0];
		delCommentByUser(v);
	});
	
	$(".comment a.comment-fix-btn").click(function(event){
		event.preventDefault();
		var v = $(this).attr('id').split('fix');
		v = v[0];
		toggleCommentDialog(v);
	});
}

function toggleCommentDialog(v){
	$("li[id='"+v+"comment"+"'] .comment-body-wrapper").hide();
	$("li[id='"+v+"comment"+"'] .edit-dialog").show();
	var text = $("li[id='"+v+"comment"+"'] .comment-body-wrapper .comment-content").text();
	var dialog = "";
	dialog += '<div class="comment-input-container">';
	dialog += '<textarea class="comment_content">'+text+'</textarea>'
	dialog += '<a role="button" id="comment-cancel" class="comment-cancel">취소</a>'
	dialog += '<a role="button" id="comment-register" class="comment-register">완료</a>'
	dialog += '</div>'
	$("li[id='"+v+"comment"+"'] .edit-dialog").html(dialog);
	
	$("li[id='"+v+"comment"+"'] .edit-dialog #comment-register").click(function(){
		fixCommentByUser(v);
	});
	$("li[id='"+v+"comment"+"'] .edit-dialog #comment-cancel").click(function(){
		loadComments(viewItem.data[0].ct_uid);
	});
}
function fixCommentByUser(v){
	var text = $("li[id='"+v+"comment"+"'] .comment_content").val();
	alert("text: " + text);
	var data = {'cm_uid':v, 'id': username, 'reply': text};
	
	$.ajax({
        url : contextPath+"/group/studyboard/comments/",
        type : "PUT",
        cache : false,
		data : data,
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
					loadComments(viewItem.data[0].ct_uid);
                } else {
                    alert("댓글 수정 실패 " + data.status + " : " + data.message);
                }
            }
        }

    }); 
	
}

function delCommentByUser(v){
	var data = {'cm_uid':v, 'id': username};
	$.ajax({
        url : contextPath+"/group/studyboard/comments/",
        type : "DELETE",
        cache : false,
		data : data,
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
					loadComments(viewItem.data[0].ct_uid);
                } else {
                    alert("댓글 삭제 실패 " + data.status + " : " + data.message);
                }
            }
        }

    }); 
}
