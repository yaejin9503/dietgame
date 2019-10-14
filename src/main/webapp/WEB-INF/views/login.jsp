<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>login</title>
<link
   href="https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap"
   rel="stylesheet">
<style>
@font-face {
   font-family: 'GoodFont'; /* 폰트 패밀리 이름 주기*/
   src: url('resources/fonts/BMJUA_ttf.ttf'); /*폰트 파일 주소*/
}
@font-face { font-family: 'jua'; /* 폰트 패밀리 이름 주기*/ 
          src: url('resources/fonts/BMJUA_ttf.ttf'); /*폰트 파일 주소*/ }
pre { /* 위에서 font-face로 지정해놓은 font-family를 적용*/
   font-family: 'GoodFont','jua';
}
.canvas-container {
   position: relative;
}

#myCanvas {
   position: absolute;
}

#member {
   position: absolute;
   margin-left: 338px;
   margin-top: 210px;
}

.center {
   width: 1500px;
   height: 730px;
   background-color: black;
}

.center-1 {
   width: 1000px;
   height: 580px;
   padding-top: 100px;
   margin-left: 300px;
}

input {
   outline-style: none; /* 포커스시 발생하는 효과 제거를 원한다면 */
   -webkit-appearance: none; /* 브라우저별 기본 스타일링 제거 */
   -moz-appearance: none;
   appearance: none;
   display: inline;
   outline: none;
   border: 4px solid rgb(225, 210, 73);
   border-radius: 8px;
}

.btn {
   position: fixed;
   margin-left: 360px;
   margin-top: 340px;
}

#tdterm {
    font-family: 'Press Start 2P';
   padding-right: 10px;
}

span {
   font-size: 13px;
   color: yellow;
   width: 15px;
}

#signup:hover, #login:hover {
   -webkit-transform: translateY(-5px);
   transform: translateY(-5px);
   -webkit-transition: all 100ms ease-in;
   transition: all 100ms ease-in;
   box-shadow: 0 5px 10px rgba(51, 51, 51, 0.4);
}

#signup:focus, #login:focus {
   outline: 0;
}

#signup:active, #login:active {
   -webkit-transform: translateY(-3px);
   transform: translateY(-3px);
}
</style>

<script src="resources/jquery-3.3.1.min.js"></script>
<script>
   function login() {
      var userid = $("#userid").val();
      var password = $("#password").val();

      var user = {
         "userid" : userid,
         "password" : password
      }
      

      $.ajax({
         type : 'POST',
         data : user,
         url : 'userlogin',
         success : gohome
      })
   }

   function gohome(resp) {
      if (resp == 'success') {
         location.href = "starthome";
      } else {
         document.getElementById("checkid").innerHTML = "存在しないIDと<br>暗証番号です。";
         return false;
      }

   }
   
   
</script>
</head>
<body>
   <div class="center">
      <div class="center-1">
         <div class="canvas-container">
            <canvas id="myCanvas" width="900px" height="500px"></canvas>
            <div id="member">
               <form>
                  <table>
                     <tr>
                        <td id="tdterm">&nbsp;ID</td>
                        <td><input type="text" id="userid"
                           style="background-color: #b0afa2;"></td>
                     </tr>
                     <tr>
                        <td></td>
                        <td></td>
                     </tr>
                     <tr>
                        <td></td>
                        <td></td>
                     </tr>
                     <tr>
                        <td></td>
                        <td></td>
                     </tr>
                     <tr>
                        <td></td>
                        <td></td>
                     </tr>
                     <tr>
                        <td></td>
                        <td></td>
                     </tr>
                     <tr>
                        <td></td>
                        <td></td>
                     </tr>
                     <tr>
                        <td id="tdterm">&nbsp;PW</td>
                        <td><input type="password" id="password"
                           style="background-color: #b0afa2;"></td>
                     </tr>
                     <tr>
                        <th></th>
                        <td><span id="checkid"></span></td>
                     </tr>
                  </table>
               </form>
            </div>
            <div class="btn">
               <a href="#" onclick="login()" id="login"> 
               <img src="resources/btn/login.png" width="100" height="auto"></a> 
                  <a href="signup" id="signup"><img src="resources/btn/signup.png"
                  width="100" height="auto"></a>
            </div>
         </div>
      </div>
   </div>

   <script>
      var canvas = document.querySelector("#myCanvas");
      //canvas에 렌더링 할 context 객체의 참조값

      var context = canvas.getContext("2d");
      //canvas에 렌더링 할 context 객체의 참조값 

      //이미지 로딩하기 
      var background = new Image();
      var myImg = new Image();
      var mylogo = new Image();
      var frame = new Image();
      var frame2 = new Image();

      //이미지가 완전히 로딩되는 데 시간이 걸림, 호출하고 바로 그리지 못하므로 onload를 이용한다. 
      background.src = "resources/png/blur.png";
      myImg.src = "resources/png/board.png";
      mylogo.src = "resources/png/logo.png";
      frame.src = "resources/img/틀.png";
      frame2.src = "resources/img/틀.png";

      background.onload = function() {
         setInterval(drawMotion, 100);
      };

      function drawMotion() {
         context.drawImage(background, 1, 1, 900, 500);
         context.drawImage(myImg, 300, 100, 310, 330);
         context.drawImage(mylogo, 363, 10, 200, 200);
         //(이미지 이름, x, y, width, height)
      }
   </script>
</body>
</html>