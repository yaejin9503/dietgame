var canvas = document.getElementById("myCanvas"); 
var ctx = canvas.getContext("2d");
var ctxW = ctx.canvas.width; 
var ctxH = ctx.canvas.height; 

var keysDown = {}; // keyboard 움직일 때 쓰는 json 

var lastUpdateTime =0; 
var acDelta =0; 
var msPerFrame = 1000; 

var bool_bg = false; //이미지 나타나게 할 때 쓰는 것  
var bool_fighter = false; 

var bool_laser = false; 
var lasers = []; //배열로 선언해서 이미지를 배열에 담음   
var laserTotal =10; //레이저의 갯수 

var hamburger = {}; //jason으로 넣음 
var bool_hamburger = false; 

var bool_hamburgerexplosion = false; 
var bool_explode = false; 
var hitexplosion = {}; 
var bool_hitexplosion = false; 
var spriteCount = 1;

var score =0; //초기 점수 설정 
var lives =2 ; //목숨 값 

var isGameover = false; 

var gameOverSound = new Audio("resources/sounds/coin.mp3");
gameOverSound.loop = true ; 
gameOverSound.volum = .25; 
gameOverSound.load();


var speed = 0;
var randScale; //격파해야할 객체의 크기를 정함 
var ang = 0;  // 회전할 각도 
var arrScale = [0.4,0.6,0.8,1]; //운석이 변할 크기를 배열로 선언
hamburger.x = canvas.width;  // hamburger의 x좌표는 canvas.width임 = 900이라는 얘기 
//var a = Math.random( );
//--> 0.87299384062057   0 (0 은 포함)에서 1미만의 이런 긴 소수들을 뱉는다.
hamburger.y = Math.floor(Math.random()*350); //Math.floor는 나온 소수점을 버린다는 얘기, 


var hamburgerImage = new Image();  //적기 햄버거 이미지 객체선언을 한다. 
hamburgerImage.src = "resources/food/hamburger.png"; //이미지의 주소값이 해당 주소값이 되고 
hamburgerImage.onload = function(){ //이미지를 로드하면 
	bool_hamburger = true; //false 였던 bool_hamburger을 true로 바꿔줌. 
}

var bgImage = new Image(); //배경이미지 
bgImage.src = "resources/png/background.png";

bgImage.onload = function(){
	bool_bg = true; 
	//ctx.drawImage(bgImage,0,0,900,500);
}

var boy = {};  //메인 케릭터인 boy를 json으로 선언해준다. 
boy.x = 50; //초기 boy의 x좌표는 50으로 설정해둔다. 
boy.y = canvas.height / 2; //y좌표는 canvas의 높이의 반 좌표로 중심이 되게 한다. 
boy.speed = 10; //speed값은 10으로 

var boyImage = new Image(); // 
boyImage.src = "resources/png/man33.png";

boyImage.onload = function(){
	bool_fighter = true; //이 함수는 나중에 이미지를 불러올 때 true일 때만 불러오게 된다. 
	//false였던 bool_fighter을 true로 만든다. 
	//ctx.drawImage(boyImage,boy.x,boy.y,85,100);
}

var laserImage = new Image(); 
laserImage.src = "resources/png/raser.png";
laserImage.onload = function(){
	bool_laser = true; //위에 이미지들과 마찬가지임. 
}

//arrScale에서 원하는 값을 랜덤으로 리턴해 줄 shuffle 함수를 선언한다.
function shuffle(arr){  
	var rand = Math.floor((Math.random() * arr.length));
	return arr[rand];
}

//운석값을 초기화 할 함수
//운석값이 화면에 하나씩 나타날 때마다 크기가 다르게 날라오게 되는데
var reset =function(){  
	speed = Math.floor(Math.random() * 5) + 5; //운석의 스피드를 결정함 movehamburger쪽에 들어감 
	
	hamburger.x = canvas.width; 
	hamburger.y = Math.floor(Math.random()* 350);
	
	//햄버거가 너무 밑으로 너무 위로 가지 않게 하기 위한 함수 
	//?? 왜냐 위에서 랜덤 값으로 위치를 지정해줬는데 밑에 if문이 없으면 아무데나 다 생성 되게 되서 캔버스 안에 생성이 안될 수도 있음 . 
	if(hamburger.y < 40){
		hamburger.y =40; 
	}
	if(hamburger.y >360){
		hamburger.y =360;
	}
	
	//위에서 햄버거의 위치를 캔버스 안에서 잡아 주고, 크기는 randScale에 shuffle 함수를 넣어 마무리 해줌 
	randScale = shuffle(arrScale); 
}

