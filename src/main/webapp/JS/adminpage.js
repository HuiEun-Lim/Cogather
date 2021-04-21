var monthsale = []; //월 매출
var total = 0; //총 매출
var adminDates;
var thismonth = new Date().getMonth();
var thiscnt = 0;
$(document).ready(function(){
		$.ajax({
			url:"adminResult",
			type:"GET",
			cache:false,
			async:false,
			success:function(data, status){
				if(status == "success"){
					if(data.status == "success"){
						adminDates = data;
						drawChart(data);
						todayrsvs(data);
					}
				}
			}
		})
		function drawChart(data){ //월별 매출 가져오는 함수
			for(var m=0; m < 12; m++){
				monthsale[m] = 0;
			for(var i = 0; i < data['adminrsvs'].length;i++){
				var startRSV = to_date2(data['adminrsvs'][i].start_date);
				var endRSV = to_date2(data['adminrsvs'][i].end_date);
				var month = startRSV.getMonth();
				if(month == m){
					var sales =((endRSV.getTime() - startRSV.getTime()) / 1000 / 60 / 60) * data['adminrsvs'][i].seat_price;
					monthsale[m] += sales;
					total += sales;
					if(month == thismonth) thiscnt++;
				}
			}
			monthsale[m] = Math.floor(monthsale[m]/100) * 100;
			total = Math.floor(total/100) * 100;
			}
		}
		
		monthsale[0] = 100000; monthsale[1] = 2000000;
		monthsale[2] = 100200;
		monthsale[4] = 150000; monthsale[5] = 1000000;
		monthsale[6] = 600000; monthsale[7] = 2030000;
		monthsale[8] = 120300; monthsale[9] = 3020100;
		monthsale[10] = 90000; monthsale[11] = 980000;
		
		$('#totalsales').html(total.toLocaleString()+"원");
		$('#totalcnt').html(adminDates.cnt+"건");
		$('#thismonthsales').html(monthsale[thismonth].toLocaleString()+"원");
		$('#thismonthcnt').html(thiscnt+"건");

	});
	function to_date2(date_str){ //날짜 바꿔주는 함수
	    var yyyyMMdd = String(date_str);
	    var sYear = yyyyMMdd.substring(0,4);
	    var sMonth = yyyyMMdd.substring(5,7);
	    var sDate = yyyyMMdd.substring(8,10);
	    var sHour = yyyyMMdd.substring(11,13);
	    var sMin = yyyyMMdd.substring(14,16);
	
	    return new Date(Number(sYear), Number(sMonth)-1, Number(sDate), Number(sHour), Number(sMin));
	}
	

document.addEventListener("DOMContentLoaded", function () { //월별매출 차트
			var ctx = document.getElementById("chartjs-dashboard-line").getContext("2d");
			var gradient = ctx.createLinearGradient(0, 0, 0, 225);
			gradient.addColorStop(0, "rgba(215, 227, 244, 1)");
			gradient.addColorStop(1, "rgba(215, 227, 244, 0)");			
			// Line chart
			new Chart(document.getElementById("chartjs-dashboard-line"), {
				type: "line",
				data: {
					labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월",
						"12월"
					],
					datasets: [{
						label: "월매출",
						fill: true,
						backgroundColor: gradient,
						borderColor: window.theme.primary,
						data: monthsale
					}]
				},
				options: {
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					tooltips: {
						intersect: false
					},
					hover: {
						intersect: true
					},
					plugins: {
						filler: {
							propagate: false
						}
					},
					scales: {
						xAxes: [{
							reverse: true,
							gridLines: {
								color: "rgba(0,0,0,0.0)"
							}
						}],
						yAxes: [{
							ticks: {
								stepSize: 10000
								},	
							display: true,
							borderDash: [3, 3],
							gridLines: {
								color: "rgba(0,0,0,0.0)"
							}
						}]
					}
				}
			});
		});	

function todayrsvs(data){
	var result="";
	var today = new Date();
	var todayfmt = to_date(today);
	for(var i=0; i<data['adminrsvs'].length; i++){
		var startfmt = to_date3(data['adminrsvs'][i].start_date);
		if(todayfmt.getTime() == startfmt.getTime()){
			result += "<tr><td>"+data['adminrsvs'][i].res_id;
			result += "</td><td class='d-md-table-cell'>"+data['adminrsvs'][i].seat_id;
			result += "</td><td class='d-xl-table-cell'>"+data['adminrsvs'][i].id;
			result += "</td><td class='d-none d-xl-table-cell'>"+data['adminrsvs'][i].start_date;
			result += "</td><td class='d-none d-xl-table-cell'>"+data['adminrsvs'][i].end_date;
			result += "</td><td class='d-none d-md-table-cell'>"+data['adminrsvs'][i].payment;
		}
	}
	$('#todayrsvtable tbody').html(result);
}

function to_date(tdate){ //오늘 날짜 바꿔주는 함수
		var tdd = tdate.getDate();
		var tmm = tdate.getMonth();
		var tyy = tdate.getFullYear();
		if(tdd<10){
			tdd = '0' + tdd;
		}
		if(tmm<10){
			tmm = '0' + tmm;
		}
		tdate = new Date(Number(tyy),Number(tmm),Number(tdd));
	    return tdate;
	}
	
function to_date3(date_str){ //날짜 바꿔주는 함수
	    var yyyyMMdd = String(date_str);
	    var sYear = yyyyMMdd.substring(0,4);
	    var sMonth = yyyyMMdd.substring(5,7);
	    var sDate = yyyyMMdd.substring(8,10);
	
	    return new Date(Number(sYear), Number(sMonth)-1, Number(sDate));
	}
function chkDelete(res_id){
	// 삭제 여부, 다시 확인 하고 진행하기
	var r = confirm(res_id+"해당 예약을 취소하시겠습니까?");
	
	if(r){
		location.href = 'deleteOk.do?res_id=' + res_id;
	}
}