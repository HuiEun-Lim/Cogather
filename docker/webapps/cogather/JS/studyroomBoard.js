var page = 1;// 현제 페이지
var pageRows = 10; // 페이지당 글의 개수
var viewItem = undefined; // 가장 최근에 view 한 글의 데이터
var currentMode = 'list-mode';
$(function(){
	setArgs();
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
	$("#write-send").click(function (event){ // 글작성이지만 임시 글에대한 수정으로 들어가도록 변경
		event.preventDefault();
		chkUpdate();
	})
	$("#view-delete").click(function(event){ // 글 삭제 버튼 클릭
		event.preventDefault();
		chkDelete(); // 삭제
	});
	
	$("#view-update").click(function(event){ // 글 수정 버튼 클릭시 이벤트
		event.preventDefault();
		togglePage("update-mode");
	});
	$("#update-cancel").click(function(){ // 글 수정 중 글을 수정하지 않고 되돌아 갈때
		togglePage("view-mode");
	});
	$("#update-send").click(function(event){// 글 수정 제출 이벤트
		event.preventDefault();
		chkUpdate();
	});
	$("#comment-register").click(function(event){ // 댓글 작성 이벤트
		event.preventDefault();
		sendComment();
	});
	$(".comment-box i").click(function(event){ // 댓글 새로고침 버튼 클릭 이벤트
		event.preventDefault();
		loadComments(viewItem.data[0].ct_uid); // 게시글 아이디로 새로 받아서 뿌려줌
	});
	
	

});