//충돌처리를 하는 함수 
function detextCollision(){
	var aw = hamburgerImage.width * randScale; //이미지 값에 * 셔플로 돌려 랜덤하게 생성된 randScale을 곱해줌. 
	var ah = hamburgerImage.height * randScale; // 위와 같음.
	var bw = boyImage.width; //boy이미지의 가로값을 bw로 지정해주고 
	var bh = boyImage.height; //boy이미지의 세로값을 bh로 지정해준다.

	ctx.strokeStyle = "white"; 
	ctx.lineWidth = 2; 
	ctx.strokeRect(boy.x, boy.y, bw, bh);
	ctx.strokeRect(hamburger.x,hamburger.y,aw,ah);
	//이미지의 경계선을 보여주는 함수--> 경계선을 보고 싶다면 주석을 해제해서 보면 된다.
	
	/*
	hamburger.x = canvas.width; 
	hamburger.y = Math.floor(Math.random()* 350);
	boy.x = 50; //초기 boy의 x좌표는 50으로 설정해둔다. 
	boy.y = canvas.height / 2; //y좌표는 canvas의 높이의 반 좌표로 중심이 되게 한다. 
	var aw = hamburgerImage.width * randScale; //이미지 값에 * 셔플로 돌려 랜덤하게 생성된 randScale을 곱해줌. 
	var ah = hamburgerImage.height * randScale; // 위와 같음.
	var bw = boyImage.width; //boy이미지의 가로값을 bw로 지정해주고 
	var bh = boyImage.height; //boy이미지의 세로값을 bh로 지정해준다.
	
	*/
	
	//boy, hamburger collision 
	if((boy.x > hamburger.x && boy.x < hamburger.x + aw //boy가 계속 움직여서 x좌표의 값이 바뀌게 되는데 그 때 boy의 x좌표값이 hamburger의 x좌표값보다 크고, 
		&& boy.y > hamburger.y && boy.y < hamburger.y + ah)  || // boy가 계속 움직이면서 y좌표의 값이 바뀜, boy.y는 
		(boy.x + bw > hamburger.x && boy.x + bw < hamburger.x + aw &&
		boy.y > hamburger.y && boy.y < hamburger.y + ah) || 
		(boy.x > hamburger.x && boy.x < hamburger.x + aw 
		&& boy.y +bh > hamburger.y && boy.y + bh < hamburger.y + ah) || 
		(boy.x + bw > hamburger.x && boy.x + bw < hamburger.x + aw 
		&& boy.y +bh > hamburger.y && boy.y + bh < hamburger.y + ah)&&
		(boy.x < hamburger.x && boy.x + bw > hamburger.x
		/*&& boy.y +bh > hamburger.y && boy.y + bh < hamburger.y + ah*/)){
		
		bool_hamburgerexplosion = true; 
		bool_explode = true; 
		bool_hitexplosion = true; 
		//hitexplosion.x = 
		reset(); // 햄버거 초기화 하는거 
		resetFigher(); //boy 초기화 하는거  
		
		//생명 수치 표시 
		if(lives <=0){
			lives = 0; 
			gameover();
		}else{
			--lives; 
		}
		$("#lives").text(lives);
	}
	
	
	//laser collision																	
	if(lasers.length){ //스페이스를 누를 때만 진행됨. //[boy.x + 50, boy.y +10]
		for(var i =0; i<lasers.length; i++){   //레이저와 운석의 좌표 범위를 계산하여 15번 콘솔에서 hit문자를 출력한다. 
			if(lasers[i][0] > hamburger.x && lasers[i][0] < hamburger.x +aw &&
				lasers[i][1] > hamburger.y && lasers[i][1] < hamburger.y +ah ){
					lasers.splice(i,1); //충돌한 레이저를 배열에서 삭제한다. 
					reset(); //운석의 좌표를 다시 초기화 한다. 
					$("#score").text(Number($("#score").text())+100);
			}
		}
	}
}

//게임 오버 화면 
function gameover(){
	isGameover= true;
	bool_explode = false;
	//$(".myAudio").removeClass("sound-on").addClass("sound-off");
	//$(".myAudio").trigger("pause");
	/*$(".myAudio").prop("currentTime",0);
	var isSoundOn = $(".sound").hasClass("sound-on");
	if(isSoundOn){
		gameOverSound.currentTime = 0; 
		gameOverSound.play();
	}
*/	$("#game-over").css("display","block");
}

