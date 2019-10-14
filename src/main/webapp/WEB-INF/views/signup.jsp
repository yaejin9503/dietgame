<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link
   href="https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap"
   rel="stylesheet">
<style>
img {
   max-width: 100%;
   height: auto;
}


.canvas-container {
   position: relative;
}

#myCanvas {
   position: absolute;
   max-width: 100%;
   height: auto;
}

.memdiv {
   position: absolute;
   width: 650px;
   height: 210px;
   margin-left: 220px;
   margin-top: 150px;
   display: inline-table;
}

.memdiv .left {
   width: 260px;
   margin-right: 3px;
   display: table-cell;
}

.memdiv .right {
   width: 280px;
   margin-left: 225px; 
   margin-top: 30px;
   display: table-cell;
}

.btn {
   margin-left: 110px;
}

.center {
   width: 100%;
   height: 730px;
   background-color: black;
}

.center-1 {
   width: 100%;
   height: 730px;
   padding-top: 100px;
   margin-left: 300px;
}

input[type="text"], input[type="password"] {
   outline-style: none; /* 포커스시 발생하는 효과 제거를 원한다면 */
   -webkit-appearance: none; /* 브라우저별 기본 스타일링 제거 */
   -moz-appearance: none;
   appearance: none;
   display: inline;
   outline: none;
   border: 4px solid rgb(225, 210, 73);
   border-radius: 8px;
   width: 120px;
}

span {
   font-size: 13px;
   color : yellow;
   width: 15px;
}

span#checksingup{
   font-size: 17px;
}

input[type="button"]{
background: url("resources/btn/enter.png");
width: 40px;
height: auto;
   outline-style: none; /* 포커스시 발생하는 효과 제거를 원한다면 */
   -webkit-appearance: none; /* 브라우저별 기본 스타일링 제거 */
   -moz-appearance: none;
position: static;

}


.id_check:hover, .dialog__action:hover {
  -webkit-transform: translateY(-5px);
          transform: translateY(-5px);
  -webkit-transition: all 100ms ease-in;
  transition: all 100ms ease-in;
  box-shadow: 0 5px 10px rgba(51, 51, 51, 0.4);
}
.id_check:focus, .dialog__action:focus {
  outline: 0;
}
.id_check:active, .dialog__action:active {
  -webkit-transform: translateY(-3px);
          transform: translateY(-3px);
}


#signup:hover, #cancel:hover, #login:hover,#id_check:hover {
  -webkit-transform: translateY(-5px);
          transform: translateY(-5px);
  -webkit-transition: all 100ms ease-in;
  transition: all 100ms ease-in;
  box-shadow: 0 5px 10px rgba(51, 51, 51, 0.4);
}
#signup:focus, #cancel:focus,#login:focus,#id_check:focus {
  outline: 0;
}
#signup:active, #cancel:active,#login:active,#id_check:active {
  -webkit-transform: translateY(-3px);
          transform: translateY(-3px);
}
#fontstyle{
	font-family: 'Press Start 2P';
}
</style>
<script src="resources/jquery-3.3.1.min.js"></script> 
<script>

 $(function(){
   $('#signup').on('click',signup);  
   $("#id_check").on('click',checkId); 

})


function signup(){
   
   var userid = $("#userid").val();
   var password = $("#password").val();
   var password2 = $("#password2").val();
   var gender = $("input[name=gender]:checked").val();   
   var weight = $("#weight").val();
   var age = $("#age").val();
   var height = $("#height").val();
   var hopeweight = $("#hopeweight").val();

   
   if (isNaN(weight.trim())) {
         document.getElementById("checkweight").innerHTML = "数字で入力してください。";
         return false;
      }
   if(weight < 10.0 || weight > 600){
      document.getElementById("checkweight").innerHTML = "10~600の間で入力してください";
      return false;
      }
   if (isNaN(age.trim())) {
      document.getElementById("checkage").innerHTML = "数字で入力してください。";
      return false;
      } 
   if(age < 10 || age > 100){
      document.getElementById("checkage").innerHTML = "10~100の間で入力してください";
      return false;
      }
   if(isNaN(height.trim())) {
      document.getElementById("checkheight").innerHTML = "数字で入力してください。"; 
      return false;
      }
   if(height< 10.0 || height > 260){
      document.getElementById("checkheight").innerHTML = "10~260の間で入力してください";
      return false;
      }
   if (isNaN(hopeweight.trim())) {
      document.getElementById("checkhope").innerHTML = "数字で入力してください。";   
      return false;
      } 
   if(hopeweight< 10.0 || hopeweight> 200){
      document.getElementById("checkhope").innerHTML = "10~500の間で入力してください";
      return false;
      }
   if(password.trim().length < 3 || password.trim().length > 10){
      document.getElementById("checkpassword").innerHTML = "3~10の間で入力してください";
      }
   if(password!=password2){
      document.getElementById("checkpassword2").innerHTML = "PWが違います";
      return false;
      }
   if(userid==''||password==''||password2==''||weight==''||age==''||height==''||hopeweight==''){
      document.getElementById("checksingup").innerHTML = "空欄がないように満たしてください。";         
      return false;
      }
   

      var total = {
         "userid" : userid,
         "password" : password,
         "gender" : gender,
         "weight" : weight,
         "age" : age,
         "height" : height,
         "hopeweight" : hopeweight
      }
   
      $.ajax({
          async : false,
          type : 'post',
          data : total,
          url : 'sign',
          success : function(resp) {
             if (resp == 1) {
                location.href="start"
             } else {
                return false; 
             }
          }
       })
   }

 
