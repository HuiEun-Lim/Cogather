
members = {}; // 타이머를 저장하기 위한 전역 변수 

$(function() {
	//js와 html을 분리하기 위해 jstl과 el을 받아야 한다면 html 요소에 숨겨놓고 문서 완성시 그걸 읽어 오는 방식을 해봄
	// 이렇게 하지 않으면 분리된 javascript 파일은 제일 마지막에 컴파일 되므로 request에 있는 정보들을 받아올 수 없다. 
	sg_id = $('#sg_id').text();
	id = $('#id').text();
	contextPath = $("#contextPath").text();;
	getMembers(); // 현제 db에 들어와있는 상태를 가진 유저들 목록을 표시하고 타이머 준비
});
// 스터디에 참여하고 있는 멤버들 데이터를 가져옴
function getMembers() {
	$.ajax({
		url: "./MemberStudyRest/ms/" + sg_id,
		type: "GET",
		cache: false,
		success: function(data, status) {
			if (status == "success") {
				updateMembers(data);
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
				console.log("test1:" + msData.length);
				if (members[msData[i].id] == null) {
					setTimer(msData[i].entime, msData[i].id);
				}
				result = result +
					"<div>" +
					"<img class='pimg' src='/cogather/" + mData[i].pimg_url + "'>" +
					"<div class='userName'> " + msData[i].id + " </div>" +
					"<div id='timer-" + msData[i].id + "'> 타이머:" + "<h3>" + members[msData[i].id]['time'] + "</h3>" + "</div>" +
					"</div>";
				break;
			}

		}
		if (check == false) {
			alert("퇴실 상태 입니다. 다시 들어와주십시오");
			outroom();
		}
		for (var i = 0; i < msData.length; i++) {
			if (msData[i].id != userId) {
				console.log("test2: " + msData.length);
				if (members[msData[i].id] == null) {
					setTimer(msData[i].entime, msData[i].id);
				}
				result = result +
					"<div>" +
					"<img class='pimg' src='/cogather/" + mData[i].pimg_url + "'>" +
					"<div> " + msData[i].id + " </div>" +
					"<div id='timer-" + msData[i].id + "'> 타이머:" + "<h3>" + members[msData[i].id]['time'] + "</h3>" + "</div>" +
					"</div>"
					;
			}
		}
		$("#enter-cnt").html(msData.length + " 명");
		$("div.left .user-list").html(result);
		return true;
	} else {
		alert("아무도 방에 들어오지 않았음");
		history.back();
		return false;
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
// 방나가기 - 타이머 시간을 누적시간으로 변환 
function outroom() {
	$.ajax({
		url: "./MemberStudyRest/ms/roomoutOk?sg_id=" + sg_id + "&id=" +id,
		type: "GET",
		cache: false,
		success: function(data, status) {
			if (status == "success") {

				var temp = members[id]['time'].split(':');
				var time = new Date(2021, 0, 2, temp[0], temp[1], temp[2]);
				storeAcctime(time);
				clearInterval(members[id]['timerId']);
				delete members[id];
				disconnect();
				location.href = contextPath + "/group/studygroup";
			}
		}
	});






}
// 타이머 시간 누적시간으로 저장 요청
function storeAcctime(time) {

	$.ajax({
		url: "./MemberStudyRest/ms/acctime",
		type: "PUT",
		data: "sg_id=" + sg_id + "&id=" + id + "&acctime=" + time.toISOString(),
		cache: false,
		success: function(data, status) {
			if (status == "success") {
				if (data.status == "OK") {
					alert("누적시간 저장 성공");
				}
			}
		}
	});
}