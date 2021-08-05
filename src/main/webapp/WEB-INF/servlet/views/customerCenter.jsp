<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
		<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
			<%@ page import="org.springframework.security.core.Authentication" %>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   

				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="utf-8">
					<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
					<!--  <meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=no;shrink-to-fit=no" name="viewport" />-->
					<link rel="stylesheet" type="text/css" href="/css/style.css">
					<link rel="stylesheet" type="text/css" href="/css/style_customercenter.css">
					
					<link rel="stylesheet" type="text/css" href="/css/style_signpage.css?ver=4">
					<link rel="stylesheet" type="text/css" href="/css/style_stamppage.css?ver=4">
					<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
					<title>고객센터</title>
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
									
									
									<li> <a onclick="location.href='/board'" class="btn5" style="cursor: pointer"> 자료실
										</a> </li>
									<li> <a onclick="location.href='/customerCenter'" class="btn5" style="cursor: pointer"> 고객센터
										</a> </li>

									<sec:authorize access="isAnonymous()">
										<li> <a href="/joinForm" class="btn7"
												style="cursor: pointer; text-decoration:none"> 회원가입 </a> </li>
										<li> <a href="/loginForm" class="btn6"
												style="cursor: pointer; text-decoration:none"> 로그인 </a> </li>
									</sec:authorize>

									<sec:authorize access="isAuthenticated()">
										<li style="margin-left:14px; margin-right:6px;"><a href="/user/myPage" class="btn5" style="cursor: pointer">마이페이지</a></li>
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
									document.getElementById("black_div2").style.display ="none";
								}
							</script>
							
							<div id = "sub_layer1">
								일련번호
							</div>
							
								<form method="post" action="#" id="checkIndex">
									<div id = "sub_layer2">
										<input type="text" name="index" maxlength="30" placeholder="번호" id="sub_layer2_input"><br/>
									</div>
									<div id = "sub_layer3">
										<a href="#" class="sub_layer3_btn" style="cursor: pointer; text-decoration:none"> 확인 </a>
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
						<div
						style="position:absolute;top: 143px;left: 328px;text-align: left;font: normal normal bold 48px/64px Noto Sans KR;letter-spacing: -1.2px;color: #191919;opacity: 1;">
						고객센터</div>
						<div style="position: absolute;top: 222px;left: 320px;">
							<hr style="height: 5px;width: 1280px;border-radius: 10px; background-color: #245AE3;">
						</div>
						<div
						style="position: absolute;top: 242px;left: 320px;text-align: left;font: normal normal normal 17px/23px Noto Sans KR;letter-spacing: -0.42px;color: #000000;opacity: 1;">
						바로날인 서비스 이용에 도움을 드립니다. </div>
						
						  <div class="col-lg-12" style="position: absolute;width:100px;top: 360px;left: 1380px;text-align: right;text-align: end; padding:20px 40px;">
                                <a href="/user/editor"><button type="submit" class="site-btn">문의 업로드</button></a>
                            </div>
						
						<div style="position: absolute;top: 412px;left: 396px;">
							<hr style="height: 2px;width: 1127px;background-color: #191919;">
						</div>

						<div style="position: absolute;top: 427px;">
							<div class="cus_title"
								style="left:447px;width:100px;">
								<p>No</p></div>
							<div class="cus_title"
								style="left:915px;width:100px;">
								<p>제목</p>
							</div>
							<div class="cus_title"
								style="left:1267px;width:100px;">
								<p>작성자</p>
							</div>
						</div>
						<div style="position: absolute;top: 480px;left: 396px;">
							<hr style="height: 1px;width: 1127px;background-color: #191919;">
						<!-- 여기가 실제 문의사항 부분!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<script>
                     	
                                          function secretpost(id)
                                          {
                                        	
                                        	var pass = prompt('비밀번호를 입력하세요','');  
                                        	
                                        	var alldata = {"id": id, "pass":pass};

                                        	
                                        	$.ajax(
                                        	{
                                        				async: true,
                                        				type : 'GET',
                                        				datatype: 'json',
                                        				data: alldata,
                                        				url: "/checkCustomerPass",
                                        				contentType: "application/json; charset=UTF-8",
                                        				
                                        				success: function(success)
                                        				{
                                        					if(success=='success')
                                        						{
                                        						alert('확인되었습니다.');
                                        						document.getElementById('id_input').value = id;
                                        						$("#submitpost").submit();
                                        						}
                                        					else
                                        						{
                                        						alert('비밀번호가 일치하지 않습니다.');
                                        						}
                                        				},
                                        	
                                        				error: function()
                                        				{
                                        					alert('Error');
                                        				}
                                        				
                                        			});
                                        	
                                        		
                                          }
                           
                                          function post(id)
                                          {
                                        	  	document.getElementById('id_input').value = id;
                                        		$("#submitpost").submit();
                                          }
                                          
                           </script>
						
						
						 <c:set var="id_num" value="1"/>
						 <c:set var="adder" value="15"/>
                             <c:forEach items="${postlist.content}" var="data">
                               		 
                                        
                                        

			                             
			                             <div>
											<!-- 바로 아랫 줄 top 수정 +70px-->
											<div class="cus_body" style="top:${adder}px;left:47px;width:100px;">
												<p>${id_num}</p>
											</div>
											
											<c:choose>
	                                        <c:when  test="${data.secretcheck eq 'on'}">

	                                       	 
	                                       	 <!-- 바로 아랫 줄 top 수정 +70px-->
											<div class="cus_body" style="top:${adder + 17}px;left:163px;width:13px;height:12px;">
												<img src="/img/lock.svg" alt="잠금">
											</div>
											<!-- 바로 아랫 줄 top 수정 +70px-->
											<div class="cus_body" style="top:${adder}px;left:214px;width:400px;">
												<p><a onclick="secretpost(`${data.id}`)" class="btn5"> 비밀글입니다.</a>
												
												<c:if test="${!empty data.admincomment}">
													<span id="admin_comment${id_num}" style="color:#245AE3; font:normal normal bold 14px/20px Noto Sans KR">+답변
													</span>
												</c:if>
												</p>
											</div>
	                                        </c:when>
	                                        
	                                        <c:otherwise>
	                                        <div class="cus_body" style="visibility:hidden;top:${adder + 17}px;left:163px;width:13px;height:12px;">
												<img src="/img/lock.svg" alt="잠금">
											</div>
											<!-- 바로 아랫 줄 top 수정 +70px-->
											<div class="cus_body" style="top:${adder}px;left:214px;width:400px;">
												<p><a onclick="post(`${data.id}`)" class="btn5"> ${data.title}</a>
												
												<c:if test="${!empty data.admincomment}">
													<span id="admin_comment${id_num}" style="color:#245AE3; font:normal normal bold 14px/20px Noto Sans KR">+답변
													</span>
												</c:if>
												</p>
											</div>


											
											
	                                        </c:otherwise>
	                                        
	                                       
	                                        
                                        </c:choose>
											
									
											
											
											
											
											<!-- 바로 아랫줄 top 수정 +70px-->
											<div class="cus_body" style="top:${adder}px;left:875px;width:400px;">
												<p>${data.realname}</p>
											</div>
											<!-- 바로 아랫줄 top 수정 +70px-->
											<div style="position: absolute;top: ${adder + 55}px;">
												<hr style="height: 1px;width: 1127px;background-color: #191919;">
											</div>
																	
										</div>
                                         
                                       
                              		<c:set var="id_num" value="${id_num + 1}"/>
                              		<c:set var="adder" value="${adder+70}"/>
                                </c:forEach>
					
						
						
							

						<!-- 반복 끝 아래는 +70씩 하면 된다는 걸 보여줌-->
							

							<!-- 가장 마지막 기준 top에 +140px ex)현재 top: 350px; 기준 +140px-->
							
							
							<div style="position: absolute; top:490px; left:460px; display:flex; justify-content:space-around;">
							<c:if test="${!postlist.first}">

		<a style="text-decoration: none;color: #191919;" href="?page=${postlist.number-1}"><span style="margin-right:30px;font-size:18px;">이전</span></a>

	</c:if>          
		<c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i">
			<c:choose>
				<c:when test="${postlist.pageable.pageNumber+1 == i}">
					
					<div class="numbering"> <a class="current-page" style="text-decoration: none;color: #191919;font-size:18px;font-weight:bold" href="?page=${i-1}">${i}</a></div>
					
				</c:when>
				<c:otherwise>
					
					<div class="numbering"><a class="page-link" style="text-decoration: none;color: #191919;font-size:18px;font-weight:medium" href="?page=${i-1}">${i}</a></div>
					
				</c:otherwise>
			</c:choose>
		</c:forEach>

                        	 
	
	<c:if test="${!postlist.last}">

		<a style="text-decoration: none;color: #191919;" href="?page=${postlist.number+1}"><span style="margin-right:30px;font-size:18px;">다음</span></a>

	</c:if>
								
							</div>
							
							
							
							
						<!-- 아래 </div>는 내용을 감싸는 것이므로 지우지 않도록 주의.-->
						</div>


						

<form action="/user/customerShowpost" method="post" id="submitpost">
                                        <input name="id" type="hidden" id="id_input">
                             </form>



						
						




				</body>

				</html>