function loadBoard(page){ // 방 번호와 페이지, 페이지에 표시할 글의 수로 데이터를 받아옴
	togglePage("list-mode");
	$.ajax({
        url : contextPath+"/group/studyboard/"+sg_id+"/page/"+page+"/"+pageRows,
        type : "GET",
        cache : false,
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
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
}// end loadBoard(page)
// 방 번호와 페이지, 페이지에 표시할 글의 수로 데이터를 받아온 걸 토대로 글 리스트를 뿌려줌
function updateList(jsonObj){
	var result = "";
	
	if(jsonObj.status == "OK"){
		var count = jsonObj.cnt;
		window.page = jsonObj.page;
		window.pageRows = jsonObj.pagerows;
		
		var datas = jsonObj.data; 
		var cmCnt = jsonObj.cmCnt;
		for(var i = 0; i<count; i++){
			if(datas[i].ct_title != null){
				result += "<tr>\n";
				result += "<td><span class='content-title' data-uid='"+datas[i].ct_uid+"'>"+ datas[i].ct_title+
						  "<img src='"+contextPath+"/img/group/comment.png' class='comment-icon'><span>["+cmCnt[i].cnt+"]</span>"+
						  "</span><div class='content-sub-info'><span>"+ datas[i].id+"</span><span>"+datas[i].regdate+"</span></td>\n";
				result += "<td><span data-viewcnt='"+datas[i].ct_uid+"'>"+ datas[i].ct_viewcnt+"</span></td>\n";
				result += "</tr>\n";	
			}
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
		$("div.board-list tbody").html("<div>내용없음</div>");
		return false;
	}
} // updateList() end

// 페이징 정보를 뿌려줌
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

//<select> 에서 pageRows 값 변경할때마다 새로 글 목록 업데이트
function changePageRows(){
    window.pageRows = $("#rows").val();
    loadBoard(window.page);
} // end changePageRows()

// 특정 버튼 클릭시 원하는 화면을 구성하기 위해 특정요소를 숨기고 보여줄 요소들을 드러나게 하는 함수
function togglePage(mode){
	currentMode = mode;
	console.log('currentmode : ' + currentMode);
	if (mode == "write-mode"){
		$(".board-list").hide(); // 게시글 가리기
		$("#view-mode").hide(); // view 가리기
		$("#write-mode").show(); // 입력 화면 보이기
		
		$(".article-header .writer-info").html(''); // view의 일부 정보 초기화
		$(".article-container").html(''); // // view의 일부 정보 초기화
		
		$(".btn_group_write #write-list").attr("disabled",false); // write 시 필요한 버튼활성화
		$(".btn_group_write #write-send").attr("disabled",false); // write 시 필요한 버튼활성화
		$(".btn_group_view #view-list").attr("disabled", true); // write 시 불필요한 버튼 비활성화
		$(".btn_group_view #view-update").attr("disabled", true); // write 시 불필요한 버튼 비활성화
		$(".btn_group_view #view-delete").attr("disabled", true); // write 시 불필요한 버튼 비활성화
		$(".btn_group_view #view-write").attr("disabled", true); // write 시 불필요한 버튼 비활성화
		$(".btn_group_update #update-cancel").attr("disabled",true); // write 시 불필요한 버튼 비활성화
		$(".btn_group_update #update-send").attr("disabled",true); // write 시 불필요한 버튼 비활성화
		$(".btn_group_update #update-cancel").hide(); // write 시 불필요한 버튼 가리기
		$(".btn_group_update #update-send").hide(); // write 시 불필요한 버튼 가리기
		$(".comment-list").html(''); // write 시 불필요한 댓글 파트 가리기
		
		createTempContent(); // 임시글 생성후 표시
	}
	if(mode == "list-mode"){
		$("#write-mode").hide(); // 리스트 표기시 불필요한 write 파트 가리기
		$("#view-mode").hide();  // 리스트 표기시 불필요한 view 파트 가리기
		$(".board-list").show(); // 글 리스트 보이기
		
		$(".article-header .writer-info").html(''); // 글 리스트 표기시 불필요한 내용 지우기
		$(".article-container").html(''); // 글 리스트 표기시 불필요한 내용 지우기
		
		$(".btn_group_write #write-list").attr("disabled",true); // 글 리스트 표기시 불필요한 버튼 비 활성화
		$(".btn_group_write #write-send").attr("disabled",true); // 글 리스트 표기시 불필요한 버튼 비 활성화 
		$(".btn_group_view #view-list").attr("disabled", true); // 글 리스트 표기시 불필요한 버튼 비 활성화
		$(".btn_group_view #view-update").attr("disabled", true); // 글 리스트 표기시 불필요한 버튼 비 활성화
		$(".btn_group_view #view-delete").attr("disabled", true); // 글 리스트 표기시 불필요한 버튼 비 활성화
		$(".btn_group_view #view-write").attr("disabled", true); // 글 리스트 표기시 불필요한 버튼 비 활성화
		$(".btn_group_update #update-cancel").attr("disabled",true); // 글 리스트 표기시 불필요한 버튼 비 활성화
		$(".btn_group_update #update-send").attr("disabled",true); // 글 리스트 표기시 불필요한 버튼 비 활성화
		$(".btn_group_update #update-cancel").hide(); // 글 리스트 표기시 불필요한 버튼 가리기
		$(".btn_group_update #update-send").hide(); // 글 리스트 표기시 불필요한 버튼 가리기
		$("#write-mode [name='ct_uid']").val(''); // 글 리스트 표기시 글을 선택하지 않았으므로 글을 선택했다는 내용 없애기
		$(".comment-list").html(''); // 글 리스트 표기시 불필요한 버튼 가리기
	}
	
	if(mode == "view-mode"){
		$("#write-mode").hide(); // 글작성 부분 가리기
		$(".board-list").hide(); // 글 목록 부분 가리기
		
		
		
		$(".btn_group_write #write-list").attr("disabled",true); // 글 상세보기시 불필요한 버튼 비 활성화
		$(".btn_group_write #write-send").attr("disabled",true); // 글 상세보기시 불필요한 버튼 비 활성화
		$(".btn_group_view #view-list").attr("disabled", false); // 글 상세보기시 필요한 버튼 활성화
		$(".btn_group_view #view-write").attr("disabled", false); // 글 상세보기시 필요한 버튼 활성화
		$(".btn_group_update #update-cancel").attr("disabled",true);  // 글 상세보기시 불필요한 버튼 비 활성화
		$(".btn_group_update #update-send").attr("disabled",true); // 글 상세보기시 불필요한 버튼 비 활성화
		$(".btn_group_update #update-cancel").hide(); // 글 상세보기시 불필요한 버튼 가리기
		$(".btn_group_update #update-send").hide(); // 글 상세보기시 불필요한 버튼 가리기
		
		if(viewItem.member[0].id == id){ // 상세보기시 해당 글을 보는 유저와 글쓴이가 동일할 때 수정, 삭제 버튼 활성화 및 보이기
			$(".btn_group_view #view-update").show();
			$(".btn_group_view #view-delete").show();
			$(".btn_group_view #view-update").attr("disabled", false);
			$(".btn_group_view #view-delete").attr("disabled", false);
		}else{// 상세보기시 해당 글을 보는 유저와 글쓴이가 동일하지 않을때 수정, 삭제 버튼 비활성화 및 보이지 않기
			$(".btn_group_view #view-update").hide();
			$(".btn_group_view #view-delete").hide();
			$(".btn_group_view #view-update").attr("disabled", true);
			$(".btn_group_view #view-delete").attr("disabled", true);
		}
		
		$("#view-mode").show(); // view 파트 보이기
		
		$("#view-mode .view-title").text(viewItem.data[0].ct_title); // 글 상세 페이지 제목 넣기
		var userinfo =  // 글 상세 페이지 글쓴이 정보, 조회수, 작성일 표기
			"<img src='"+contextPath+"/"+viewItem.member[0].pimg_url+"'>"+
			"<div class='profile-area'>" +
				"<div class='profile-info'>"+
					viewItem.member[0].id +
				"</div>"+ 
				"<div class='article-info'>"+
					"<span>"+
						viewItem.data[0].regdate+
					"</span>"+
					"<div>"+
						"조회 "+viewItem.data[0].ct_viewcnt+
					"</div>"+
				"</div>"+
			"</div>"
			;
		$(".article-header .writer-info").html(userinfo);
		$(".article-container").html(viewItem.data[0].ct_content); // 내용 넣어주기 
		$("#write-mode [name='ct_uid']").val(viewItem.data[0].ct_uid); // 글의 id 저장해두기 
		loadComments(viewItem.data[0].ct_uid); // 해당 글의 댓글이 있다면 불러오기
	}
	
	if(mode == "update-mode"){ 
		$(".board-list").hide(); // 글 수정시 글 목록 부분 가리기
		$("#view-mode").hide(); // 글 수정시 글 상세 페이지 가리기
		$("#write-mode").show(); // 글 수정시 글 쓰기 보이기
		
		$(".article-header .writer-info").html(''); // 글 상세페이지 일부분 초기화
		$(".article-container").html(''); // 글 상세페이지 일부분 초기화
		
		$(".btn_group_write #write-list").attr("disabled",true); // 글 수정시 불필요한 부분 비 활성화
		$(".btn_group_write #write-send").attr("disabled",true); // 글 수정시 불필요한 부분 비 활성화
		$(".btn_group_view #view-list").attr("disabled", true); // 글 수정시 불필요한 부분 비 활성화
		$(".btn_group_view #view-update").attr("disabled", true); // 글 수정시 불필요한 부분 비 활성화
		$(".btn_group_view #view-delete").attr("disabled", true); // 글 수정시 불필요한 부분 비 활성화
		$(".btn_group_view #view-write").attr("disabled", true); // 글 수정시 불필요한 부분 비 활성화 
		$(".btn_group_update #update-cancel").attr("disabled",false); // 글 수정시 필요한 부분 활성화
		$(".btn_group_update #update-send").attr("disabled",false); // 글 수정시 필요한 부분 활성화
		$(".btn_group_write #write-list").hide(); // 글 수정시 불필요한 부분 가리기
		$(".btn_group_write #write-send").hide(); // 글 수정시 불필요한 부분 가리기
		$(".btn_group_update #update-cancel").show(); // 글 수정시 필요한 부분 보이기
		$(".btn_group_update #update-send").show(); // 글 수정시 필요한 부분 보이기
		
		$("#write-mode #ct_title").val(viewItem.data[0].ct_title); // 글 제목이 있다면 제목 란에 미리 넣어두기
		$("#write-mode [name='ct_uid']").val(viewItem.data[0].ct_uid); // 해당 글에 대한 uid 저장해두기
		CKEDITOR.replace('editor1', // 글작성 에디터 설정 
		{
			width:'100%',
			height: '450px',
			allowedContent: true,
			fileTools_requestHeaders:{ // 헤더에 csrf 토큰 값 담아서 보내기
				'X-CSRF-TOKEN' : token 
			},
			uploadUrl: contextPath+'/group/studyboard/file/'+viewItem.data[0].ct_uid+"?responseType=json" // 에디터에 사진을 끌어다 놓을 시 업로드하게 되는 url 작성
		});
		
		
		CKEDITOR.instances.editor1.setData(viewItem.data[0].ct_content); // 사용자에게 textarea가 아닌 editor가 보이므로 editor에 원래 내용 넣어주기
		
		
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
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
					$("#frmWrite #ct_title").val("");
					$("#frmWrite #editor1").val("");
					
					$("#write-mode [name='ct_uid']").val(data.data[0].ct_uid);
					CKEDITOR.replace('editor1', // 글작성 에디터 설정
					{
						width:'100%',
						height: '450px',
						allowedContent: true,
						fileTools_requestHeaders:{
							'X-CSRF-TOKEN' : token
						},
						uploadUrl: contextPath+'/group/studyboard/file/'+$("#write-mode [name='ct_uid']").val()+"?responseType=json&"+header+"="+token // 에디터에 사진을 끌어다 놓을 시 업로드하게 되는 url 작성
					
					});
					CKEDITOR.instances.editor1.setData("");
					console.log("임시 작성글 생성");
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

function CKupdate(){ // editor에 글이 써있어도 현제 에디터 인스턴스에는 값이 안들어 있다. 값을 넣으려면 업데이트

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
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			},
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
// 상세페이지 보기
function view(ct){
	$.ajax({
			url: contextPath+"/group/studyboard/"+sg_id+"/detail/" + ct,
			type: "GET",
			cache: false,
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status){
				if(status == "success"){
					if(data.status == "OK"){
						// 글 읽어 오기는 성공
						window.viewItem = data; //전역변수로 데이터 전달
						togglePage("view-mode"); // 글 읽기 페이지로 변경
						
						$(".board-list table [data-viewcnt='"+viewItem.data[0].ct_uid+"']").text(viewItem.data[0].ct_viewcnt); // 보고 있는 글의 조회수 업데이트
					}
				}
			}
		});
}
// 게시글 삭제
function chkDelete() {
	var data = {
		"sg_id": sg_id,
		"ct_uid": $("#write-mode [name='ct_uid']").val(),
		"id": id
	}
	$.ajax({
		url: contextPath + "/group/studyboard/delete",    // URL : /board
		type: "POST",
		data: data,
		cache: false,
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
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
	if($("#ct_title").val().trim() == ''){
		alert("제목을 입력해주세요..");
	}else{
		CKupdate();
    var data = $("#frmWrite").serialize();
	var ct = $("#write-mode [name='ct_uid']").val();
    $.ajax({
        url : contextPath+"/group/studyboard/",
        type : "PUT",
        cache : false,
        data : data,  // PUT 로 ajax request 할 경우 data 에 parameter 넘기기
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
                  
					$("#frmWrite #ct_title").val("");
					$("#frmWrite #editor1").val("");
					CKEDITOR.instances.editor1.setData(""); // 게시글 작성 완료후 에디터에 남아 있는 값 날리기
                    view(ct);
                } else {
                    alert("INSERT 실패 " + data.status + " : " + data.message);
                }
            }
        }

    });  // end $ajax() 
	
	}
}

function sendComment(){ // 댓글 작성
	var reply = $('.comment_content').val().trim();
	reply = reply.replace(/(?:\r\n|\r|\n)/g, '<br/>');
	var data = {
		'ct_uid':viewItem.data[0].ct_uid, 
		'id' : id,
		'reply': reply
		}
	if(reply == ''){
		alert("댓글이 빈칸입니다.");
	}else{
		$.ajax({
        url : contextPath+"/group/studyboard/comments",
        type : "POST",
        cache : false,
        data : data,
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		}, 
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
					loadComments(viewItem.data[0].ct_uid);
					$('.comment_content').val('');
					console.log("댓글 작성 완료");
                } else {
                    alert("INSERT 실패 " + data.status + " : " + data.message);
                }
            }
        }
    	});  // end $ajax() 	
	}
}

