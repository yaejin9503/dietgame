<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>DayByDay</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap" rel="stylesheet">
<style>
@font-face {
   font-family: 'GoodFont'; /* 폰트 패밀리 이름 주기*/
   src: url('resources/fonts/851Gkktt_004.ttf'); /*폰트 파일 주소*/
}

@font-face {
   font-family: 'jua'; /* 폰트 패밀리 이름 주기*/
   src: url('resources/fonts/BMJUA_ttf.ttf'); /*폰트 파일 주소*/
}

pre {
   font-family: 'GoodFont' !important;
}

.canvas-container {
   position: relative;
}

#myCanvas {
   position: absolute;
}

input[type="text"] {
   position: absolute;
   margin-top: 422px;
   margin-left: 120px;
   padding: .8em .18em;
   font-family: 'Press Start 2P', jua;
   outline-style: none; /* 포커스시 발생하는 효과 제거를 원한다면 */
   -webkit-appearance: none; /* 브라우저별 기본 스타일링 제거 */
   -moz-appearance: none;
   appearance: none;
   display: inline;
   outline: none;
}

input[type="date"] {
   position: absolute;
   margin-top: 30px;
   margin-left: 100px;
   background: #fff
      url(https://cdn1.iconfinder.com/data/icons/cc_mono_icon_set/blacks/16x16/calendar_2.png)
      97% 50% no-repeat;
   font-family: 'Press Start 2P', GoodFont;
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
[type="date"]::-webkit-inner-spin-button {
   display: none;
}

[type="date"]::-webkit-calendar-picker-indicator {
   opacity: 0;
}

label {
   display: block;
}

input {
   border: 1px solid #c4c4c4;
   border-radius: 5px;
   background-color: #fff;
   padding: 3px 5px;
   box-shadow: inset 0 3px 6px rgba(0, 0, 0, 0.1);
   width: 190px;
}

.daymeal {
   position: absolute;
   /* overflow: auto;  //scroll */
   width: 420px;
   height: 330px;
   margin-left: 60px;
   margin-top: 110px;
   font-family: 'Press Start 2P', jua;
   
  
}
#Morning{
	position: absolute;
   float:left; 
   width: 105px;
   height: 330px;
   
}

#Lunch{
	position: absolute;
	width: 105px;
	height: 330px; 
	margin-left : 105px;
	
}
#Dinner{
    position: absolute;
	width: 105px;
	height: 330px; 
	margin-left : 210px;
	
}
#Snack{
   position: absolute;
	width: 105px;
	height: 330px; 
	margin-left : 315px;
	
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

b {
   font-size: 15px;
   font-family: 'Press Start 2P', jua;
   color: #FFA60D;
}

#name {
   font-size: 10px;
   color: yellow;
}

#kcal {
   font-size: 11px;
   color: rgb(254, 224, 72);
}

.bubble {
   position: absolute;
   margin-top: 260px;
   margin-left: 600px;
}

.bubble .label {
   color: #ffffff;
   background-color: rgba(0, 0, 0, 0.3);
   border-radius: 5px;
   padding: 10px;
}

.bubble .tail {
   /* left:50%; */
   right: 30%;
   margin-left: -10px;
   border-right: -30px solid transparent;
   border-top: 18px solid rgba(0, 0, 0, 0.3);
   border-left: 15px solid transparent;
   position: absolute;
   bottom: -1px;
   width: 0;
   height: 0;
}
#btn2:hover {
  -webkit-transform: translateY(-5px);
          transform: translateY(-5px);
  -webkit-transition: all 100ms ease-in;
  transition: all 100ms ease-in;
  box-shadow: 0 5px 10px rgba(51, 51, 51, 0.4);
}
#btn2:focus {
  outline: 0;
}
#btn2:active {
  -webkit-transform: translateY(-3px);
          transform: translateY(-3px);
} 
.exercise {
   position: absolute;
   margin-left: 550px; 
   margin-top: 100px;
   overflow: auto;
   width: 300px;
   height: 165px;
   font-family: 'Press Start 2P', jua;
}
#btn2{
	position: absolute;
	margin-left: 840px;
	margin-top :450px;
	
}
#kcal{
font-size: 11px;
color: rgb(254,224,72);
}
#name{
font-size: 11px;
color: yellow;
}

</style>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>

 $(function(){
	var tag = '食べた食べ物と運動を<br>確認してください!'; 
   $("#day").on('change',daybyday);
   $(".label").html(tag);
}) 

function daybyday(){
    var day = $("#day").val();
    
    $.ajax({
         type : 'POST',
         data : 'day='+day,
         url : 'daybyday',
         success : food 
	})
      
	 $.ajax({
		 type : 'POST',
		 data : 'day='+day,
		 url : 'exerciseday',
		 success : exerciseday 
	})      
}

