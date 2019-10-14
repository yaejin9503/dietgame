<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap" rel="stylesheet">
<title>minigame</title>
<style>.canvas-container {
   position: absolute;
}
#myCanvas {
   position: absolute;
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
.lives{
	position : absolute; 
	top : 10px; 
	left : 20px; 
	color : yellow; 
	font-size : 140%; 
	font-weight : bold; 
	font-family: 'Press Start 2P', cursive;
}
.score {
	position : absolute; 
	top : 10px; 
	left : 250px; 
	color : white; 
	font-family: 'Press Start 2P', cursive;
	font-size : 140%; 
	font-weight : bold; 
}
.game-over{
	position : absolute;
	top : 100px;
	left : 380px;
	color : #FE7F00;
	font-family: 'Press Start 2P', cursive;
	font-size : 30px;
	cursor : default; 	
	display : none;
}
.game-over span{	
	font-size : 20px;
	cursor : pointer; 
	position : relative; 
}
.game-over span:hover {
	color : #FED700;
} 
.bestscore{
	position : absolute; 
	top : 10px; 
	left : 550px;
	color : white; 
	font-family: 'Press Start 2P', cursive;
	font-size : 140%;
	font-weight : bold; 
}
#btn2{
	position: absolute;
	margin-left: 840px;
	margin-top :450px;
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
		<div class="canvas-container">
		<canvas id="myCanvas" width="900px" height="500px"></canvas>
		<a href="starthome" id="btn2"><img  src="resources/btn/back.png"width="50" height="50"></a>
		<div class="lives">LIFE:<span id="lives">0</span></div>
		<div class="score">SCORE:<span id="score">0</span></div>
		<div class="bestscore">BEST:<span id="bestscore">0</span></div>
		<div class="game-over" id ="game-over">GAME OVER
		<p><span id="restart">[Restart]</span></p></div>
		</div>
	</div>
</div>
<script src="resources/jquery-3.3.1.min.js"></script>
<script src="resources/js/minigame2.js"></script>
</body>
</html>