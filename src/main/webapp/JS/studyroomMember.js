//분리된 JS 파일에서 jstl 요소를 받을 수 없기에
// html 요소로 미리 필요한 정보를 숨겨두고 가져왔음 
var stompClient = null;
var contextPath = null;

var chk = 'abnormal';
var members = {}; // 타이머를 저장하기 위한 전역 변수 
var member_profiles = {};
$(document).ready(function() {
	//js와 html을 분리하기 위해 jstl과 el을 받아야 한다면 html 요소에 숨겨놓고 문서 완성시 그걸 읽어 오는 방식을 해봄
	// 이렇게 하지 않으면 분리된 javascript 파일은 제일 마지막에 컴파일 되므로 request에 있는 정보들을 받아올 수 없다. 
	setArgs();
	getMembers(); // 현제 db에 들어와있는 상태를 가진 유저들 목록을 표시하고 타이머 준비
	
	$("form").on('submit', function(e){
		e.preventDefault(); // submit 이벤트듣 이벤트 발생시 창이 새로고침되면서 실행되는데 이를 막아줌
	});
	
	$("#outroom").click(function(){
		$(window).off('beforeunload');
		chk = 'normal';
		outroom();	
	});
});




function connect() {
	var socket = new SockJS(contextPath+"/endpoint"); // WebSocketConfig에서 설정한 endpoint를 통해 Socket 생성
	
	stompClient = Stomp.over(socket); // 소켓으로 StompClient 생성
	console.log(stompClient);
	stompClient.connect({}, function(frame){
		console.log('Connected: ' + frame);
		stompClient.subscribe('/sub/message/'+sg_id,function(message){ // 생성된 StompClient로 구독 (SendTO로 설정했던 부분) - 첫 구독시에 아래의 함수가 실행되지 않음,
			showChat(JSON.parse(message.body)); // 구독이 성공하면 메시지가 해당 subscribe된 브로커에 저장되고 저장된 메시지가 있다면 이곳에서 매번 showChat 함수를 호출해줌(이벤트 등록같다.) 
		});	
		
		stompClient.send("/pub/chat/"+sg_id,{},JSON.stringify( // subscribe를 할 때 구독했다는 메시지를 보내기 위해( 채팅방에 입장했다는 메시지를 위해)  
		{														// MessageMapping된 핸들러로 메시지를 보내 브로커에 메시지를 저장
			'roomId': sg_id,'sender': id,'content': id+' 입장','type': 'JOIN'
		}));
	});
}

