$(document).ready(function(){
	$('#apibtn').click(function(){
		$.ajax({
			url:'kakaopay',
			type: "GET",
			success:function(data){
				payrsvkkao(data);
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
				

function payrsvkkao(jsonObj){
	var row = JSON.parse(jsonObj);
	var turl = row.next_redirect_pc_url;
	window.open(turl);
	
}
