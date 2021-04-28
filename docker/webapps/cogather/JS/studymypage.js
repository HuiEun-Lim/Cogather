$(function(){
	setArgs();
	loadStudys();
});

function loadStudys(){
	$.ajax({
        url : "../group/myPage/"+id+"?_csrf="+token,
        type : "GET",
        cache : false,
        success : function(data, status){
            if(status == "success"){						
            	viewStudyList(data);
				console.log("데이터 가져오기 성공");
			}else{
				viewStudyList(data);
				console.log("fail");
			}
		}
    });  // end $.ajax()
}

function viewStudyList(data){
	var result = "";
	result += '<div class="hero-slides owl-carousel">';
	if(data != null){
		for(var i = 0; i<data.cnt; i++){
		var time = calcAccTime(data['ms'][i]['acctime']);
		var strTime = "";
		if(time[0] != 0){
			strTime += time[0] +"일 "
		}
		strTime += time[1] + "시간 "+ time[2] + "분";
		
		result += "<div class='single-hero-slide bg-img' style='background-image: url("+"../img/group/upload/"+data['data'][i]['file_name']+");'>";
		result += "	<div class='container h-100'>";	
        result += " 	<div class='row h-100 align-items-center'>";    
        result += "			<div class='col-12'>" ;           
        result += '				<div class="slide-content text-center">';
        result += '					<div class="post-tag">';
		result += '						<a href="#" data-animation="fadeInUp">'+'스터디 '+(i+1)+'</a>';                                                                        
        result += '					</div>';
		result += '					<h2 data-animation="fadeInUp" data-delay="250ms"><a class="mypage-list-txt" href="../group/studyview?sg_id='+data['data'][i]['sg_id']+'">'+data['data'][i]['sg_name']+'</a></h2>';
		result += '					<h3 class="acctime-view mypage-list-txt" data-animation="fadeInUp" data-delay="250ms">누적 공부 시간 '+strTime+'</h3>';
		result += '				</div>';                                
		result += '			</div>';                                
		result += '		</div>';                                
		result += '	</div>';                                
		result += '</div>';                                
		}
	}
	result += "<div class='single-hero-slide bg-img' style='background-image: url(../img/group/plus-background.png);'>";
	result += "	<div class='container h-100'>";	
    result += " 	<div class='row h-100 align-items-center'>";    
    result += "			<div class='col-12'>" ;           
    result += '				<div class="slide-content text-center">';
	result += '					<h2 data-animation="fadeInUp" data-delay="250ms"><a href="../group/studylist">스터디를 신청하세요</a></h2>';
	result += '				</div>';                                
	result += '			</div>';                                
	result += '		</div>';                                
	result += '	</div>';                                
	result += '</div>'; 
	result+= '</div>';
	
	$(".hero-area").html(result);
	banner_active();
}

function calcAccTime(acctime){
	var baseTime = new Date(Date.UTC(0,0,1,0,0,0));
	var temp = null;
	var temp_date = null;
	var temp_time = null;
	if(acctime != null){
		var temp = acctime.split(' ');
		var temp_date = temp[0].split('-');
		var temp_time = temp[1].split(':');	
	}else{
		temp_date = [0,1,1];
		temp_time = [0,0,0]
	}
	
	var acctime = new Date(Date.UTC(0,temp_date[1] -1,temp_date[2],temp_time[0], temp_time[1],temp_time[2]));
	var sub = acctime - baseTime;
	var day = parseInt(sub / (24 * 60 * 60 * 1000));
	var hour = Math.floor((sub % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	var minute = Math.floor((sub % (1000 * 60 * 60)) / (1000 * 60));
	var second = Math.floor((sub % (1000 * 60)) / 1000);
//	var strTime = day+"일 " + hour + ":" + minute + ":" + second;
	
	var result = [day, hour, minute];
	return result;
}