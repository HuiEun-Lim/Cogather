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
	Date.prototype.startmin = function(){
		var yyyy = this.getFullYear().toString();
		var mm = (this.getMonth() + 1).toString();
		var dd = this.getDate().toString();
		
		return yyyy+'-' + (mm[1]?mm:'0'+mm[0])+'-'+(dd[1]?dd:'0'+dd[0]);
	};
	
	Date.prototype.startmax = function(){
		var yyyy = this.getFullYear().toString();
		var mm = (this.getMonth() + 7).toString();
		var dd = this.getDate().toString();
		
		return yyyy+'-' + (mm[1]?mm:'0'+mm[0])+'-'+(dd[1]?dd:'0'+dd[0]);}
		
	var s = new Date();
	var smin = (s.startmin()) + 'T'+s.getHours() +':'+ s.getMinutes();
	var smax = (s.startmax()) + 'T'+s.getHours() +':'+ s.getMinutes();
	
	
	document.getElementById("startdate").setAttribute("max", smax);
	document.getElementById("startdate").setAttribute("min", smin);
	
	Date.prototype.endmin = function(){
		var yyyy = this.getFullYear().toString();
		var mm = (this.getMonth() + 1).toString();
		var dd = this.getDate().toString();
		
		return yyyy+'-' + (mm[1]?mm:'0'+mm[0])+'-'+(dd[1]?dd:'0'+dd[0]);
	};
	
	Date.prototype.endmax = function(){
		var yyyy = this.getFullYear().toString();
		var mm = (this.getMonth() + 7).toString();
		var dd = this.getDate().toString();
		
		return yyyy+'-' + (mm[1]?mm:'0'+mm[0])+'-'+(dd[1]?dd:'0'+dd[0]);}
	var e = new Date();
	var emin = ((new Date).endmin()) + 'T'+(e.getHours()+1) +':'+ e.getMinutes();
	var emax = ((new Date).endmax()) + 'T'+(e.getHours()+1) +':'+ e.getMinutes();
	
	
	document.getElementById("enddate").setAttribute("max", emax);
	document.getElementById("enddate").setAttribute("min", emin);
});
					

function alertCode(jsonObj){
	var row = JSON.parse(jsonObj);
	var turl = row.next_redirect_pc_url;
	window.open(turl);
}

var ifcheck = true;

function chkSubmit(){
	frm = document.forms['frm'];
	
	var seatid = frm['seat_id'].value.trim();
	var startd = new Date(frm['startdate'].value.trim());
	var endd = new Date(frm['enddate'].value.trim());

	if(seatid == ""){
		alert("좌석을 반드시 선택해야합니다.");
		return false;
		
	}
	
	for(var i=0; i<seatdates['chkdates'].length;i++){
		var startRSV = to_date2(seatdates['chkdates'][i].start_date);
		var endRSV = to_date2(seatdates['chkdates'][i].end_date);
		
		if(startRSV.getTime()-startd.getTime() <= 0 && endRSV.getTime()-startd.getTime() >=0){
			ifcheck = false;
		}
		
		else if(startRSV.getTime()-endd.getTime() <= 0 && endRSV.getTime()-endd.getTime() >= 0){
			ifcheck = false;
		}
	}
	
	if(ifcheck == false){
		alert("이미 예약된 좌석입니다");
		return false;
	}
}

function to_date2(date_str)
{
    var yyyyMMdd = String(date_str);
    var sYear = yyyyMMdd.substring(0,4);
    var sMonth = yyyyMMdd.substring(5,7);
    var sDate = yyyyMMdd.substring(8,10);
    var sHour = yyyyMMdd.substring(11,13);
    var sMin = yyyyMMdd.substring(14,16);

    return new Date(Number(sYear), Number(sMonth)-1, Number(sDate), Number(sHour), Number(sMin));
}
