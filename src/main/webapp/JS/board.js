var page = 1;   //  현재 페이지
var pageRows = 10;  // 페이지당 글의 개수
var viewItem = undefined;   // 가장 최근에 view 한 글의 데이터

// 페이지 최초 로딩되면 게시글 목록 첫페이지분 로딩
$(document).ready(function(){
    loadPage(page);   // 페이지 최초 로딩

    // '글작성' 버튼 누르면 팝업
    $("#btnWrite").click(function(){
        setPopup("write");  // 글작성 용으로 모달팝업 셋업
        $("#dlg_write").show();
    });

    // 모달 대화상자 close 버튼 누르면
    $(".modal .close").click(function(){
        $(this).parents(".modal").hide();
    });

    // '글작성' 폼 submit 되면
    $("#frmWrite").submit(function(){
        $(this).parents(".modal").hide();

        return chkWrite();
    });

    // '글삭제' 버튼 누르면
    $("#btnDel").click(function(){
        chkDelete();
    });

    // 글읽기(view) 대화상자에서 삭제버튼 누르면 해당 글(uid) 삭제 진행
    $("#viewDelete").click(function(){
        var uid = viewItem.uid;
        if(deleteUid(uid)){
            $(this).parents(".modal").hide();  // 삭제 성공하면 팝업 닫기
        }
    });

    // 글읽기(view) 대화상자에서 수정버튼 누르면 
    $("#viewUpdate").click(function(){
        setPopup("update");
    });

    // 글수정 완료 버튼 누르면
    $("#updateOk").click(function(){
        chkUpdate();
    })
});

//page번째 페이지 목록 읽어오기
// ㄴㄴㄴ
function loadPage(page){
    $.ajax({
        url : "./" + page + "/" + pageRows,
        type : "GET",
        cache : false,
        success : function(data, status){
            if(status == "success"){
                //alert("성공했쮸?");

                if(updateList(data)){   // application/json 이면 이미 parse 되어 있다.

                    // 업데이트된 list 에 view 동작 이벤트 가동
                    addViewEvent();
                    // ★ 만약 위 코드를 $(document).ready() 에 두면 동작 안할것이다!
                }
            }
        }
    });  // end $.ajax()
} // end loadPage()

function updateList(jsonObj){

    var result = "";  // 최종 결과

    if(jsonObj.status == "OK"){
        var count = jsonObj.count;

        window.page = jsonObj.page;
        window.pageRows = jsonObj.pagerows; 

        var items = jsonObj.data; // 배열

        for(var i = 0; i < count; i++){
            result += "<tr>\n";
            result += "<td><input type='checkbox' name='uid' value='" + items[i].uid + "'>" + "</td>\n";
            result += "<td>" + items[i].uid + "</td>\n";
            result += "<td><span class='subject' data-uid='" + items[i].uid + "'>" + items[i].subject + "</span></td>\n";
            result += "<td>" + items[i].name + "</td>\n";
            result += "<td><span data-viewcnt='" + items[i].uid + "'>" + items[i].viewcnt + "</span></td>\n";
            result += "<td>" + items[i].regDateTime + "</td>\n";
            result += "</tr>\n";
        }
        $("#list tbody").html(result);  // 업데이트

        // 페이지 정보 업데이트
        $("#pageinfo").text(jsonObj.page + "/" + jsonObj.totalpage + "페이지, " + jsonObj.totalcnt + "개의 글");

        // pageRows
        var txt = "<select id='rows' onchange='changePageRows()'>\n";
        txt += "<option " + ((window.pageRows == 10) ? "selected" : "") + " value='10'>" + "10개씩</option>\n";
        txt += "<option " + ((window.pageRows == 20) ? "selected" : "") + " value='20'>" + "20개씩</option>\n";
        txt += "<option " + ((window.pageRows == 50) ? "selected" : "") + " value='50'>" + "50개씩</option>\n";
        txt += "<option " + ((window.pageRows == 100) ? "selected" : "") + " value='100'>" + "100개씩</option>\n";
        txt += "</select>\n";
        $("#pageRows").html(txt);

        // [페이징 정보 업데이트]
        var pagination = buildPagination(jsonObj.writepages, jsonObj.totalpage, jsonObj.page, jsonObj.pagerows);
        $("#pagination").html(pagination);

        return true;  // 목록 업데이트 성공하면 true 리턴
    } else {
        alert("내용이 없습니다.");
        return false;
    }


} // end updateList()

// 페이징 생성
// 한페이징에 표시될 페이지수 --> writePages
// 총 페이지수 --> totalPage
// 현재 페이지 --> curPage