function food(resp){
	var morning ='';
	var lunch ='';
	var dinner ='';
	var snack ='';
	
	/* var tag2 =  "";
	$(".label").html(tag2); */
	
    $.each(resp,function(index,item){
    	
    	
    	if(item.todaytime=='Morning'){
    		morning +="<tr>";
    		morning += "<td><img src="+item.originalfile+"></td></tr><tr><td id='name'>"+item.food_name+"</td></tr>"
    		morning += "<tr><td id='kcal'>"+item.cal+"kcal</td></tr>"
    	}
    	if(item.todaytime=='Lunch'){
    		lunch +="<tr>";
    		lunch +="<td><img src="+item.originalfile+"></td></tr><tr><td id='name'>"+item.food_name+"</td></tr>";
    		lunch +="<tr><td id='kcal'>"+item.cal+"kcal</td></tr>"
    	}
    	if(item.todaytime=='Dinner'){
    		dinner +="<tr>";
    		dinner +="<td><img src="+item.originalfile+"></td></tr><tr><td id='name'>"+item.food_name+"</td></tr>";
    		dinner +="<tr><td id='kcal'>"+item.cal+"kcal</td></tr>";
    	}
    	if(item.todaytime=='Snack'){
    		snack += "<tr>";
    		snack +="<td><img src="+item.originalfile+"></td></tr><tr><td id='name'>"+item.food_name+"</td></tr>";
    		snack +="<tr><td id='kcal'>"+item.cal+"kcal</td></tr>";
    	}
    	/*
       if(item.todaytime=='Morning'){
           $("#Morning1").after("<tr><td><img src="+item.originalfile+"></td></tr><tr><td>"+item.food_name+"</td></tr><tr><td>"+item.cal+"</td></tr>"); //or append 
       }
       if(item.todaytime=='Lunch'){
          $("#Lunch1").after("<tr><td><img src="+item.originalfile+"></td></tr><tr><td>"+item.food_name+"</td></tr><tr><td>"+item.cal+"</td></tr>"); //or append 
       }
       if(item.todaytime=='Dinner'){
            $("#Dinner1").after("<tr><td><img src="+item.originalfile+"></td></tr><tr><td>"+item.food_name+"</td></tr><tr><td>"+item.cal+"</td></tr>"); //or append 
           }
       if(item.todaytime=='Snack'){
             $("#Snack1").after("<tr><td><img src="+item.originalfile+"></td></tr><tr><td>"+item.food_name+"</td></tr><tr><td>"+item.cal+"</td></tr>"); //or append 
           }
       */
   })    
   $("#Morning1").html(morning);
    $("#Lunch1").html(lunch);
    $("#Dinner1").html(dinner);
    $("#Snack1").html(snack);
}
function exerciseday(resp){
	
	var exercise1 = ''; 
    $.each(resp,function(index,item){
    	exercise1 += ' <tr>';
    	exercise1 += '<td><img src='+item.originalfile+' width="64" height="auto"></td>';
    	exercise1 += '<td id="name">'+item.exername+'</td>';
    	exercise1 += '<td id="kcal">'+item.totaltime+'min</td>';
    })            
	$("#exerciseday").html(exercise1);
}

</script>
</head>
<body>
   <div class="center">
      <div class="center-1">
         <div class="canvas-container">
            <canvas id="myCanvas" width="900px" height="500px"></canvas>
            <input type="date" id="day" name="day">
         </div>
          <a href="starthome" id="btn2"><img  src="resources/btn/back.png"width="50" height="50"></a>
         <div class="bubble">
            <p class="label"></p>
            <div class="tail"></div>
         </div> 
         
         <div class="daymeal" style="margin-right: 5px; overflow: auto;" id="scrollstyle">
            
            <div id="Morning">
            <table id="Morning1">
            <tr><font color="yellow">Morning</font></tr> 
            </table>           
            </div>
            
            <div id="Lunch">
            <table id="Lunch1">
            <tr><font color="yellow">&nbsp;Lunch</font></tr> 
            </table>           
            </div>
            
            <div id="Dinner">
            <table id="Dinner1">
            <tr><font color="yellow">Dinner</font></tr> 
            </table>           
            </div>
            
            <div id="Snack">
            <table id="Snack1">
            <tr><font color="yellow">Snack</font></tr> 
            </table>           
            </div>
           
         </div>
         
         <div class="exercise" id="scrollstyle">
         	<p><font color="yellow">Exercise</font></p>
         	<table id ="exerciseday"></table>
         </div>
      </div>
   </div>

   <script>
   
   var canvas,
   context,
   img,
   frame = 0,
   maxFrame = 4,
   background,
   board,
   board2,
   boy2;   

   canvas = document.querySelector("#myCanvas");
   context = canvas.getContext("2d");

       background = new Image();
       board = new Image();
       board2 = new Image();
       boy2 =  new Image();
       
      background.src = "resources/frame/CIRCUS BACKGROUND_blur.png";
      board.src = "resources/frame/board.png";
      board2.src = "resources/frame/board.png";
      boy2.src = "resources/png/boy.png";


      background.onload = function() {
         setInterval(drawMotion, 200);
      };

      function drawMotion() {
         canvas.width = canvas.width;
         context.drawImage(background, 1, 1, 900, 500);
         context.drawImage(board, 15, 75, 500, 400);
         context.drawImage(board2, 510, 80, 370, 200);
         context.drawImage(boy2, frame % 4 * 300, Math.floor(frame / 4) * 300,
               300, 300, 680, 330, 150, 150);
         frame = (frame + 1) % maxFrame;

      }
   </script>
</body>
</html>