//게임 리스타트 
function restart(){
	isGameover =false;
	bool_explode = true;
	
	/*if($(".sound").hasClass("sound-on")){
		$(".myAudio").trigger("play");
	}else{
		$(".myAudio").trigger("pause");
	}
	gameOverSoundd.currentTime =0 ;
	gameOverSound.Pause();
*/
	$("#game-over").css("display","none");
	lives =2;
	score = 0;
	$("#lives").text(lives);
	$("#score").text(score);
}

function movehamburger() {
	var w = hamburgerImage.width * randScale;
	var h = hamburgerImage.height * randScale;
	ctx.drawImage(hamburgerImage,hamburger.x-=speed,hamburger.y,w,h);
	
	if(hamburger.x <= -100){ //프레임이 -100일 때 사라짐
		reset();
		gameover();
	}
}

var Background = function(){
	this.x =0, this.y =0; 
	
	this.render =function(){
		ctx.drawImage(bgImage,this.x,0,900,500);
	};
};



function drawLaser(){
	if(lasers.length){ //스페이스바를 누른 횟수 
		for(var i =0; i <lasers.length;i++){ //한 번 누르면, 한 번 그려지고 이런 형식 
			ctx.drawImage(laserImage,lasers[i][0],lasers[i][1]);
		}
	}
}

//lasers 

function moveLaser(){
	//lasers.length 라는 것이 스페이스 입력 횟수 
	for(var i =0; i< lasers.length; i++){ //한번 눌렀을 때 
		console.log("meme : " + lasers[i][0]);
		if(lasers[i][0] > 0){ 
			lasers[i][0] +=20; //스피드  
		}
		if(lasers[i][0]>800){
			lasers.splice(i,1); //x좌표값이 600이 넘어가면 그림을 없애라 이말 
		}
	}
}

function resetFigher(){ //충돌 했을 때 boy 위치 초기화
	boy.x = 0; 
	boy.y = canvas.height/2; 
}

var render = function(){
	var delta = Date.now() - lastUpdateTime; 
 	if(acDelta > msPerFrame){
		acDelta =0; 
		
		if(bool_bg){
			background.render();
		}
		if(bool_laser){
			 drawLaser();
			 moveLaser();
		}
		if(bool_fighter){
			if(bool_hamburgerexplosion ===true){
				ctx.drawImage(boyImage,boy.x +=1 ,boy.y);
				if(boy.x >=50){
					bool_hamburgerexplosion = false; 
				}
			}
		else{
			ctx.drawImage(boyImage,boy.x,boy.y);
			}
		}
		if(bool_hamburger){
			movehamburger();
		}
	}else{
		acDelta += delta;
	}
}

var update =function(){
	//up
	if(38 in keysDown){
		boy.y -=boy.speed; 
		boyOffset = 0;
	}
	//down
	if(40 in keysDown){
		boy.y +=boy.speed;
		boyOffset = 0;
	}
	//left
	if(37 in keysDown){
		boy.x -=boy.speed;
		boyOffset = 200;
	}
	//right 
	if(39 in keysDown){
		boy.x +=boy.speed;
		boyOffset = 400;
	}
	//boundery limit 
	if(boy.x <=45){
		boy.x =45;
	}
	if(boy.x >= 810){
		boy.x = 810;
	}
	if(boy.y <=10){
		boy.y = 10;
	}
	if(boy.y >=390){
		boy.y = 390;
	}

	detextCollision();
}

addEventListener("keydown",function(e){
	keysDown[e.keyCode] = true;
	if(e.keyCode ===32 && lasers.length <= laserTotal){ //스페이스를 누르고, 스페이스 횟수가 레이저 토탈보다 작을 때 (10번 이하일 때 )
		lasers.push([boy.x + 50, boy.y +10]); //laser배열에 보이의 x좌표값, 보이의 y좌표값 +10을 넣어줌 
	}
},false);

addEventListener("keyup",function(e){
	delete keysDown[e.keyCode];
},false);

$("#restart").click(function(){
	restart();
})

var main = function(){
	update();
	if(!isGameover){
		render();
	}
	requestAnimationFrame(main);
};
$("#lives").text(lives);
var background = new Background();

main();
reset();