function buildPagination(writePages, totalPage, curPage, pageRows){
	var str = "";   // 최종적으로 페이징에 나타날 HTML 문자열 <li> 태그로 구성
	
	// 페이징에 보여질 숫자들 (시작숫자 start_page ~ 끝숫자 end_page)
    var start_page = ( (parseInt( (curPage - 1 ) / writePages ) ) * writePages ) + 1;
    var end_page = start_page + writePages - 1;

    if (end_page >= totalPage){
    	end_page = totalPage;
    }
    
  //■ << 표시 여부
	if(curPage > 1){
		str += "<li><a onclick='loadPage(" + 1 + ")' class='tooltip-top' title='처음'><i class='fas fa-angle-double-left'></i></a></li>\n";
	}
	
  	//■  < 표시 여부
    if (start_page > 1) 
    	str += "<li><a onclick='loadPage(" + (start_page - 1) + ")' class='tooltip-top' title='이전'><i class='fas fa-angle-left'></i></a></li>\n";
    
    //■  페이징 안의 '숫자' 표시	
	if (totalPage > 1) {
	    for (var k = start_page; k <= end_page; k++) {
	        if (curPage != k)
	            str += "<li><a onclick='loadPage(" + k + ")'>" + k + "</a></li>\n";
	        else
	            str += "<li><a class='active tooltip-top' title='현재페이지'>" + k + "</a></li>\n";
	    }
	}
	
	//■ > 표시
    if (totalPage > end_page){
    	str += "<li><a onclick='loadPage(" + (end_page + 1) + ")' class='tooltip-top' title='다음'><i class='fas fa-angle-right'></i></a></li>\n";
    }

	//■ >> 표시
    if (curPage < totalPage) {
        str += "<li><a onclick='loadPage(" + totalPage + ")' class='tooltip-top' title='맨끝'><i class='fas fa-angle-double-right'></i></a></li>\n";
    }

    return str;
} // end buildPagination();

//<select> 에서 pageRows 값 변경할때마다
function changePageRows(){
    window.pageRows = $("#rows").val();
    loadPage(window.page);
}

// 글 쓰기/읽기/수정 대화상자 세팅
function setPopup(mode){

    // 글 작성
	if(mode == "write"){	
		$('#frmWrite')[0].reset();  // form 내의 기존 내용 reset	
		$("#dlg_write .title").text("새글 작성");
		$("#dlg_write .btn_group_header").hide();
		$("#dlg_write .btn_group_write").show();
		$("#dlg_write .btn_group_view").hide();
		$("#dlg_write .btn_group_update").hide();

		$("#dlg_write input[name='subject']").attr("readonly", false);
		$("#dlg_write input[name='subject']").css("border", "1px solid #ccc");
		$("#dlg_write input[name='name']").attr("readonly", false);
		$("#dlg_write input[name='name']").css("border", "1px solid #ccc");
		$("#dlg_write textarea[name='content']").attr("readonly", false);
		$("#dlg_write textarea[name='content']").css("border", "1px solid #ccc");
	} 

    // 글 읽기
	if(mode == "view"){
		$("#dlg_write .title").text("글 읽기");
		$("#dlg_write .btn_group_header").show();
		$("#dlg_write .btn_group_write").hide();
		$("#dlg_write .btn_group_view").show();
		$("#dlg_write .btn_group_update").hide();	
		
		$("#dlg_write #viewcnt").text("#" + viewItem.uid + " - 조회수: " + viewItem.viewcnt);
		$("#dlg_write #regdate").text(viewItem.regDateTime);  // DTO 의 getRegDate() 
		
		$("#dlg_write input[name='uid']").val(viewItem.uid);  // 나중에 삭제나 수정을 위해 필요
		
		$("#dlg_write input[name='subject']").val(viewItem.subject);
		$("#dlg_write input[name='subject']").attr("readonly", true);
		$("#dlg_write input[name='subject']").css("border", "none");
		
		$("#dlg_write input[name='name']").val(viewItem.name);
		$("#dlg_write input[name='name']").attr("readonly", true);
		$("#dlg_write input[name='name']").css("border", "none");
		
		$("#dlg_write textarea[name='content']").val(viewItem.content);
		$("#dlg_write textarea[name='content']").attr("readonly", true);
		$("#dlg_write textarea[name='content']").css("border", "none");
		
	}

    // 글 수정
	if(mode == "update"){
		$("#dlg_write .title").text("글 수정");
		
		$("#dlg_write .btn_group_header").show();
		$("#dlg_write .btn_group_write").hide();
		$("#dlg_write .btn_group_view").hide();
		$("#dlg_write .btn_group_update").show();
		
		$("#dlg_write input[name='subject']").attr("readonly", false);
		$("#dlg_write input[name='subject']").css("border", "1px solid #ccc");
		$("#dlg_write input[name='name']").attr("readonly", true);  // 작성자는 수정 불가
		$("#dlg_write textarea[name='content']").attr("readonly", false);
		$("#dlg_write textarea[name='content']").css("border", "1px solid #ccc");
		
	}


} // end setPopup()

