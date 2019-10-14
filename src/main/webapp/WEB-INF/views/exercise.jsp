<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Input_Exercise</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap" rel="stylesheet">
<style>
@font-face { font-family: 'GoodFont'; /* 폰트 패밀리 이름 주기*/ 
          src: url('resources/fonts/851Gkktt_004.ttf'); /*폰트 파일 주소*/ }
@font-face { font-family: 'jua'; /* 폰트 패밀리 이름 주기*/ 
          src: url('resources/fonts/BMJUA_ttf.ttf'); /*폰트 파일 주소*/ }
pre{ 
   font-family:'GoodFont' !important; }
.canvas-container {
	position: relative;
}

#myCanvas {
	position: absolute;
}

input{
position: absolute;
margin-top :422px;
margin-left: 122px;
padding: .8em .18em; 
font-family: 'Press Start 2P',GoodFont;
outline-style: none; /* 포커스시 발생하는 효과 제거를 원한다면 */ 
-webkit-appearance: none; /* 브라우저별 기본 스타일링 제거 */ 
-moz-appearance: none; 
appearance: none;
}

#btn1{
position: absolute;
margin-left: 340px;
margin-top :410px;
}

#btn2{
position: absolute;
margin-left: 400px;
margin-top :410px;
}
#btn3{
position: absolute;
margin-left: 250px;
margin-top :410px;
}
#btn1:hover, #btn2:hover, #exerciseimg:hover {
  -webkit-transform: translateY(-5px);
          transform: translateY(-5px);
  -webkit-transition: all 100ms ease-in;
  transition: all 100ms ease-in;
  box-shadow: 0 5px 10px rgba(51, 51, 51, 0.4);
}
#btn1:focus, #btn2:focus, #exerciseimg:focus {
  outline: 0;
}
#btn1:active, #btn2:active, #exerciseimg:active {
  -webkit-transform: translateY(-3px);
          transform: translateY(-3px);
}  
#kname{
font-size: 9px;
}

.sports{
position: absolute;
overflow: auto;
width: 360px;
height: 280px;
margin-left: 90px;
margin-top :80px;
font-family: 'Press Start 2P',jua;
}

.sports2{
position: absolute;
overflow: auto;
width: 175px;
height: 230px;
margin-left: 520px;
margin-top :135px;
font-family: 'Press Start 2P',jua;

}
.sports3{
position: absolute;
overflow: auto;
width: 150px;
height: 230px;
margin-left: 680px;
margin-top :135px;
font-family: 'Press Start 2P',jua;

}

#name{
font-size: 10px;
color: yellow;
}

#kcal{
font-size: 11px;
color: rgb(254,224,72);
}

.title{
position: absolute;
margin-left: 540px;
margin-top :50px;
font-family: 'Press Start 2P',jua;
font-size: 30px;
color: rgb(254,224,72);
}

.totalkcal{
	position: absolute;
	margin-left: 560px;
	margin-top :400px;
	font-family: 'Press Start 2P',jua;
	font-size: 14px;
	color: rgb(254,224,72);
}
#totalkalr{
	position: absolute;
	margin-left: 560px;
	margin-top :410px;
	font-family: 'Press Start 2P',jua;
	font-size: 14px;
	color: rgb(254,224,72);
}
.center{ 
	width: 1500px;
	height:720px;
	background-color: black;
}
.center-1{
	width: 1000px;
	height:580px;
	padding-top : 100px;
	margin-left: 300px;
}
.inpute{
	margin-top: -20px;
	margin-left: 10px;
    outline-style: none; /* 포커스시 발생하는 효과 제거를 원한다면 */
   -webkit-appearance: none; /* 브라우저별 기본 스타일링 제거 */
   -moz-appearance: none;
   appearance: none;
   display: inline;
   outline: none;
   border: 4px solid rgb(225, 210, 73);
   border-radius: 8px;
   width: 40px;
}
#inpute1{
	margin-top: 10px;
	margin-left: 60px;
}
#scrollstyle::-webkit-scrollbar-track {
   -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
   border-radius: 10px;
   background-color: #fee0480;
}

#scrollstyle::-webkit-scrollbar {
   width: 10px;
   background-color: #fee0480;
}

#scrollstyle::-webkit-scrollbar-thumb {
   background-color: #feda48;
   border: 2px solid #555555;
   border-radius: 20pdx;
}

#scrollstyle::-webkit-scrollbar-corner {
   background-color: #606060;
}


</style>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	mydiaryexercise();
	totalkcal();
	$.ajax({
		type : 'GET',
		url : 'showexercise', 
		success : exercisescreen
	})
})
function totalkcal(){
	var tag =''; 
	$.ajax({
		type : 'GET', 
		url : 'exertime1', 
		success : function(resp){
			tag ='total: '+resp+'kcal'
			$("#totalkalr").html(tag);
		}
	})
}
function mydiaryexercise(){
	$.ajax({
		type : 'GET',
		url : 'exertime2', 
		success : function(resp){
			var tag =''; 
			$.each(resp,function(index,item){
				tag += '<tr>'; 
				tag += '<td><a href="#" onclick="exerdelete('+item.exernum+')"><img  id="exerciseimg" src="'+item.originalfile+'" width="64" height="64"></a></td></tr>';
				tag += '<tr><td id="kname">'+item.exername+'</td></tr>'
				tag +='<tr><td id ="kcal">&nbsp;'+item.totaltime+'min</td></tr>'
				//total +=item.cal
			})
			$("#myexercise").html(tag);
			totalkcal();
		}
	})
}
function exercisescreen(resp){
	var tag = ''; 
	
	$.each(resp,function(index,item){
		tag += '<tr>'; 
		tag += '<td><a href="#" onclick="exerinsert('+item.exernum+')"><img  id="exerciseimg" src="'+item.originalfile+'" width="64" height="64"></a></td>';
		tag += '<td id ="kcal">&nbsp;'+item.calburn+'kcal</td></tr>'
		tag += '<tr><td id="kname">'+item.exername+'</td>'
	    tag += '</tr>'
	   })
	$("#showexercise").html(tag);
}

