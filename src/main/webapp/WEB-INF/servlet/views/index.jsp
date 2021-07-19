<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
		<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
			<%@ page import="org.springframework.security.core.Authentication" %>



				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="utf-8">
					<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
					<!--  <meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=no;shrink-to-fit=no" name="viewport" />-->
					<link rel="stylesheet" type="text/css" href="/css/style.css">
					<link rel="stylesheet" type="text/css" href="/css/style_signpage.css?ver=4">
					<link rel="stylesheet" type="text/css" href="/css/style_stamppage.css?ver=4">
					<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
					<title>Baronarin(Beta)</title>
				</head>

				<body>

					<div id="Page" style="width: 100%;">
						<div id="Controll_Layer">
							<nav class="navbar" style="display: flex;justify-content: space-between;align-items: center;padding: 8px 12px;max-height:80px;
		min-height:80px;">
								<a href="/">
									<img src="/img/google.png" style="height:80px" />
								</a>

								<ul class="button_layer" style="display: flex;list-style : none; padding-left : 0;">
									
									<li> <a class="btn5" onclick="test()" style="cursor:pointer"> 계약서 / 서명 만들기 </a>
									</li>
									<li> <a onclick="location.href='/board'" class="btn5" style="cursor: pointer"> 자료실
										</a> </li>
									<li> <a onclick="location.href='/customerCenter'" class="btn5" style="cursor: pointer"> 고객센터
										</a> </li>

									<sec:authorize access="isAnonymous()">
										<script>
											function announce() {
												window.open("/popup", "popup", "width=700, height=450,left=30,top=30");
											}
											announce();
										</script>
										<li> <a href="/joinForm" class="btn7"
												style="cursor: pointer; text-decoration:none"> 회원가입 </a> </li>
										<li> <a href="/loginForm" class="btn6"
												style="cursor: pointer; text-decoration:none"> 로그인 </a> </li>
									</sec:authorize>

									<sec:authorize access="isAuthenticated()">
										<li style="margin-left:14px; margin-right:6px;"><a href="/user/myPage" class="btn5" style="cursor: pointer">마이페이지</a></li>
										<li><a class="btn5" onclick="test2()" style="cursor:pointer">일련번호</a></li>
										<li>
											<form action="/logout" method="POST">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
												<a class="btn6"><button type="submit" class="btn6_sub"
														style="cursor: pointer; text-decoration:none;">로그아웃</button>
												</a>
											</form>
										</li>
										
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
										
										function test2()
										{
											console.log("check1");
											document.getElementById("background_gray2").style.display ="inline-block";
											document.getElementById("background_gray2").style.position ="fixed";
											document.getElementById("first_layer2").style.display = "inline-block";
											//document.getElementById("second_layer").style.display = "none";
											//document.getElementById('sign_Layer').style.display = "none";
											document.getElementById("black_div").style.display ="block";
										}
										
									</script>
								</ul>
							</nav>
						</div>

						<div id="black_div"
							style="display:none; position:fixed; left:0px; top:0px; background:rgba(28, 31, 38, 0.5); z-index:99; width:100%; height:100%;">
						</div>
						
						<div id ="background_gray2" style="display:none">
							<a onclick ="close_div2()" style="cursor:pointer; position:absolute; top:30px; right:30px;  width:20px; height:20px; padding:5px"><img src ="img/close.png" width=20px height=20px style="cursor:pointer"/></a>
						
							<script>
								function close_div2(){
									document.getElementById("background_gray2").style.display = "none";
									document.getElementById("black_div").style.display ="none";
								}
							</script>
							
							<div id = "sub_layer1">
								일련번호
							</div>
							
							
							<form action="/user/Documentcomplete2" method="post" id="completed_submit1">
											
											<input type="hidden" name="serialnum" id="serial_num">
											
										</form>
							
							
							
							
								<form method="post" action="#" id="checkIndex">
									<div id = "sub_layer2">
										<input type="text" name="index" maxlength="30" placeholder="번호" id="sub_layer2_input"><br/>
									</div>
									<div id = "sub_layer3">
										<a onclick="serialtest()" class="sub_layer3_btn" style="cursor: pointer; text-decoration:none" id="submit_serial"> 확인 </a>
										
										
										
										
										<script>
										function serialtest()
										{
											var serial = document.getElementById('sub_layer2_input').value;
											
											
											$.ajax({
												async: true,
												type : 'GET',
												url: "/user/serial",
												data: {serial: serial},
												datatype:"json",
												contentType: "application/json; charset=UTF-8",
												success: function(res)
											{
													if(res=='' || res==undefined )
														{
														alert("해당 일련번호에 접근할 수 없습니다.");
														}
													
													else
														{
														document.getElementById('serial_num').value = serial;
														
														alert('일련번호가 확인되었습니다');
														$('#completed_submit1').submit();
														
														//var serial = "계약서 : "+res.paper+"\n계약파일명 : "+res.filename+"\n갑 : " + res.per1;
														
														//if(res.per2!='' && res.per2 != undefined)
														//	serial = serial + "\n을 : " + res.per2;
														//if(res.per3!='' && res.per3!=undefined)
														//	serial = serial + "\n병 : " + res.per3;
														//alert(serial);
														}
											},
											error: function()
											{
												alert('Error');
											}
											
											
											
											});
											
											
										}
										
										</script>
									</div>
								</form>
								
								
						</div>
						<div id="background_gray" style="display:none">
							<a onclick="close_div()"
								style="cursor:pointer; position:absolute; top:30px; right:30px;  width:20px; height:20px; padding:5px"><img
									src="img/close.png" width=20px height=20px style="cursor:pointer" /></a>
							<a onclick="prev_div()"
								style="position:absolute; top:30px; left:30px; width:11.48px; height:20px; padding:5px; cursor:pointer;"><img
									src="img/next.png" width=11.48px height=20px style="cursor:pointer" /></a>

							<script>
								function close_div() {
									document.getElementById("background_gray").style.display = "none";
									document.getElementById("black_div").style.display = "none";
								}

								function prev_div() {
									if (document.getElementById("second_layer").style.display == "inline-block" && document.getElementById("first_layer").style.display == "none") {
										document.getElementById("first_layer").style.display = "inline-block"
										document.getElementById("second_layer").style.display = "none";
										document.getElementById('sign_Layer').style.display = "none";
										document.getElementById('stamp_Layer').style.display = "none";

									}
									if (document.getElementById("second_layer").style.display == "none" && document.getElementById("first_layer").style.display == "none") {
										document.getElementById("first_layer").style.display = "none"
										document.getElementById("second_layer").style.display = "inline-block";
										document.getElementById('sign_Layer').style.display = "none";
										document.getElementById('stamp_Layer').style.display = "none";

									}
								}
							</script>

							<div id="first_layer"
								style="display:inline-block; position:absolute; top:50%; left:50%; transform:translate(-50%,-50%)">
								<a href="/user/DocumentPage"><img src="img/test1.png" width=160px
										style="cursor:pointer"></a>
								<a onclick="next_Layer('first')"><img src="img/test2.png" width=160px
										style="cursor:pointer"></a>
							</div>
							<script>
								function next_Layer(e) {
									if (e == 'first') {
										document.getElementById("first_layer").style.display = "none";
										document.getElementById("second_layer").style.display = "inline-block";
									}
								}
							</script>

							<div id="second_layer" style="margin-top:140px; display:none;">

								<a onclick="expand_layer('sign_draw')"><img src="img/test4.png" width=160px
										style="cursor:pointer"></a>
								<a onclick="expand_layer('stamp')"><img src="img/test3.png" width=160px
										style="cursor:pointer"></a>

								<script>
									function expand_layer(e) {
										document.getElementById('second_layer').style.display = "none";
										document.getElementById('sign_Layer').style.display = "none";
										document.getElementById('stamp_Layer').style.display = "none";
										if (e == 'sign_draw') {
											document.getElementById('sign_Layer').style.display = "inline-block";
											document.getElementById('create_sign_layer').style.display = "none";
											document.getElementById('draw_sign_layer').style.display = "block";
											initSign();
										}
										else if (e == 'stamp') {
											document.getElementById('stamp_Layer').style.display = "inline-block";
											document.getElementById("stamp_clear").style.display = "none";
										}

									}
								</script>
							</div>

							<div id="sign_Layer" style=" display:none">
								<div id='sign_background_white'>
									<div id='create_sign_layer' style="display:none;">

									</div>
									<div id='draw_sign_layer' style="display:none">
										<br><br><br>
										<img src="img/sign_example.png" width=180px />
										<br><br><br>
									</div>
									<canvas id="sign" width="429" height="201"
										style="border: 1px solid #767676; border-radius: 30px;"></canvas><br>
									<br>

									<script>
										function createSign() {
											var ctx = document.getElementById("sign");
											ctx = ctx.getContext("2d");
											var name = document.getElementById("sign_name");
											var middle_width;
											var middle_height;

											ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
											ctx.textBaseline = 'middle';
											ctx.font = '150px BBTreeCB';
											ctx.textAlign = 'center';
											ctx.fillStyle = "black";
											middle_width = ctx.canvas.width / 2;
											middle_height = ctx.canvas.height / 2;
											ctx.fillText(name.value, middle_width, middle_height);
										}
									</script>
								</div>
								<br>
								<input type="button" value="저장" onclick="saveSign()" class="button"
									style="height:45px; width:140px;">
								<input type="button" value="초기화" onclick="initSign()" class="button"
									style="height:45px; width:140px;">

								<div id="sign_download_div" style="display:none">
									<a id="sign_download" href="" download="sign.png"></a>
								</div>

								<script type="text/javascript">
									function saveSign() {
										var a = document.getElementById("sign_download");
										a.click();
									}

									var
										canvas1 = document.getElementById(
											"sign");
									document.getElementById("sign_download").addEventListener('click', event =>
										event.target.href = canvas1.toDataURL()); function initSign() {
											var
												canvas = document.getElementById("sign");
											canvas.getContext("2d").clearRect(0, 0, canvas.width, canvas.height);
										}
								</script>

								<script type="text/javascript">
									var pos = {
										drawbale: false,
										x: -1,
										y: -1
									};
									var canvas, ctx;
									window.onload = function () {
										canvas = document.getElementById("sign");
										ctx = canvas.getContext("2d");

										canvas.addEventListener("mousedown", listener);
										canvas.addEventListener("mousemove", listener);
										canvas.addEventListener("mouseup", listener);
										canvas.addEventListener("mouseout", listener);
										canvas.addEventListener("touchstart", listener);
										canvas.addEventListener("touchmove", listener);
										canvas.addEventListener("touchend", listener);
										canvas.addEventListener("touchcancel", listener);
									}

									function listener(event) {
										if (document.getElementById('draw_sign_layer').style.display == "block") {
											switch (event.type) {
												case "mousedown":
													initDraw(event);
													break;
												case "touchstart":
													mobile_initDraw(event);
													break;
												case "mousemove":
													if (pos.drawable)
														draw(event);
													break;
												case "touchmove":
													if (pos.drawable) {
														event.preventDefault();
														mobile_draw(event);
													}
													break;
												case "mouseout":
												case "mouseup":
												case "touchend":
												case "touchcancel":
													finishDraw();
													break;
											}
										}
									}

									function initDraw(event) {
										ctx.beginPath();
										pos.drawable = true;
										var coors = getPosition(event);
										pos.X = coors.X;
										pos.Y = coors.Y;
										ctx.moveTo(pos.X, pos.Y);
									}

									function mobile_initDraw(event) {
										ctx.beginPath();
										pos.drawable = true;
										var coors = mobile_getPosition(event);
										pos.X = coors.X;
										pos.Y = coors.Y;
										ctx.moveTo(pos.X, pos.Y);
									}

									function draw(event) {
										var coors = getPosition(event);
										ctx.lineWidth = 0.5;
										ctx.lineTo(coors.X, coors.Y);
										pos.X = coors.X;
										pos.Y = coors.Y;
										ctx.stroke();
									}

									function mobile_draw(event) {
										var coors = mobile_getPosition(event);
										ctx.lineWidth = 0.5;
										ctx.lineTo(coors.X, coors.Y);
										pos.X = coors.X;
										pos.Y = coors.Y;
										ctx.stroke();
									}


									function finishDraw() {
										pos.drawable = false;
										pos.X = -1;
										pos.Y = -1;
									}


									function getPosition(event) {
										var target = event.target || event.srcElement,
											rect = target.getBoundingClientRect(),
											offsetX = event.clientX - rect.left,
											offsetY = event.clientY - rect.top;
										return { X: offsetX, Y: offsetY }
									}

									function mobile_getPosition(event) {
										var touches = event.changedTouches;
										var target = event.target || event.srcElement,
											rect = target.getBoundingClientRect(),
											offsetX = touches[0].clientX - rect.left,
											offsetY = touches[0].clientY - rect.top;
										//alert("x" + offsetX + "y" + offsetY);
										return { X: offsetX, Y: offsetY }
									}
								</script>
							</div>
							<div id='stamp_Layer' style="display:none">
								<div id='stamp_background_white'>
									<br><br><br>
									<input type="text" id="name" value=""
										style="padding-left:15px; outline:none; width: 317px; height: 45px; border: 1px solid #707070; border-radius: 30px;" />
									<input type="button" id="input_stamp_name" value="만들기" onclick='createStamp()'
										class="button" style="width:99px; height:45px" />
									<br><br><br>
									<div style="font: normal normal normal 16px/21px Noto Sans KR;">만들기를 누르시고 도장을 클릭하시면
										다운로드 됩니다.</div>
									<br><br>
									<div id="stamp_clear">
										<canvas id="ctx1" width="120" height="120"
											style="margin-right:20px; border:1px solid black; display:none; cursor:pointer; cursor:hand"
											onclick="download_stamp(this)"></canvas>
										<canvas id="ctx2" width="120" height="120"
											style="border:1px solid black; display:none; cursor:pointer; cursor:hand"
											onclick="download_stamp(this)"></canvas>
										<canvas id="ctx3" width="120" height="120"
											style="margin-left:20px; border:1px solid black; display:none; cursor:pointer; cursor:hand"
											onclick="download_stamp(this)"></canvas>

									</div>

									<br><br>





									<a href="#" style="font-family: 'SongganggasaB'"></a>
									<a href="#" style="font-family: 'BBTreeCB'"></a>
									<a href="#" style="font-family: 'TTSeokbosangjeolB'"></a>
									<a href="" id="ctx_down" style="display:none"
										download="stamp.png">stamp_download</a>

									<script>
										stamp_canvas = new Array();
										stamp_canvas[0] = new Array();

										for (var j = 0; j < 3; j++) {
											var name = "ctx" + (j + 1);
											stamp_canvas[0][j] = document.getElementById(name);
										}

										function download_stamp(e) {
											document.getElementById("ctx_down").addEventListener('click', event => event.target.href = e.toDataURL());
											document.getElementById("ctx_down").click();
										}

										function createStamp() {
											console.log(stamp_canvas);
											document.getElementById("stamp_clear").style.display = "inline";
											stamp_canvas[0][0].style.display = "none";
											stamp_canvas[0][1].style.display = "none";
											stamp_canvas[0][2].style.display = "none";

											var name = document.getElementById("name");
											switch (name.value.length) {
												case 1: draw_vertical(stamp_canvas[0][0], name, 1); break;
												case 2: draw_vertical(stamp_canvas[0][0], name, 2); break;
												case 3: draw_vertical(stamp_canvas[0][0], name, 3); draw_ver_hor(stamp_canvas[0][1], name, 3); break;
												case 4: draw_ver_hor(stamp_canvas[0][1], name, 4); break;
												default: alert("1~4");
											}
										}

										function drawSquare(ctx, cx, cy, width, height) {
											ctx.strokeStyle = "red";
											ctx.lineWidth = 4;
											ctx.strokeRect(cx - width / 2, cy - height / 2, width, height);
										}

										function drawEllipse(ctx, cx, cy, width, height) {
											var PI2 = Math.PI * 2;
											var ratio = height / width;
											var radius = Math.max(width, height) / 2;
											var increment = 1 / radius;

											ctx.strokeStyle = "red";
											ctx.lineWidth = 4;
											ctx.beginPath();
											var x = cx + radius * Math.cos(0);
											var y = cy - ratio * radius * Math.sin(0);
											ctx.lineTo(x, y);

											for (var radians = increment; radians < PI2; radians += increment) {
												var x = cx + radius * Math.cos(radians);
												var y = cy - ratio * radius * Math.sin(radians);
												ctx.lineTo(x, y);
											}

											ctx.closePath();
											ctx.stroke();
										}

										function draw_vertical(ctx, name, length) {
											ctx.style.display = "inline";
											ctx = ctx.getContext("2d");
											var middle_width;
											var middle_height;

											ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
											ctx.textBaseline = 'middle';
											ctx.font = '25pt TTSeokbosangjeolB';
											ctx.textAlign = 'center';
											ctx.fillStyle = "red"

											switch (length) {
												case 1:
													middle_width = ctx.canvas.width / 2;
													middle_height = ctx.canvas.height / 2;
													console.log(middle_height);
													ctx.fillText(name.value[0], middle_width, middle_height);
													break;
												case 2:
													middle_width = ctx.canvas.width / 2;
													middle_height = ctx.canvas.height / 2;
													console.log(middle_height);
													ctx.fillText(name.value[0], middle_width, middle_height - 19);
													ctx.fillText(name.value[1], middle_width, middle_height + 19);
													break;
												case 3:
													middle_width = ctx.canvas.width / 2;
													middle_height = ctx.canvas.height / 2;
													console.log(middle_height);
													ctx.fillText(name.value[0], middle_width, middle_height - 36);
													ctx.fillText(name.value[1], middle_width, middle_height);
													ctx.fillText(name.value[2], middle_width, middle_height + 36);
													break;
											}
											drawEllipse(ctx, middle_width, middle_height, 31, 59);
										}

										function draw_ver_hor(ctx, name, length) {
											ctx.style.display = "inline";
											ctx = ctx.getContext("2d");
											var middle_width;
											var middle_height;
											ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);

											ctx.textBaseline = 'middle';
											ctx.font = '25pt TTSeokbosangjeolB';
											ctx.textAlign = 'center';
											ctx.fillStyle = "red"

											var copy_ctx = stamp_canvas[0][2];
											copy_ctx.style.display = "inline";
											copy_ctx = copy_ctx.getContext("2d");
											copy_ctx.clearRect(0, 0, copy_ctx.canvas.width, copy_ctx.canvas.height);
											copy_ctx.textBaseline = 'middle';
											copy_ctx.font = '25pt TTSeokbosangjeolB';
											copy_ctx.textAlign = 'center';
											copy_ctx.fillStyle = "red"
											switch (length) {
												case 3:
													middle_width = ctx.canvas.width / 2;
													middle_height = ctx.canvas.height / 2;
													ctx.fillText(name.value[0] + name.value[1], middle_width, middle_height - 19);
													ctx.fillText(name.value[2] + "인", middle_width, middle_height + 19);

													middle_width = copy_ctx.canvas.width / 2;
													middle_height = copy_ctx.canvas.height / 2;
													copy_ctx.fillText(name.value[0] + name.value[1], middle_width, middle_height - 19);
													copy_ctx.fillText(name.value[2] + "인", middle_width, middle_height + 19);
													break;
												case 4:
													middle_width = ctx.canvas.width / 2;
													middle_height = ctx.canvas.height / 2;
													ctx.fillText(name.value[0] + name.value[1], middle_width, middle_height - 19);
													ctx.fillText(name.value[2] + name.value[3], middle_width, middle_height + 19);

													middle_width = copy_ctx.canvas.width / 2;
													middle_height = copy_ctx.canvas.height / 2;
													copy_ctx.fillText(name.value[0] + name.value[1], middle_width, middle_height - 19);
													copy_ctx.fillText(name.value[2] + name.value[3], middle_width, middle_height + 19);
													break;
											}
											drawEllipse(ctx, middle_width, middle_height, 95, 95);
											drawSquare(copy_ctx, middle_width, middle_height, 78, 78);
										}
									</script>





								</div>
							</div>


						</div>

						<div style="position:absolute;top:10px;">

							<!-- <img src = "img/web1.jpg" style="width:100%; height:100%"/> -->
							<img src="img/web1.jpg" style="width:100%;" />
							<img src="img/web2.jpg" style="width:100%;" />
							<img src="img/web3.png" style="width:100%;" />
						</div>
				</body>

				</html>