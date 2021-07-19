<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>



<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
	<meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=no;shrink-to-fit=no" name="viewport" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/style_signpage.css?ver=4">
	<link rel="stylesheet" type="text/css" href="/css/style_stamppage.css?ver=4">
	<title>Baronarin(Beta)</title>
</head>

<body>
	
<div id="Page" style="width: 100%;">
	<div id = "Controll_Layer">
		<nav class="navbar" style="display: flex;justify-content: space-between;align-items: center;padding: 8px 12px;max-height:80px;
		min-height:80px;">
		<a href="/">
			<img src = "img/google.png" style="height:80px"/>
		</a>
		
		<ul class="button_layer" style="display: flex;list-style : none; padding-left : 0;">
			<li> <a class="btn5" onclick="test()" style="cursor:pointer"> 도장 / 계약서 만들기 </a> </li>
			<li> <a onclick="alert('서비스 준비중입니다!')" class="btn5" style="cursor: pointer"> 자료실 </a> </li> 
			<li> <a onclick="alert('서비스 준비중입니다!')" class="btn5" style="cursor: pointer"> 고객센터 </a> </li>
			
				<sec:authorize access="isAnonymous()">
					<script>
						function announce(){
							window.open("/popup", "popup","width=700, height=450,left=30,top=30");
						}
						announce();
						</script>
					<li> <a target="_blank" href="/joinForm" class="btn7" style="cursor: pointer; text-decoration:none"> 회원가입 </a> </li>
					<li> <a href="/loginForm" class="btn6" style="cursor: pointer; text-decoration:none"> 로그인 </a> </li>
				</sec:authorize>
			
				<sec:authorize access="isAuthenticated()">
					<li style="margin-left:14px; margin-right:6px;"><sec:authentication property="principal.realname"/>님</li>
					<li><form action="/logout" method="POST">
				        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				        <a class="btn6"><button type="submit" class="btn6_sub" style="cursor: pointer; text-decoration:none;">로그아웃</button>
					</a></form></li>
				</sec:authorize>
			
	

			
			


			<script>
			function test()
			{
				document.getElementById("background_gray").style.display ="inline-block";
				document.getElementById("background_gray").style.position ="fixed";
				document.getElementById("first_layer").style.display = "inline-block";
				document.getElementById("second_layer").style.display = "none";
				document.getElementById('sign_Layer').style.display = "none";
				document.getElementById("black_div").style.display ="block";
			}
			</script>
		</ul>
		</nav>
	</div>

		<div id="black_div" style="display:none; position:fixed; left:0px; top:0px; background:rgba(28, 31, 38, 0.5); z-index:99; width:100%; height:100%;"></div>
		<div id = "background_gray" style="display:none">
			<a onclick ="close_div()" style="cursor:pointer; position:absolute; top:30px; right:30px;  width:20px; height:20px; padding:5px"><img src ="img/close.png" width=20px height=20px style="cursor:pointer"/></a>
			<a onclick ="prev_div()" style="position:absolute; top:30px; left:30px; width:11.48px; height:20px; padding:5px; cursor:pointer;"><img src ="img/next.png" width=11.48px height=20px style="cursor:pointer"/></a>

			<script>
			function close_div(){
				document.getElementById("background_gray").style.display = "none";
				document.getElementById("black_div").style.display ="none";
			}

			function prev_div(){
				if(document.getElementById("second_layer").style.display == "inline-block" && document.getElementById("first_layer").style.display == "none"){
					document.getElementById("first_layer").style.display = "inline-block"
					document.getElementById("second_layer").style.display = "none";
					document.getElementById('sign_Layer').style.display = "none";
					
				}
				if(document.getElementById("second_layer").style.display == "none" && document.getElementById("first_layer").style.display == "none"){
					document.getElementById("first_layer").style.display = "none"
					document.getElementById("second_layer").style.display = "inline-block";
					document.getElementById('sign_Layer').style.display = "none";
					
				}
			}
			</script>

			<div id = "first_layer" style="display:inline-block; position:absolute; top:50%; left:50%; transform:translate(-50%,-50%)">
				<a href="/user/DocumentPage"><img src = "img/test1.png" width=160px style="cursor:pointer"></a>
				<a onclick="next_Layer('first')"><img src = "img/test2.png" width=160px style="cursor:pointer"></a>
			</div>
			<script>
			function next_Layer(e){
				if(e == 'first'){
				document.getElementById("first_layer").style.display = "none";
				document.getElementById("second_layer").style.display = "inline-block";
				}
			} 
			</script>

			<div id = "second_layer" style="margin-top:140px; display:none;">
				
				<a onclick="expand_layer('sign_draw')"><img src = "img/test4.png" width=160px style="cursor:pointer"></a>
				<a onclick="expand_layer('sign_create')"><img src = "img/test5.png" width=160px style="cursor:pointer"></a>

				<script>
				function expand_layer(e){
					document.getElementById('second_layer').style.display = "none";
					document.getElementById('sign_Layer').style.display = "none";
					
					if(e == 'sign_create'){
						document.getElementById('sign_Layer').style.display = "inline-block";
						document.getElementById('create_sign_layer').style.display = "inline-block";
						document.getElementById('draw_sign_layer').style.display = "none";
						
						var ctx = document.getElementById("sign");
						ctx = ctx.getContext("2d");
						ctx.clearRect(0,0,ctx.canvas.width,ctx.canvas.height);
						initSign();
					}
					else if(e == 'sign_draw'){
						document.getElementById('sign_Layer').style.display = "inline-block";
						document.getElementById('create_sign_layer').style.display = "none";
						document.getElementById('draw_sign_layer').style.display = "block";
						initSign();
					}
				}
				</script>
			</div>

			<div id ="sign_Layer" style =" display:none">
				<div id = 'sign_background_white'>
					<div id = 'create_sign_layer' style="display:none;">
						<br><br><br>
						<input type ="text" maxlength="4" id = "sign_name" value="" style="padding-left:15px; outline:none; width: 317px; height: 45px; border: 1px solid #707070; border-radius: 30px;"/>
						<input type ="button" id ="input_sign_name" value="입력" onclick='createSign()' class ="button" style="width:99px; height:45px"/>
						<br><br><br>
					</div>
					<div id = 'draw_sign_layer' style="display:none">
						<br><br><br>
						<img src = "img/sign_example.png" width=180px/>
						<br><br><br>
					</div>
					<canvas id ="sign" width="429" height="201" style="border: 1px solid #767676; border-radius: 30px;"></canvas><br>
					<a href="#" style="font-family: 'SongganggasaB'"></a>
					<a href="#" style="font-family: 'BBTreeCB'"></a>
					<a href="#" style="font-family: 'TTSeokbosangjeolB'"></a>
					<br>
	
					<script>
					function createSign(){
						var ctx = document.getElementById("sign");
						ctx = ctx.getContext("2d");
						var name = document.getElementById("sign_name");
						var middle_width;
						var middle_height;
	
						ctx.clearRect(0,0,ctx.canvas.width,ctx.canvas.height);
						ctx.textBaseline = 'middle';
						ctx.font = '150px BBTreeCB';
						ctx.textAlign = 'center';
						ctx.fillStyle = "black";
						middle_width = ctx.canvas.width/2;
						middle_height = ctx.canvas.height/2;
						ctx.fillText(name.value, middle_width, middle_height);
					}
					</script>
				</div>
				<br>
				<input type="button" value="저장" onclick="saveSign()" class="button" style="height:45px; width:140px;">
				<input type="button" value="초기화" onclick="initSign()" class="button" style="height:45px; width:140px;">
	
				<div id ="sign_download_div" style="display:none">
					<a id="sign_download" href="" download="sign.png"></a>
				</div>
	
				<script type="text/javascript">
				function saveSign(){
					var a = document.getElementById("sign_download");
					a.click();
				}
	
				var
					canvas1=document.getElementById(
					"sign");
				document.getElementById("sign_download").addEventListener('click', event=>
					event.target.href = canvas1.toDataURL()); function initSign(){ var
					canvas = document.getElementById("sign");
					canvas.getContext("2d").clearRect(0,0,canvas.width,canvas.height);
					}
					</script>

					<script type="text/javascript">
				var pos = {
					drawbale: false,
					x:-1,
					y:-1
				};
				var canvas, ctx;
				window.onload = function(){
					canvas = document.getElementById("sign");
					ctx = canvas.getContext("2d");
	
					canvas.addEventListener("mousedown",listener);
					canvas.addEventListener("mousemove",listener);
					canvas.addEventListener("mouseup",listener);
					canvas.addEventListener("mouseout",listener);
				}
	
				function listener(event){
					if(document.getElementById('draw_sign_layer').style.display == "block"){
						switch(event.type){
						case "mousedown":
							initDraw(event);
							break;
						case "mousemove":
							if(pos.drawable)
								draw(event);
							break;
						case "mouseout":
						case "mouseup":
							finishDraw();
							break;
						}
					}
				}
	
				function initDraw(event){
					ctx.beginPath();
					pos.drawable = true;
					var coors = getPosition(event);
					pos.X = coors.X;
					pos.Y = coors.Y;
					ctx.moveTo(pos.X, pos.Y);
				}
	
				function draw(event){
					var coors = getPosition(event);
					ctx.lineWidth = 5;
					ctx.lineTo(coors.X, coors.Y);
	
					pos.X = coors.X;
					pos.Y = coors.Y;
					ctx.stroke();
				}
	
				function finishDraw(){
					pos.drawable = false;
					pos.X = -1;
					pos.Y = -1;
				}
	
				function getPosition(event){
					var x = event.offsetX + 2;
					var y = event.offsetY + 2;
					return {X:x, Y:y}

				}
				</script>
			</div>

			
		</div>
	</div>

	<div style="position:absolute;top:10px;">

	<!-- <img src = "img/web1.jpg" style="width:100%; height:100%"/> -->
	<img src = "img/web1.jpg" style="width:100%;"/>
	<img src = "img/web2.jpg" style="width:100%;"/>
	<img src = "img/web3.png" style="width:100%;"/>
</div>
</body>
</html>