// 댓글 데이터 불러오기
function loadComments(ct_uid){
	$.ajax({
        url : contextPath+"/group/studyboard/comments/"+ct_uid,
        type : "GET",
        cache : false,
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
					showComments(data);
                } else {
					console.log("댓글 없음");
					showComments(data);
                }
            }
        }

    });  // end $ajax() 	
}
// 댓글 데이터 뿌리기
function showComments(jsonObj){
	var result = "";
	var members = {};
	
	for(var i=0;i<jsonObj.members.length; i++){
		members[jsonObj.members[i].id] = jsonObj.members[i];
	}
	
	for(var i=0;i <jsonObj.cnt; i++){
		result += "<li id='"+jsonObj.data[i].cm_uid+"comment' class='comment'>";
		result += "<img src='"+contextPath+"/"+members[jsonObj.data[i].id].pimg_url+"'>";
		result += "<div class='comment-writer'>"+jsonObj.data[i].id+"</div>";
		result += "<div class='comment-body-wrapper'>"; 
		result += "<div class='comment-content'>"+jsonObj.data[i].reply+"</div>";	
		result += "<div class='comment-time'>" + jsonObj.data[i].regdate+"</div>";
		if(id == jsonObj.data[i].id){ // 댓글 쓴 사람이 지금의 유저면 수정/삭제 버튼 표시
			result += "<a id='"+jsonObj.data[i].cm_uid+"fix' class='comment-fix-btn'>수정</a>";
			result += "<a id='"+jsonObj.data[i].cm_uid+"del' class='comment-del-btn'>삭제</a>";
			result += "</div>";
			result += "<div class='edit-dialog'></div>";
			result += "</li>";
		}else{ // 아니라면 보이지 않기
			result += "</div>"
			result += "</li>";	
		}	
	}
	$("ul.comment-list").html(result);
	
	$(".comment_title span").text(jsonObj.cnt);
	$(".comment a.comment-del-btn").click(function(event){ // 댓글 삭제 버튼 클릭시 
		event.preventDefault();
		var v = $(this).attr('id').split('del');
		v = v[0];
		delCommentByUser(v); // 댓글 삭제하기
	});
	
	$(".comment a.comment-fix-btn").click(function(event){ // 댓글 수정 버튼 클릭시 
		event.preventDefault();
		var v = $(this).attr('id').split('fix');
		v = v[0];
		toggleCommentDialog(v); // 댓글 수정 모드
	});
}

