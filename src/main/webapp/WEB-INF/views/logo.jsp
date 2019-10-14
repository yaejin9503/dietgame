<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logo</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<style>
.canvas-container {
   position: relative;
}

#myCanvas {
   position: absolute;
}

#start {
   position: absolute;
   left: 30%;
   top: 40%;
   margin-left: -100px;
   margin-top: 365px;
}
.center{ 
   width: 100%;
   height:730px;
   background-color: black;
}
.center-1{
   width: 100%;
   height:730px;
   padding-top : 100px;
   margin-left: 300px;
}

</style>
<script src="resources/jquery-3.3.1.min.js"></script> 
<script >
setInterval(function(){
     $("#start").toggle();
   }, 300);

</script> 
</head>
<body>
<div class="center">
   <div class="center-1">   
      <div class="canvas-container" >
         <canvas id="myCanvas" width="900px" height="500px"></canvas> 
          <a id="start" href="start"><img src="resources/frame/start.png" width="220px" height="75px" ></a>
       </div>
    </div>
</div>

<script>
    // 실제로 그려지는 위치의 캔버스 생성
     var canvas = document.querySelector("#myCanvas");
     var context = canvas.getContext("2d"); 
   
    
     var background = new Image();
    background.src = "resources/frame/CIRCUS BACKGROUND_blur.png";
    
      var logo = new Image();
      var start = new Image();
      logo.src = "resources/img/Logo_shadow.png"; 
     // start.src = "resources/frame/start.png";  
      
      background.onload=function(){
         setInterval(drawMotion, 100);
      };
   
      function drawMotion() {
         context.drawImage(background,1,1,900,500);         
         context.drawImage(logo,250,40,400,350); 
         // context.drawImage(start,380,365,150,70);
         //(이미지 이름, x, y, width, height)
      }
     
</script>
</body>
</html>



<!--블러 
-webkit-filter: blur(5px);
-moz-filter: blur(5px);
-o-filter: blur(5px);
-ms-filter: blur(5px);
filter: blur(5px); -->
   





