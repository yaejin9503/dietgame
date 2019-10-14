<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Step</title>
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
margin-left: 110px;
padding: .8em .18em; 
font-family: 'Press Start 2P',GoodFont;
outline-style: none; /* 포커스시 발생하는 효과 제거를 원한다면 */ 
-webkit-appearance: none; /* 브라우저별 기본 스타일링 제거 */ 
-moz-appearance: none; 
appearance: none;
}

#morning{
position: absolute;
margin-left: 340px;
margin-top :50px;
}

#lunch{
position: absolute;
margin-left: 340px;
margin-top :150px;
}
#dinner{
position: absolute;
margin-left: 340px;
margin-top :250px;
}

#snack{
position: absolute;
margin-left: 340px;
margin-top :340px;
}

.center{ 
	width: 1500px;
	height:730px;
	background-color: black;
}
.center-1{
	width: 1000px;
	height:580px;
	padding-top : 100px;
	margin-left: 300px;
}
</style>

</head>
<body onload="load(this)">
<div class="center">
	<div class="center-1">	
		<div class="canvas-container" >
			<canvas id="myCanvas" width="900px" height="500px"></canvas>
			<a href="recommend" id="morning"><img  src="resources/img/highprotein.png" width="250" height="85"></a>
			<a href="recommend" id="lunch"><img  src="resources/img/girlgroup.png" width="250" height="85"></a>
			<a href="recommend" id="dinner"><img  src="resources/img/worker.png" width="250" height="85"></a>
			<a href="recommend" id="snack"><img  src="resources/img/todaygenenal.png" width="250" height="85"></a>
		</div>
	</div>
</div>

<%-- <c:if test="">
<div class="canvas-container" >
	<canvas id="myCanvas" width="900px" height="500px"></canvas>
	<a href="#" id="morning"><img  src="resources/img/mor_1_change.png" width="250" height="85"></a>
	<a href="#" id="lunch"><img  src="resources/img/lun_1_change.png" width="250" height="85"></a>
	<a href="#" id="dinner"><img  src="resources/img/din_1_change.png" width="250" height="85"></a>
	<a href="#" id="snack"><img  src="resources/img/sna_1_change.png" width="250" height="85"></a>
</div>
</c:if> --%>

<script>
	
    // 실제로 그려지는 위치의 캔버스 생성
     var canvas = document.querySelector("#myCanvas");
     var context = canvas.getContext("2d"); 
   
    
     var background = new Image();
	 background.src = "resources/frame/CIRCUS BACKGROUND_blur.png";
	 
	 var cur1 = new Image();
	 var cur2 = new Image();


	 
	 cur1.src = "resources/frame/커텐.png";
	 cur2.src = "resources/frame/커텐.png";


	 background.onload=function(){
	 	setInterval(drawMotion, 100);
	 };
		 
	function drawMotion() {
		 context.drawImage(background,1,1,900,500);
	     context.drawImage(cur1,1,1,200,500);
	     context.drawImage(cur2,700,1,200,500);
		//(이미지 이름, x, y, width, height)
	}
</script>
</body>
</html>