var username = null;
var roomId = null;
var stompClient = null;
var contextPath = null;


function connect() {
	var socket = new SockJS("/cogather/endpoint");
	
	stompClient = Stomp.over(socket);
	console.log(stompClient);
	stompClient.connect({}, function(frame){
		console.log('Connected: ' + frame);
		stompClient.subscribe('/sub/message/'+roomId,function(message){
			showChat(JSON.parse(message.body));
		});	
		
		stompClient.send("/pub/chat/"+roomId,{},JSON.stringify(
		{
			'roomId': roomId,'sender': username,'content': username+' 입장','type': 'JOIN'
		}));
	});
}

function showChat(msg){
	if(msg.type == 'JOIN'){
		$('#msgArea').append(
			"<li class='chat chat-center''> "+ msg.sender+" 입장 </li>"+
			"<div class='clear-both'></div>"
		);
		// 사용자 목록 업데이트 하기
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
	}
}

function sendChat(){
	stompClient.send("/pub/chat/"+roomId,{},JSON.stringify({
		'type':'TALK',
		'roomId': roomId,
		'sender': username,
		'content': $('form#sendMessage input').val()
	}));
}

function disconnect(){
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
		$('form#sendMessage input').val('');
	});
	
    window.BeforeUnloadEvent = function(){
		alert("unload");
        disconnect();
		outroom();
    }
});