function checkId() {
     var userid = $("#userid").val();
    console.log(userid) 

    $.ajax({
       type : 'post',
       data : "userid=" + userid,
       url : 'idcheck',
       success : function(resp) {
          if (resp != '') {
             document.getElementById("checkid").innerHTML = "Idが重複します。";
              $("#userid").val("");
             return false;
          } else {
             document.getElementById("checkid").innerHTML = "Idが重複しません。";
          }
       }
    })
 }

 window.onload = function() {
     
     var userid = document.getElementById("userid");
     var password = document.getElementById("password");
     var password2 = document.getElementById("password2");
     
     document.getElementById("userid").onkeyup = function() {
        var fc = userid.value.charAt(0);
    
        if (fc.toLowerCase() < 'a' || fc.toLowerCase() > 'z') {
           console.log(fc.toLowerCase())
           document.getElementById("checkid").innerHTML = "IDは英文字で始めてください。";
           /* alert("ID는 영문자로 시작해주시기 바랍니다."); */
           userid.select();
           userid.focus();
           return false;
        }         
        if (userid.value.trim().length < 3 || userid.value.trim().length > 10) {
           document.getElementById("checkid").innerHTML = "3~10の間で入力してください";
           return false; //다시 입력 할 수 있게 함
        }
        document.getElementById("checkid").innerHTML = "";         

     }

     //password---------------------------------------------------------
     document.getElementById("password").onkeyup = function() {   
        var fa = password.value.charAt(0);
        if (fa.toLowerCase() < 'a' || fa.toLowerCase() > 'z') {
           document.getElementById("checkpassword").innerHTML = "PWは英文字で始めてください。";
           password.select();
           password.focus();
              return false;
           }         
        if(password.value.trim().length < 3 || password.value.trim().length > 10){
           document.getElementById("checkpassword").innerHTML = "3~10の間で入力してください";
           return false;
        }
        document.getElementById("checkpassword").innerHTML = "";
     }
     //password2------------------------------------------------
     document.getElementById("password2").onkeyup = function() {
        if(password.value!=password2.value){
           document.getElementById("checkpassword2").innerHTML = "PWが違います。";
           return false;
        }
        document.getElementById("checkpassword2").innerHTML = "";    
     }
  }


</script>
</head>
<body>
   <div class="center">
      <div class="center-1">
         <div class="canvas-container">
            <canvas id="myCanvas" width="900px" height="500px"></canvas>
            <div id="member" class="memdiv">
               <form action="sign" method="post">
                  <div class="left">
                     <table>
                     <br>
                        <tr>
                           <th><font id = "fontstyle">ID</font></th>
                           <td><input type="text" id="userid" name="userid"></td>
                           <!-- <td><input type="button" id="id_check" class="id_check" value="중복체크"/></td> -->
                           <td><a href="#" id="id_check" class="id_check"><img  src="resources/btn/enter.png"width="32" height="auto"></a></td>  
                        </tr>
                        <tr>
                        <th></th>
                        <td><span id="checkid"></span></td>
                        </tr>
                        <tr>
                           <th><font id = "fontstyle">PW</font></th>
                           <td><input type="password" id="password" name="password"></td>
                        </tr>
                         <tr>
                        <th></th>
                        <td><span id="checkpassword"></span></td>
                        </tr>
                        <tr>
                           <th><font id = "fontstyle">PW<br>確認</font>
                           </th>
                           <td><input type="password" id="password2"></td>
                        </tr>
                         <tr>
                        <th></th>
                        <td><span id="checkpassword2"></span></td>
                        </tr>
                     </table>
                  </div>

                  <div class="right">
                     <table>
                        <tr>
                           <th>性別</th>
                           <td><input type="radio" value="woman" name="gender" checked> 女
                                 <input type="radio" value="man" name="gender">男
                           </td>
                           <tr/>
                        <tr>
                           <th>体重</th>
                           <td><input type="text" id="weight" placeholder=" kg 単位" name="weight"></td>
                        </tr>
                        <tr>
                        <th></th>
                        <td><span id="checkweight"></span></td>
                        </tr>
                        <tr>
                           <th>年齢</th>
                           <td><input type="text" id="age" name="age" placeholder=" 10~100세 "></td>
                           <tr>
                        <th></th>
                        <td><span id="checkage"></span></td>
                        </tr>
                        </tr>
                        <tr>
                           <th>身長</th>
                           <td><input type="text" id="height" placeholder=" cm 単位" name="height"></td>
                           <tr>
                        <th></th>
                        <td><span id="checkheight"></span></td>
                        </tr>
                        </tr>
                        <tr>
                           <th>希望体重</th>
                           <td><input type="text" id="hopeweight"  placeholder=" kg 単位" name="hopeweight"></td>
                           <tr>
                        <th></th>
                        <td><span id="checkhope"></span></td>
                        </tr>                        
                        </tr>
                     </table>
                  </div>
                  <br><br>
                  <div class="btn">
                  <a href="#" onclick="signup()" id="signup"> <img src="resources/btn/signup.png" width="100" height="auto"></a> &nbsp;
                  <a href="start" id="cancel"><img src="resources/btn/cancel.png" width="100" height="auto"></a>
                     </div>
                 <span id="checksingup"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
               </form>
               
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

      //이미지가 완전히 로딩되는 데 시간이 걸림, 호출하고 바로 그리지 못하므로 onload를 이용한다. 
      background.src = "resources/png/blur.png";
      myImg.src = "resources/png/board.png";
      mylogo.src = "resources/png/logo.png";
      myImg.onload = function() {
         context.drawImage(background, 1, 1, 900, 500);
         context.drawImage(myImg, 125, 75, 630, 400);
         context.drawImage(mylogo, 360, 10, 200, 150);
         //(이미지 이름, x, y, width, height)
      }
   </script>
</body>
</html>