function showChat(msg){ // 메시지 타입에 따라 바꿔서 보여줌
	var t = new Date();
	var time_str = t.getHours()+":" +t.getMinutes();
	if(msg.type == 'JOIN'){
		$('#msgArea').append(
			"<li class='chat chat-center''> "+ msg.sender+" 님이 들어왔습니다. </li>"+
			"<div class='clear-both'></div>"
		);
		
		//
		if(members[msg.sender] != null){
			clearInterval(members[msg.sender]['timerId']); // 나가는 사람의 타이머 종료
			clearInterval(members[msg.sender]['acc']); // 나가는 사람의 1분 간격 타이머 저장 종료
			delete members[msg.sender]; // 유저의 타이머 정보를 관리하는 부분에서 해당 유저 삭제	
		}
		// 새로운 사용자가 들어오면 사용자 목록 업데이트 하기
		getMembers();
	}else if(msg.type == 'TALK'){
		if(id == msg.sender){
			$('#msgArea').append(
			"<li class='chat chat-right'> "+ 
				"<div class='chat-sender-info'>"+
					"<img class= 'chat-sender-img' src='"+contextPath+"/"+member_profiles[id].pimg_url+"'>"+
					"<span>"+msg.sender+"</span>"+
				"</div>"+
				"<div class= 'chat-content-box'>"+
					"<div class='chat-content'>" +msg.content+"</div>"+	
					"<div class='chat-time'>"+time_str+"</div>"+
				"</div>"+
			"</li>"+
			"<div class='clear-both'></div>"
			);	
		}else{
			$('#msgArea').append(
			"<li class='chat chat-left'> "+
				"<div class='chat-sender-info'>"+
					"<img class= 'chat-sender-img' src='"+contextPath+"/"+member_profiles[id].pimg_url+"'>"+
					"<span>"+msg.sender+"</span>"+
				"</div>"+
				"<div class= 'chat-content-box'>"+
					"<div class='chat-content'>" +msg.content+"</div>"+	
					"<div class='chat-time'>"+time_str+"</div>"+
				"</div>"+
			"</li>"+
			"<div class='clear-both'></div>"
			);
		}
		
	}else if(msg.type = 'LEAVE'){
		$('#msgArea').append(
			"<li class='chat chat-center'> "+ msg.sender+" 님이 나갔습니다. </li>"+
			"<div class='clear-both'></div>"
		);
		if(members[msg.sender] != null){
			clearInterval(members[msg.sender]['timerId']); // 나가는 사람의 타이머 종료
			clearInterval(members[msg.sender]['acc']); // 나가는 사람의 1분 간격 타이머 저장 종료
			delete members[msg.sender]; // 유저의 타이머 정보를 관리하는 부분에서 해당 유저 삭제	
		}
//		getMembers();
		setTimeout(getMembers,1000);
		// 퇴장시 subscriber들이 해당 메시지를 받으면 멤버 리스트를 업데이트함
		// 바로 업데이트 하지 않는 이유는 해당멤버의 입출 상태가 메시지 전달 보다 먼저 발생되게 되어 있음
	}
	$('.chatting-section').scrollTop($('.chatting-section').prop('scrollHeight'));
}

function sendChat(){ // 메시지 보내기
	var msg =$('textarea#message-input').val().trim();
	msg = msg.replace(/(?:\r\n|\r|\n)/g, '<br />');
	if( msg == ''){
		console.log('빈칸임');
	}else{
		stompClient.send("/pub/chat/"+sg_id,{},JSON.stringify({
		'type':'TALK',
		'roomId': sg_id,
		'sender': id,
		'content': msg
		}));	
	}
	
}

function disconnect(){ // stompClient 종료하기전 메시지 보내고 죽음
	if(stompClient != null){
		stompClient.send("/pub/chat/"+sg_id,{},JSON.stringify({
		'type':'LEAVE',
		'roomId': sg_id,
		'sender': id
		}));
		
		stompClient.disconnect();
	}
	console.log(id+"의 메시지 전송 소켓 종료");
	return true;
}
function formSend(){ 
	sendChat();
	$('form#sendMessage textarea').val(''); // 메시지보내고 나서 inputbox 비우기
	
}


// 스터디에 참여하고 있는 멤버들 데이터를 가져옴
function getMembers() {
	$.ajax({
		url: contextPath+"/group/MemberStudyRest/ms/" + sg_id,
		type: "GET",
		cache: false,
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if (status == "success") {
				var background = data['study'][0]['file_name'];
				$("body").css({'background-image':"url(../img/group/upload/"+background+")"});
				updateMembers(data);
				
				for(var i = 0; i<data['mdata'].length;i++){
					member_profiles[data['mdata'][i].id] = data['mdata'][i];
				}
			}
		}
	});
}



