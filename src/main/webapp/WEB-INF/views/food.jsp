<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Input_Food</title>
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
	margin-left: 120px;
	padding: .8em .18em; 
	font-family: 'Press Start 2P',GoodFont;
	outline-style: none; /* 포커스시 발생하는 효과 제거를 원한다면 */ 
	-webkit-appearance: none; /* 브라우저별 기본 스타일링 제거 */ 
	-moz-appearance: none; 
	appearance: none;
	display:inline;
	outline:none;
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
#btn1:hover, #btn2:hover,#foodimg:hover {
  -webkit-transform: translateY(-5px);
          transform: translateY(-5px);
  -webkit-transition: all 100ms ease-in;
  transition: all 100ms ease-in;
  box-shadow: 0 5px 10px rgba(51, 51, 51, 0.4);
}
#btn1:focus, #btn2:focus,#foodimg:hover {
  outline: 0;
}
#btn1:active, #btn2:active,#foodimg:hover {
  -webkit-transform: translateY(-3px);
          transform: translateY(-3px);
}  
.meal{
position: absolute;
overflow: auto;
width: 350px;
height: 280px;
margin-left: 100px;
margin-top :80px;
font-family: 'Press Start 2P',jua;
}

.meal2{
position: absolute;
overflow: auto;
width: 280px;
height: 230px;
margin-left: 540px;
margin-top :135px;
font-family: 'Press Start 2P',jua;
}

#name{
font-size: 10px;
color: yellow;
}

#kname{
font-size: 11px;
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
	mydiary();
	$.ajax({
		type : 'GET',
		url : 'showfood', 
		success : foodscreen
	})
})
function foodscreen(resp){
	var tag = ''; 
	
	$.each(resp,function(index,item){
		tag += '<tr>'; 
		tag += '<td><a href="#" onclick="foodinsert('+item.food_num+')"><img id = "foodimg" src="'+item.originalfile+'"></a></td>';
		tag += '<td id="kname">'+item.food_name+'</td>'
		tag +='<td id ="kcal">&nbsp;'+item.cal+'kcal</td>'
	    tag += '</tr>'
	})
	$("#foodcenter").html(tag);
}

function searchfood(){
	var food_name = $("#food_name").val(); 

	$.ajax({
		type : 'POST', 
		data : "food_name="+food_name, 
		url:'searchfood' ,
		success: foodscreen
	})
}

function foodinsert(food_num){
	var foodnum = food_num 
	var morning = "${morning}"
	var lunch = "${lunch}"
	var dinner = "${dinner}"
	var snack = "${snack}"
	
	var foodinfo = {
		"foodnum" : foodnum,
		"morning" : morning, 
		"lunch" : lunch, 
		"dinner" : dinner, 
		"snack" : snack
	}
	
	$.ajax({
		type : 'POST', 
		data : foodinfo, 
		url : 'foodinsert', 
		success : mydiary
	})
}
function mydiary(resp){
	
	var morning = "${morning}"
	var lunch = "${lunch}"
	var dinner = "${dinner}"
	var snack = "${snack}"
		
		
	var foodinfo = {
			"morning" : morning, 
			"lunch" : lunch, 
			"dinner" : dinner, 
			"snack" : snack
		}
	
	$.ajax({
		type : 'POST', 
		data : foodinfo, 
		url : 'myfooddiary', 
		success : function(resp){
			var tag = ''; 
			var total = 0; 
			var totalkcal = ''; 
			
			$.each(resp,function(index,item){
				tag += '<tr>'; 
				tag += '<td><a href="#" onclick="fooddelete('+item.food_num+')"><img id = "foodimg" src="'+item.originalfile+'"></a></td>';
				tag += '<td id="kname">'+item.food_name+'</td>'
				tag +='<td id ="kcal">&nbsp;'+item.cal+'kcal</td>'
			    tag += '</tr>'
			    total +=item.cal;
			})
			totalkcal = '<p>&nbsp;Total '+total+'kcal</p>';
			$("#myfood").html(tag);
			$(".totalkcal").html(totalkcal); 
		}
	})
	
}
function fooddelete(food_num){
	var foodnum = food_num
	var morning = "${morning}"
	var lunch = "${lunch}"
	var dinner = "${dinner}"
	var snack = "${snack}"
	
	var foodinfo = {
		"foodnum" : foodnum,
		"morning" : morning, 
		"lunch" : lunch, 
		"dinner" : dinner, 
		"snack" : snack
	}
	
	$.ajax({
		type : 'POST',
		data : foodinfo, 
		url : 'fooddelete', 
		success : mydiary
	})
}


</script>
</head>
<body>
<div class="center">
		<div class="center-1">
		<div class="canvas-container" >
			 <canvas id="myCanvas" width="900px" height="500px"></canvas>
			<input type="text" id ="food_name" size="13" style="background-color: #b0afa2;" onkeydown="searchfood()">
			<a href="#" onclick ="window.location.reload()" id="btn1"><img  src="resources/btn/cancel2.png" width="64" height="64"></a>
			<a href="starthome" id="btn2"><img  src="resources/btn/home1.png"width="64" height="64"></a>
		</div>
		
		<div class="meal" id="scrollstyle">
		<table id = "foodcenter">
		      
		    </table>
		
		</div>
		
		<div class="title">
			<p>${morning} ${lunch} ${dinner} ${snack}</p>
		</div>
	
		<div class="meal2" id="scrollstyle">
		<table id ="myfood">
		     
		      </table>
		
		</div>
		
		<div class="totalkcal"></div>
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
	    context.drawImage(curtain,500,55,350,430);
	    context.drawImage(frame,95,410,245,64);
	    context.drawImage(kcaltext,530,390,275,60);
	    //(이미지 이름, x, y, width, height)
	}
	
</script>
</body>
</html>