function searchexercise(){
	var exername = $("#exername").val(); 

	$.ajax({
		type : 'POST', 
		data : "exername="+exername, 
		url:'searchexer',
		success: exercisescreen
	})
}
function exerinsert(exernum){
	var exernum = exernum 
	
	$.ajax({
		type : 'POST', 
		data : "exernum="+exernum, 
		url : 'exerinsert', 
		success : mydiary
	})
}
function mydiary(){
		
	$.ajax({
		type : 'POST',  
		url : 'myexercisediary', 
		success : function(resp){
			var tag = '';
			var tag2 = '';
			var total = 0; 
			var totalkcal = ''; 
				
			$.each(resp,function(index,item){
				tag += '<tr>'; 
				tag += '<td><a href="#" onclick="exerdelete('+item.exernum+')"><img id="exerciseimg" src="'+item.originalfile+'" width="64" height="64"></a></td>';
				tag += '<td id="kname">'+item.exername+'</td>'
				//tag +='<td id ="kcal">&nbsp;'+item.cal+'kcal</td>'
				tag += '</tr>'
				//total +=item.cal;
				tag2 +='<tr>'
				tag2 +='<td><input type="text" value="" class="inpute" size="2" style="background-color: #b0afa2;"></td>'
				tag2 +='<td><a href="#" id="inpute1" onclick="exertime('+item.exernum+')"><img id="exerciseimg" src="resources/btn/enter.png"width="64" height="64"></a></td>'
				tag2 +='</tr>'
			})
			//totalkcal = '<p>&nbsp;Total '+total+'kcal</p>';
			$("#myexercise").html(tag);
			$(".exertime").html(tag2);
			//$(".totalkcal").html(totalkcal); 
			}
		})
}
function exertime(exernum){
	var totaltime = $(".inpute").val();
	
	var info = {
		"exernum" : exernum, 
		"totaltime" : totaltime 
	}
	
	$.ajax({
		type : 'POST',
		data : info,
		url : 'exertime', 
		success : showmyexercise,
	})
	
}
function showmyexercise(resp){
	var inpute = $(".inpute").parent().parent();
	var tag =''
	inpute.remove();
	mydiaryexercise();
}

function exerdelete(exernum){
	var exernum = exernum
	
	$.ajax({
		type : 'POST',
		data : "exernum="+exernum, 
		url : 'exerdelete', 
		success : mydiaryexercise
	})
}

</script>
</head>
<body>
<div class="center">
	<div class="center-1">
		<div class="canvas-container" >
			<canvas id="myCanvas" width="900px" height="500px"></canvas> 
			<input type="text" id="exername" size="13" style="background-color: #b0afa2;" onkeydown="searchexercise()">
			<a href="#" id="btn1"><img  src="resources/btn/cancel2.png" width="64" height="64"></a>
			<a href="starthome" id="btn2"><img  src="resources/btn/home1.png"width="64" height="64"></a>
			<!--<a href="#" id="btn3"><img  src="resources/btn/enter.png"width="64" height="64"></a>-->
		</div>	
		
		<div class="sports" id ="scrollstyle">
		<table id="showexercise">
		</table>
		
		</div>
		
		<div class="title">
		<p>Exercise</p>
		</div>
		
		
		<div class="sports2" id ="scrollstyle">			
			<table id="myexercise">     
			</table>
		</div>
		<div class="sports3" id ="scrollstyle" >
			<div>
				<table class="exertime">
				</table>
			</div>
		</div>
		
		<div class="totalkkca3cal">
		<p id="totalkalr"></p>
		</div>
	</div>
</div>

<script>
    // 실제로 그려지는 위치의 캔버스 생성
     var canvas = document.querySelector("#myCanvas");
     var context = canvas.getContext("2d"); 
   
    
     var background = new Image();
	 background.src = "resources/frame/CIRCUS BACKGROUND_blur.png";
	 
	 var board = new Image();
	 var curtain = new Image();
	 var frame = new Image();
	 var kcaltext = new Image();

	 
	 board.src = "resources/frame/board.png";
	 curtain.src = "resources/frame/커텐.png";
	 frame.src = "resources/frame/틀.png";
	 kcaltext.src = "resources/frame/네모.png";
	 
	
	 background.onload=function(){
		  setInterval(drawMotion, 100);
	 };
   
	 function drawMotion() {
		context.drawImage(background,1,1,900,500);
		context.drawImage(board,55,50,430,350);
		context.drawImage(curtain,480,55,380,430);
		context.drawImage(frame,95,410,245,64);
		context.drawImage(kcaltext,530,390,275,60); 
		//(이미지 이름, x, y, width, height)
	 }
   
</script>
</body>
</html>