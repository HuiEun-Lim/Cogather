//분리된 JS 파일에서 jstl 요소를 받을 수 없기에
// html 요소로 미리 필요한 정보를 숨겨두고 가져왔음 
var username = null;
var roomId = null;
var stompClient = null;
var contextPath = null;


function connect() {
	var socket = new SockJS(contextPath+"/endpoint"); // WebSocketConfig에서 설정한 endpoint를 통해 Socket 생성
	
	stompClient = Stomp.over(socket); // 소켓으로 StompClient 생성
	console.log(stompClient);
	stompClient.connect({}, function(frame){
		console.log('Connected: ' + frame);
		stompClient.subscribe('/sub/message/'+roomId,function(message){ // 생성된 StompClient로 구독 (SendTO로 설정했던 부분) - 첫 구독시에 아래의 함수가 실행되지 않음,
			showChat(JSON.parse(message.body)); // 구독이 성공하면 메시지가 해당 subscribe된 브로커에 저장되고 저장된 메시지가 있다면 이곳에서 매번 showChat 함수를 호출해줌(이벤트 등록같다.) 
		});	
		
		stompClient.send("/pub/chat/"+roomId,{},JSON.stringify( // subscribe를 할 때 구독했다는 메시지를 보내기 위해( 채팅방에 입장했다는 메시지를 위해)  
		{														// MessageMapping된 핸들러로 메시지를 보내 브로커에 메시지를 저장
			'roomId': roomId,'sender': username,'content': username+' 입장','type': 'JOIN'
		}));
	});
}

function showChat(msg){ // 메시지 타입에 따라 바꿔서 보여줌
	if(msg.type == 'JOIN'){
		$('#msgArea').append(
			"<li class='chat chat-center''> "+ msg.sender+" 입장 </li>"+
			"<div class='clear-both'></div>"
		);
		// 새로운 사용자가 들어오면 사용자 목록 업데이트 하기
		getMembers();
	}else if(msg.type == 'TALK'){
		if(username == msg.sender){
			$('#msgArea').append(
			"<li class='chat chat-right'> "+ msg.sender+" : "+ msg.content+"</li>"+
			"<div class='clear-both'></div>"
			);	
		}else{
			$('#msgArea').append(
			"<li class='chat chat-left'> "+ msg.sender+" : "+ msg.content+"</li>"+
			"<div class='clear-both'></div>"
			);
		}
		
	}else if(msg.type = 'LEAVE'){
		$('#msgArea').append(
			"<li class='chat chat-center'> "+ msg.sender+" 퇴장 </li>"+
			"<div class='clear-both'></div>"
		);
		getMembers(); // 퇴장시 subscriber들이 해당 메시지를 받으면 멤버 리스트를 업데이트함
	}
}

function sendChat(){ // 메시지 보내기
	stompClient.send("/pub/chat/"+roomId,{},JSON.stringify({
		'type':'TALK',
		'roomId': roomId,
		'sender': username,
		'content': $('form#sendMessage input').val()
	}));
}

function disconnect(){ // stompClient 종료하기전 메시지 보내고 죽음
	stompClient.send("/pub/chat/"+roomId,{},JSON.stringify({
		'type':'LEAVE',
		'roomId': roomId,
		'sender': username
	}));
	if(stompClient !== null){
		stompClient.disconnect();
	}
	console.log(username+"의 메시지 전송 소켓 종료");
}

$(function() {
	username = $("#id").text(); 
	roomId = $("#sg_id").text();
	contextPath = $("#contextPath").text();
	connect();
	
	
	$("form").on('submit', function(e){
		e.preventDefault();
	});
	
	$("form#sendMessage button").click(function(){ 
		sendChat();
		$('form#sendMessage input').val(''); // 메시지보내고 나서 inputbox 비우기
	});
	
    window.BeforeUnloadEvent = function(){
        disconnect();
		outroom(); // 다른 js 파일의 함수 불러옴 - studyroomMemeber.js의 방을 나갈시 호출하는 함수
    }
});
