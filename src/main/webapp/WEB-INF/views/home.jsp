<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>home</title>
<link href="https://fonts.googleapis.com/css?family=Orbitron&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Ops+One|Orbitron&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap" rel="stylesheet">
<style>
.canvas-container {
   position: absolute;
}
@font-face { font-family: 'GoodFont'; /* 폰트 패밀리 이름 주기*/ 
          src: url('resources/fonts/BMJUA_ttf.ttf'); /*폰트 파일 주소*/ }
pre{ /* 위에서 font-face로 지정해놓은 font-family를 적용*/ 
   font-family:'GoodFont' !important; }
#myCanvas {
   position: absolute;
}
#button {
   position: absolute;
   margin-top : 20px;
   border: none;
   cursor: pointer;
    
}
#exercisebtn{
   position: absolute;
   margin-top : 90px;
   border: none;
   cursor: pointer;
}
#recodiner{
   position: absolute;
   margin-top : 160px;
   border: none;
   cursor: pointer;
}
#minigame{
   position: absolute;
   margin-top : 210px;
   border: none;
   cursor: pointer;
}
#cal{
   position: absolute;
   left: 30%;
   top: 40%;
   margin-left :175px;
   margin-top: 290px;
}
#eatrate{
   position: absolute;
   left: 30%;
   top: 40%;
   margin-left : 175px;
   margin-top: 290px;
}
.alert {
   width: 200px;
   height: 30px;
   position: absolute;
   border: none;
   border-radius: 10px;
   margin-left : 10px;
   margin-top: 15px;
   background-color :#333122;
   box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5);
   font-family: 'Press Start 2P', cursive;
}   
.alert2{
   color: white;
   margin-top: -9px;
}
.alert-1{
   width: 280px;
   height: 30px;
   position: absolute;
   border: none;
   border-radius: 10px;
   margin-left : 250px;
   margin-top: 15px;
   background-color :#333122;
   box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5);
   font-family: 'Press Start 2P', cursive;
}
.alert-12{
   color: white;
   margin-top: 10px;   
   margin-left:10px;
}
   
.alert-2{
   width: 160px;   
   height: 30px;
   position: absolute;
   border: none;
   border-radius: 10px;
   margin-left : 700px;
   margin-top: 20px;
   background-color :#333122;
   box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5);
   font-family: 'Press Start 2P', cursive;
}
.alert-22{
   color: white;
   margin-top: 5px;
   margin-left:10px;
}
.alert-23{
   color: white;
   margin-left:20px;
   margin-top: 5px;   
}
.bubble{   
   position: absolute;
   margin-top: 170px; 
   margin-left : 130px;
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
   border-right :10px solid transparent;
   border-top:20px solid rgba(0, 0, 0, 0.3);
   border-left : 10px solid transparent;
   position:absolute;
   bottom:-1px;
   width:0; height:0;
}
.alert33{
   margin-top: 17px;
   margin-left: 10px;
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
.menu{
   width: 200px;
   height: 300px;
   margin-left:600px;
   margin-top : 50px;
}
.menu-1{
   margin-top: 60px;
   margin-left: 50px;
}
#scale{
   position: absolute;
   margin-top: 70px; 
   margin-left: 25px
}
#diary{
   position: absolute;
   margin-top: 50px; 
   margin-left: 90px
}

#button:hover, #exercisebtn:hover, #recodiner:hover,#minigame:hover,#scale:hover,#diary:hover,#logout:hover{
  -webkit-transform: translateY(-5px);
          transform: translateY(-5px);
  -webkit-transition: all 100ms ease-in;
  transition: all 100ms ease-in;
  box-shadow: 0 5px 5px rgba(51, 51, 51, 0.4);
}
#button:focus, #exercisebtn:focus,#recodiner:focus,#minigame:focus,#scale:focus,#diary:focus,#logout:focus{
  outline: 0;
}
#button:active, #exercisebtn:active,#recodiner:active,#minigame:active,#scale:active,#diary:active,#logout:active{
  -webkit-transform: translateY(-3px);
          transform: translateY(-3px);
}
#logout{
   position: absolute;
   margin-left: 800px;
   margin-top:-400px;
}
</style>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function(){
   $.ajax({
      type : 'POST',
      url : 'homeinfo',
      success : success 
   })
})

function success(resp){
   var tag ="now: "+resp.weight+ "kg";
   $(".alert33").html(tag);
   
   var tag2 =  "&nbsp;&nbsp;現在基礎代謝量は"+resp.kcalresult+"kcal です.&nbsp;&nbsp;&nbsp;&nbsp";
   $(".label").html(tag2); 
   
   $.ajax({
      type : 'GET',
      url : 'todayreport',
      success : function(resp){
         var tag3 = "today :"+resp+"kcal";
         $(".alert-12").html(tag3);   
      } 
   })
}
</script>
</head>
<body>
<div class="center">	
   <div class="center-1">
      <div class="canvas-container">
         <canvas id="myCanvas" width="900px" height="500px"></canvas>
         <div class="alert">
            <div class="alert2">
               <div class="alert33">
                  </div>
               </div>
         </div>
         <div class="alert-1">
            <div class="alert-12"> today :0kcal</div>
         </div>
         <div class="bubble">
             <p class="label">
             </p>
            <div class="tail"></div>
         </div>
         <div class="menu">
               <div class="menu-1">
                    <a id='button' href="foodinsert"><img src="resources/png/foodinsert.png" width="100" height="80"></a><br> 
                     <a id='exercisebtn' href="exerciseinsert"><img src="resources/png/sport.png" width="100" height="80"></a><br>
                       <a id='recodiner' href="recommend"><img src="resources/png/report.png" width="100" height="70"></a><br> 
                      <a id='minigame' href="minigame"><img src="resources/png/minigame.png" width="100" height="80"></a>
               </div>
         </div>
         <a id='scale' href="diary"><img src="resources/img/pix_scale.png" width="60" height="auto"></a><br> 
         <a id='diary' href="daybyday"><img src="resources/img/diary.png" width="55" height="auto"></a><br> 
         <a id='logout' href="logout"><img src="resources/img/logout.png" width="100" height="auto"></a><br> 
      </div>
   </div>
