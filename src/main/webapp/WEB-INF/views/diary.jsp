<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>weight</title>
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
input {
   position: absolute;
   margin-top: 100px;
   margin-left: 230px;
   /* padding: .2em .2em; */
   font-family: 'Press Start 2P', GoodFont;
   outline-style: none;
   -webkit-appearance: none;
   -moz-appearance: none;
   appearance: none;
   outline: none;
   background-color: rgba(0,0,0,0);
   border: solid 2px rgba(0,0,0,0);  
}
#btn2{
   position: absolute;
   margin-left: 840px;
   margin-top :450px;
}
#nowbtn{
   position: absolute;
   margin-top: 85px;             
   margin-left: 340px;
}

#locachar {
   position: absolute;
   margin-left : 90px;  
   margin-top: 160px;
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
.bubble {
   position: absolute;
   margin-top: 180px;
   margin-left: 620px;
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
</style>             
</head>
<body>
<div class="center">
      <div class="center-1">  
      <div class="canvas-container" >
          <canvas id="myCanvas" width="900px" height="500px"></canvas>
          <label for="nowweight"></label>
           <div class="bubble">
            <p class="label">毎日体重記録するの<br>忘れないでください!</p>
            <div class="tail"></div>
         </div> 
          <input type="text" id="nowweight" size="3" height="40px" style="font-size: 35px; " >
         <a href="#" id="nowbtn" onclick ="insertweight()"><img src="resources/btn/enter.png" width="64" height="auto"></a>
         <a href="starthome" id="btn2"><img  src="resources/btn/back.png"width="50" height="50"></a>
         <div id="locachar">
         <div id="chart_div" style="width: 400px; height: 300px;"></div>
         </div>
      </div>      
   </div>   
</div>

 
<script>
     var canvas = document.querySelector("#myCanvas");
     var context = canvas.getContext("2d");
     var frame = 0;
     var maxFrame = 4;
   
     var background = new Image();
     var scale = new Image();
     var boy = new Image(); 
    
     background.src = "resources/frame/CIRCUS BACKGROUND_blur.png";
     scale.src = "resources/img/pix_scale22.png";
     boy.src = "resources/png/boy.png";
     
     
    background.onload=function(){
      setInterval(drawMotion, 250);
   };
   
   function drawMotion() {
      context.drawImage(background,1,1,900,500);
       context.drawImage(scale,55,30,500,450);
       context.drawImage(boy, frame % 4 * 300, Math.floor(frame / 4) * 300,
                 300, 300, 670, 270, 150, 150);
         frame = (frame + 1) % maxFrame;
   }
   
</script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(function(){
    drawChart();
    /* $('#nowbtn').click(function() {
    		  
   	}); */
})

function drawChart() {
      $.ajax({
         type : 'GET', 
         url : 'todayweightreport',
         success: weightchart
      })
}

function insertweight(){
   
   $.ajax({
	   type : 'GET', 
	   url : 'confirmdata', 
	   success:function(resp){
		   if(resp =='false'){
			   alert("이미 등록한 몸무게가 있습니다.")
			   return false; 
		   }else{
			   realinsertweight();
		   }
	   }
   })
}
function realinsertweight(){
	var weight =  $("#nowweight").val();
	
	$.ajax({
	      type : 'POST', 
	      data : "weight="+weight, 
	      url : 'insertweight', 
	      success : weightchart
	   })
	   window.location.reload();
}

function formatDate(date) {
     return (date.getMonth() + 1) + '月' + 
       date.getDate() + '日';
}

function weightchart(resp){   
	   
       google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);
        var WeightArray = [];
        function  drawChart(){
           WeightArray.push( ['day', 'weight']);
           $.each(resp,function(index,item){
             var seoul = new Date(item.day);
             var newWeight = [formatDate(seoul),item.weight];
             WeightArray.push(newWeight);
           })
          var data = google.visualization.arrayToDataTable(WeightArray);          
           var options = {   
                    title: 'Daily Weight',
                    backgroundColor: 'transparent', 
                    vAxis: {
                           baselineColor: '#000000',  
                           gridlines: {color: 'black'
                          }
                     }    
           }
           var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
           chart.draw(data, options);
           }
      
}  
</script>
</body>
</html>