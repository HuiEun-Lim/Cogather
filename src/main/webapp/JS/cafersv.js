$(document).ready(function(){
	$('#apibtn').click(function(){
		$.ajax({
			url:'kakaopay',
			type: "GET",
			success:function(data){
				alertCode(data);
			}
		
		});
	});
	
});
					

function alertCode(jsonObj){
	var row = JSON.parse(jsonObj);
	var turl = row.next_redirect_pc_url;
	window.open(turl);
}