<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>report</title>
<link href="https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap" rel="stylesheet">
<style>
@font-face { font-family: 'GoodFont'; /* 폰트 패밀리 이름 주기*/ 
          src: url('resources/fonts/BMJUA_ttf.ttf'); /*폰트 파일 주소*/ }

pre{ /* 위에서 font-face로 지정해놓은 font-family를 적용*/ 
   font-family:'GoodFont' !important; }

.canvas-container {
   position: relative;
}
.diet {
   width: 720px;
   height: 350px;
   overflow: auto;
}
#btn2{
	position: absolute;
	margin-left: 840px;
	margin-top :450px;
}
#myCanvas {
   position: absolute;
}
#mykcal{
	font-family: 'Press Start 2P', cursive;
}

#denmark {
   position: absolute;
   margin-left : 20px;
   margin-top: 50px;
}
#MediterraneanSea {
   position: absolute;
   margin-left : 100px;
   margin-top: 100px;
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
.lowfatdiet{
	width: 700px;
	height: 340px;
	position: absolute;
}
.morningdietfood{
	width: 700px;
	height: 110px;
	position: absolute;
}
.lunchdietfood{
	width: 700px;
	height: 110px;
	position: absolute;
	margin-top: 110px;
}
.dinnerdietfood{
	width: 700px;
	height: 110px;
	position: absolute;
	margin-top: 220px;
}
.bubble{	
   position: absolute;
   margin-top: 160px; 
   margin-left : 500px;
}
.bubble .label{
   color:#ffffff;
   background-color:rgba(0, 0, 0, 0.3);
   border-radius:5px;
   padding:20px;
}
.bubble .tail{
   left:50%;
   margin-left:-10px;
   border-right :-15px solid transparent;
   border-top:20px solid rgba(0, 0, 0, 0.3);
   border-left : 40px solid transparent;
   position:absolute;
   bottom:-1px;
   width:0; height:0;
}
.allkcal{
   width: 300px;
   height: 100px; 
   margin-left:530px;
   margin-top: 50px;
   position: absolute;

}
.allkcal1{
	width : 280px;
	height : 80px;
	margin-top : 10px;
	margin-left : 10px;
	position: absolute;
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
</style>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript">
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(drawChart);
    
function drawChart() {
	$.ajax({
		type : 'GET', 
		url : 'todayfoodreport', 
		success: foodchart
	})
}
function foodchart(resp){
	var tag =''; 
	var tag1 = ''; 
	var kcal = '';
	var data = google.visualization.arrayToDataTable([["nutrient","Rating"],["炭水化物",resp.carb],["蛋白質",resp.portein],["脂肪",resp.fat]]);
	
	var chart = new google.visualization.PieChart(document.getElementById("employee_piechart"));
	chart.draw(data,  {title:"今日の栄養比率", 
		   width:600, height:400, 
		   backgroundColor: "transparent"}
	);
	
	var total = resp.carb + resp.portein + resp.fat;
	
	
	if(resp.carb > resp.portein && resp.carb > resp.fat){
		tag+='今日は炭水化物の摂取量が多いですね!'
		tag+='<br>次の食事には少し減らすのはどうですか'
	}
	else if(resp.portein>resp.carb && resp.portein>resp.fat){
		tag+='今日はたんぱく質の摂取量が多いですね!'
		tag+='<br>次の食事には少し減らすのはどうですか'
	}
	else if(resp.fat>resp.carb && resp.fat>resp.portein){
		tag+='今日は脂肪摂取量が多いですね!'
		tag+='<br>次の食事には少し減らすのはどうですか'
	}else{
		tag+='まだ献立されていません!'
		tag+='<br>早く登録してください!'
	}
	
	$(".label").html(tag); 
	tag1 += '<tr>'
	tag1 += '<td>kcal: '+resp.cal +' kcal</td></tr>'
	tag1 += '<tr><td>carb: '+ resp.carb +'g</td></tr>'
	tag1 += '<tr><td>protein: '+ resp.portein +'g</td></tr>'
	tag1 += '<tr><td>fat: '+ resp.fat +'g</td></tr>'
	$("#mykcal").html(tag1);
	kcal = resp.cal;
}
</script>
</head>
<body>
<div class="center">
   <div class="center-1">   
      <div class="canvas-container">
         <canvas id="myCanvas" width="900px" height="500px"></canvas>
         <div id="denmark">   
             <div id="employee_piechart" style="width: 700px; height: 340px;"></div>
            </div>
            <a href="starthome" id="btn2"><img  src="resources/btn/back.png"width="50" height="50"></a>
			  <div class="bubble">
		       <p class="label">
		       </p>
		      <div class="tail"></div>
        	 </div>
        	 <div class="allkcal">
        	 	<div class="allkcal1">
        	 	<table id ="mykcal"></p></div>
        	 </div>
        	 </div>
         </div>
      </div>
      
<script>
   var canvas = document.querySelector("#myCanvas");
   //canvas에 렌더링 할 context 객체의 참조값
    
   var context = canvas.getContext("2d"); 
   //canvas에 렌더링 할 context 객체의 참조값 
   var frame = 0;
   var maxFrame = 4;
   
   
   //이미지 로딩하기 
   var board = new Image();
   var background = new Image(); 
   var myImg = new Image(); 
   var boy = new Image(); 
   
   //이미지가 완전히 로딩되는 데 시간이 걸림, 호출하고 바로 그리지 못하므로 onload를 이용한다. 
   myImg.src = "resources/png/ii.png";
   background.src = "resources/png/background.png";
   board.src = "resources/img/board2.png";
   boy.src = "resources/png/boy.png";
   
   
   background.onload=function(){
       setInterval(drawMotion, 150);
   };
          
   function drawMotion() {
      context.drawImage(background,1,1,900,500);
      context.drawImage(board,8,10,900,450);
      context.drawImage(boy, frame % 4 * 300, Math.floor(frame / 4) * 300,
              300, 300, 670, 270, 150, 150);
      frame = (frame + 1) % maxFrame;

      //(이미지 이름, x, y, width, height)
   }
</script>
</body>
</html>