function toggleCommentDialog(v){ // 유튜브 댓글 수정 파트 보고 감명 받아 만듬 .. 일반 적으로 보이는 댓글 부분과 그 부분에 수정을 위한 부분을 따로 남겨놓아서 toggle 되게 끔 
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
	$("li[id='"+v+"comment"+"'] .edit-dialog #comment-cancel").click(function(){ // 댓글 수정 취소시 댓글 다시 리로드
		loadComments(viewItem.data[0].ct_uid);
	});
}
// 댓글 창에 있는 내용을 가져다가 수정 요청 보냄
function fixCommentByUser(v){
	var text = $("li[id='"+v+"comment"+"'] .comment_content").val();
	
	var data = {'cm_uid':v, 'id': id, 'reply': text};
	
	$.ajax({
        url : contextPath+"/group/studyboard/comments/",
        type : "PUT",
        cache : false,
		data : data,
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
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

// 댓글 삭제
function delCommentByUser(v){
	var data = {'cm_uid':v, 'id': id};
	$.ajax({
        url : contextPath+"/group/studyboard/comments/",
        type : "DELETE",
        cache : false,
		data : data,
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
					loadComments(viewItem.data[0].ct_uid);
					console.log("글 삭제 완료");
                } else {
                    alert("댓글 삭제 실패 " + data.status + " : " + data.message);
                }
            }
        }

    }); 
}