// json 데이터로 받은 유저 목록을 표시
function updateMembers(jsonObj) {
	var result = "" // 결과
	var userId = id;
	var msData = jsonObj['msdata'];
	var mData = jsonObj['mdata'];
	var check = false;

	if (jsonObj.status == "OK") {
		for (var i = 0; i < msData.length; i++) {
			if (msData[i].id == userId) {
				check = true;
				if(stompClient == null){
					connect();
				}
				if (members[msData[i].id] == null) {
					setTimer(msData[i].entime, msData[i].id);
				}
				result += 
					"<h2 class='left-title'>스터디원</h2>"+
					"<h3 class='left-title-sub'>나<h3>"+
					"<div class='me' id='"+msData[i].id+"-user'>" +
					"<img class='pimg' src='"+contextPath+"/" + mData[i].pimg_url + "'>" +
					"<div class='userName'> " + msData[i].id + " </div>" +
					"<div class='timer-title' id='timer-" + msData[i].id + "'> 타이머" + "<h3>" + members[msData[i].id]['time'] + "</h3>" + "</div>" +
					"</div>"
					;
					
				var writer = "";
				writer += "<img src='"+contextPath+"/"+mData[i].pimg_url+"'>";
				writer += "<div>"+msData[i].id+"</div>";
				$(".comment-writer-info").html(writer);
				
				break;
			}

		}
		if (check == false) {
			outroom();
		}else{
			for (var i = 0; i < msData.length; i++) {
				if (msData[i].id != userId) {
					if (members[msData[i].id] == null) {
						setTimer(msData[i].entime, msData[i].id);
					}
					result = result +
						"<div class='other-member'>" +
						"<img class='pimg' src='/cogather/" + mData[i].pimg_url + "'>" +
						"<div> " + msData[i].id + " </div>" +
						"<div class='timer-title' id='timer-" + msData[i].id + "'> 타이머" + "<h3>" + members[msData[i].id]['time'] + "</h3>" + "</div>" +
						"</div>"
						;
				}
			}	
		}
		
		$("#enter-cnt").html(msData.length + " 명");
		$(".user-list").html(result);
		
	} 
	else {
		outroom();
	}
}
// 기본 타이머 세팅 1초마다 업데이트
function setTimer(time, userId) {
	var timer = {};
	var date = time.split(' ');
	var time = date[1].split(':');
	date = date[0].split('-');
	timer['timerId'] = setInterval("calTime()", 1000);
	timer['entime'] = new Date(date[0], date[1] - 1, date[2], time[0], time[1], time[2]);
	timer['time'] = '0:0:0';
	if(id == userId){
		timer['acc'] = setInterval("storeAcctime()",60000);
	}
	members[userId] = timer;
}
// 입장시간과 현재 시간의 차이를 계산하는 함수
function calTime() {
	var now = new Date();
	for (var i in members) {
		var sub = now - members[i]['entime']
		var hour = Math.floor((sub % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
		var minute = Math.floor((sub % (1000 * 60 * 60)) / (1000 * 60));
		var second = Math.floor((sub % (1000 * 60)) / 1000);
		var strTime = hour + ":" + minute + ":" + second;
		members[i]['time'] = strTime;
	}

	updateTime();
}
// 각 유저별 타이머를 업데이트 하는 함수
function updateTime() {
	for (var i in members) {
		$("div#timer-" + i + " h3").text(members[i]['time']);
	}
}
// 방나가기
function outroom() {
	if(chk == 'normal'){// 정상 종료
		location.href='../group/studyview?sg_id='+sg_id;	
	}else{ // chk abnormal 비정상 종료 - 새로고침, 뒤로가기, 브라우저 종료
		const XHR =new XMLHttpRequest();
		var form = new FormData();
		form.append('sg_id',sg_id);
		form.append('id',id);
		form.append('_csrf', token);
		
		XHR.open('POST', contextPath+'/group/roomenterOk'); // 어디로 보낼지
		XHR.send(form); // 데이터 싣고 출발
		
		XHR.addEventListener('load', function(event){ // form 제출 성공시
			console.log('새로 접속');
			getMembers();
		});
		
		XHR.addEventListener('error', function(event){ // form 제출 실패시
			console.log('접속 실패');
		})	
	}
}
// 타이머 시간 누적시간으로 저장 요청
function storeAcctime() {
	var temp = members[id]['time'].split(':');
	var time = new Date(Date.UTC(0, 0, 1, temp[0], temp[1], temp[2]));
	$.ajax({
		url: "./MemberStudyRest/ms/acctime",
		type: "PUT",
		data: "sg_id=" + sg_id + "&id=" + id + "&acctime=" + time.toISOString(),
		cache: false,
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if (status == "success") {
				if (data.status == "OK") {
					console.log("1분 마다 누적시간 저장 완료");
				} else {
				}
			}
		}
	});
}