</div>

<script>
   var _cvs,
   _ctx,
   _img,
   _frame = 0,
   _frame1 =0,
   _frame2 =0,
   _frame3 =0,
   _maxFrame = 5,
   _maxFrame1 = 4,
   _maxFrame2 = 4,
   _maxFrame3 = 3,
   background,
   myImg,
   ball,
   rabbit,
   cat,
   dog, 
   board;
   
    _cvs = document.querySelector("#myCanvas");
     _ctx = _cvs.getContext("2d");
     
     
    background = new Image(); 
    myImg = new Image() ; 
    board = new Image(); 
    _img = new Image();
    ball = new Image(); 
    rabbit = new Image();
    cat = new Image(); 
    dog = new Image();
    
    myImg.src = "resources/png/ii.png"; 
   background.src = "resources/png/background.png";
   board.src = "resources/img/board2.png";
   _img.src = "resources/animations/cal33.png";
   ball.src="resources/animations/balls.png";
   rabbit.src="resources/animations/rabitmove.png"
   cat.src = "resources/animations/movecat.png";
   dog.src = "resources/animations/dogmove.png";
   
    
    myImg.onload=function(){
       setInterval(drawMotion, 200);
    }
  
    function drawMotion() {
    	$.ajax({
    		type : 'GET', 
    		url : 'getBestScore', 
    		success : function(resp){
    			if(resp >500){
    				 _cvs.width = _cvs.width;
   			        _ctx.drawImage(background,1,1,900,500);
   			        _ctx.drawImage(board,550,50, 300,400);  
   			        _ctx.drawImage(_img, _frame % 5 * 275, Math.floor(_frame / 5) * 275,
   			              275, 275, 200, 250, 150, 150);
   			         _ctx.drawImage(rabbit, _frame1 % 4 * 275, Math.floor(_frame1 / 4) * 275,
   				              275, 275, 400, 345, 100, 100); 
   			        _ctx.drawImage(cat, _frame2 % 4 * 140, Math.floor(_frame2 / 4) * 140,
   			        		140, 140, 320, 325, 100, 100);
   			     	_ctx.drawImage(dog, _frame3 % 3 * 140, Math.floor(_frame3 / 3) * 140,
			        		140, 140, 120, 345, 80, 80);
   			        _frame = (_frame + 1) % _maxFrame;
   			        _frame1= (_frame1 + 1)% _maxFrame1;
   			        _frame2= (_frame2 + 1)% _maxFrame2;
   			     	_frame3= (_frame3 + 1)% _maxFrame3;
    			}
    			else if(resp>300){
    				 _cvs.width = _cvs.width;
  			        _ctx.drawImage(background,1,1,900,500);
  			        _ctx.drawImage(board,550,50, 300,400);  
  			        _ctx.drawImage(_img, _frame % 5 * 275, Math.floor(_frame / 5) * 275,
  			              275, 275, 200, 250, 150, 150);
  			      	_ctx.drawImage(rabbit, _frame1 % 4 * 275, Math.floor(_frame1 / 4) * 275,
				              275, 275, 400, 345, 100, 100); 
			        _ctx.drawImage(cat, _frame2 % 4 * 140, Math.floor(_frame2 / 4) * 140,
			        		140, 140, 320, 325, 100, 100);
  			        _frame = (_frame + 1) % _maxFrame;
  			        _frame1= (_frame1 + 1)% _maxFrame1;
  			        _frame2= (_frame2 + 1)% _maxFrame2;
    				 
    			}
    			else if(resp>100){
    				 _cvs.width = _cvs.width;
 			        _ctx.drawImage(background,1,1,900,500);
 			        _ctx.drawImage(board,550,50, 300,400);  
 			        _ctx.drawImage(_img, _frame % 5 * 275, Math.floor(_frame / 5) * 275,
 			              275, 275, 200, 250, 150, 150);
 			       	_ctx.drawImage(rabbit, _frame1 % 4 * 275, Math.floor(_frame1 / 4) * 275,
				              275, 275, 400, 345, 100, 100); 
 			        _frame = (_frame + 1) % _maxFrame;
 			        _frame1= (_frame1 + 1)% _maxFrame1;
 			        
    			}
    			else {
    				 _cvs.width = _cvs.width;
 			        _ctx.drawImage(background,1,1,900,500);
 			        _ctx.drawImage(board,550,50, 300,400);  
 			        _ctx.drawImage(_img, _frame % 5 * 275, Math.floor(_frame / 5) * 275,
 			              275, 275, 200, 250, 150, 150);
 			        
 			        _frame = (_frame + 1) % _maxFrame;
 			        _frame1= (_frame1 + 1)% _maxFrame1;
    			}
    		} 
    		
    	})
      
    }
</script>
</body>
</html>