// 새글 등록 처리
function chkWrite(){

    var data = $("#frmWrite").serialize();

    $.ajax({
        url : ".",
        type : "POST",
        cache : false,
        data : data,  // POST 로 ajax request 할 경우 data 에 parameter 넘기기

        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
                    alert("INSERT 성공 " + data.count + "개:" + data.status);
                    loadPage(1);  // 첫페이지 로딩
                } else {
                    alert("INSERT 실패 " + data.status + " : " + data.message);
                }
            }
        }

    });  // end $ajax()

    // request  끝나고 나서  기본 입력된거 지우기
    
    return false;
} // end chkWrite();


//현재 글 목록 list 에 대해 이벤트 등록
//- 제목(subject) 클릭하면 view 팝업 화면 뜰수 있게 하기
function addViewEvent(){
    $("#list .subject").click(function(){
        // 읽어오기
        $.ajax({
            url : "./" + $(this).attr("data-uid"),      // url :  /board/{uid}
            type : "GET",
            cache : false,
            success : function(data, status){
                if(status == "success"){
                    if(data.status == "OK"){
                        // 글 읽어오기 성공하면, 내부 데이터 세팅하고 팝업 대화상자 보여주기
                        window.viewItem = data.data[0];

                        setPopup("view");  // 글읽기 팝업 띄우기
                        $("#dlg_write").show();

                        // 리스트상의 조회수도 증가시켜야 한다.
                        $("#list [data-viewcnt='" + viewItem.uid + "']").text(viewItem.viewcnt);
                    } else {
                        alert("VIEW 실패 : " + data.message);
                    }
                }
            }
        });
    });
} // end addViewEvent()

//check 된 uid 의 게시글들만 삭제하기
function chkDelete(){
    var uids = [];  // check 된 uid  들을 담을 배열 준비

    $("#list tbody input[name=uid]").each(function(){
        if($(this).is(":checked")){   // jQuery에서 checked 여부 확인함수
            uids.push(parseInt($(this).val()));   // 배열에 uid 값 추가
        }
    });

    if(uids.length == 0){
        alert("삭제할 글을 체크해주세요");
    } else {
        if(!confirm(uids.length + "개의 글을 삭제하시겠습니까?")) return false;

        var data = $("#frmList").serialize();
        // alert(data);    // uid=10&uid=20  

        $.ajax({
            url : ".",    // URL : /board
            type : "DELETE",
            data : data,
            cache : false,
            success : function(data, status){
                if(status == "success"){
                    if(data.status == "OK"){
                        alert("DELETE성공: " +   data.count + "개");
                        loadPage(window.page);  // 현재 페이지 목록 다시 로딩
                    } else {
                        alert("DELETE실패: " +  data.message);
                        return false;
                    }
                }
            }
        });
    } // end if

    return true;
} // end chkDelete()

// 특정 uid 의 글 삭제하기
function deleteUid(uid){
		
	if(!confirm(uid + "글을 삭제하시겠습니까?")) return false;
	
	// DELETE 방식
	$.ajax({
		url : ".",  // URL: /board
		type : "DELETE",
		data : "uid=" + uid,			
		cache : false,
		success : function(data, status){
			if(status == "success"){
				if(data.status == "OK"){						
					alert("DELETE성공 " + data.count + "개:");  // 설사 이미 지워져서 0개를 리턴해도 성공이다.
					loadPage(window.page);  // 현제페이지 로딩
				} else {
					alert("DELETE실패 " + data.message);
					return false;
				}
			}
		}
	});
	
	return true;
} // end deleteUid(uid)

// 글 수정 처리
function chkUpdate(){

    var data = $("#frmWrite").serialize();

    $.ajax({
        url : ".",   // URL : /board
        type : "PUT",
        cache : false,
        data : data,
        success : function(data, status){
            if(status == "success"){
                if(data.status == "OK"){
                    alert("UPDATE 성공 " + data.count + "개:" +  data.status);
                    loadPage(window.page);  // 현재페이지 리로딩
                } else {
                    alert("UPDATE 실패 " + data.status + " : " + data.message);
                }

                // 현재 팝업 닫기
                $("#dlg_write").hide();
            }
        }
    });


} // end chkUpdate();













