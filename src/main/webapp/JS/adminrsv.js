$(document).ready(function(){});

function chkDelete(res_id){
	// 삭제 여부, 다시 확인 하고 진행하기
	var r = confirm("삭제하시겠습니까?");
	
	if(r){
		location.href = 'deleteOk.do?res_id=' + res_id;
	}
}