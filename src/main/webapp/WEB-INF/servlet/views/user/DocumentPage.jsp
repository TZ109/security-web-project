<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
		<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
			<%@ page import="org.springframework.security.core.Authentication" %>

				<!DOCTYPE html>
				<html>

				<head>
					<title>Baronarin(Beta)</title>
					<meta charset="UTF-8">
					<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
					<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
					<link rel="stylesheet" type="text/css" href="/css/style.css?ver=1">
					<link rel="stylesheet" type="text/css" href="/css/style_documentpage2.css?ver=1">
					<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

					<link rel="stylesheet" type="text/css" href="/css/style.css?ver=5">
					<link rel="stylesheet" type="text/css" href="/css/style_signpage.css?ver=4">
					<link rel="stylesheet" type="text/css" href="/css/style_stamppage.css?ver=4">

					<script type="text/javascript">
						function dataURItoBlob(dataURI) {
							var byteString = atob(dataURI.split(',')[1]);
							var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0]
							var ab = new ArrayBuffer(byteString.length);
							var ia = new Uint8Array(ab);
							for (var i = 0; i < byteString.length; i++) {
								ia[i] = byteString.charCodeAt(i);
							}
							var bb = new Blob([ab], { "type": mimeString });
							return bb;
						}
						add_file = 0;
						max_index = 0;
						cur = 0;
						img_source = new Array();
						imgs = new Array();
						pdf_url = "";
						Num = 0;
						const timer = ms => new Promise(res => setTimeout(res, ms))
					</script>

					<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
					<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
					<script src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.auto.js"></script>
					<script src="//mozilla.github.io/pdf.js/build/pdf.js"></script>

					<style>
						.button {
							outline: none;
							text-align: center;
							font: normal normal normal 15pt/16pt Noto Sans CJK KR;
							letter-spacing: -0.3px;
							font-size: 10pt;
							color: #FFFFFF;
							border: 4px;
							padding-top: 4px;
							padding-bottom: 4px;
							padding-left: 13.5px;
							padding-right: 13.5px;
							background: #245ae3 0% 0% no-repeat padding-box;
							border-radius: 50px;
							cursor: pointer;
							margin: 2px;
						}
					</style>
				</head>

				<body>
					<div id="Page" style="width: 100%; height:100%">
						<div id="Controll_Layer">
							<nav class="navbar" style="display: flex;justify-content: space-between;align-items: center;padding: 8px 12px;max-height:80px;
		min-height:80px;">
								<a href="/">
									<img src="/img/google.png" style="height:80px" />
								</a>

								<div style="white-space: nowrap;">쉽고 빠른 전자계약, 바로날인</div>

								<input type="hidden" value="${isValidUser}" id="is_valid_user">

							</nav>
							<script>
								function test() {
									document.getElementById("background_gray").style.display = "inline-block";
									document.getElementById("background_gray").style.position = "fixed";
									document.getElementById("second_layer").style.display = "inline-block";
									document.getElementById('sign_Layer').style.display = "none";
									document.getElementById('stamp_Layer').style.display = "none";
									document.getElementById("black_div").style.display = "block";
								}
							</script>
						</div>

						<div id="black_div"
							style="display:none; position:fixed; left:0px; top:0px; background:rgba(28, 31, 38, 0.5); z-index:99; width:100%; height:100%;">
						</div>
						<div id="background_gray" style="display:none">
							<a onclick="close_div()" style="position:absolute; top:30px; right:30px"><img
									src="/img/close.png" width=20px height=20px style="cursor:pointer" /></a>
							<a onclick="prev_div()" style="position:absolute; top:30px; left:30px"><img
									src="/img/next.png" width=11.48px height=20px style="cursor:pointer" /></a>

							<script>
								function close_div() {
									document.getElementById("background_gray").style.display = "none";
									document.getElementById("black_div").style.display = "none";
								}

								function prev_div() {
									if (document.getElementById("second_layer").style.display == "none") {
										document.getElementById("second_layer").style.display = "inline-block";
										document.getElementById('sign_Layer').style.display = "none";
										document.getElementById('stamp_Layer').style.display = "none";
									}

								}
							</script>

							<div id="second_layer" style="margin-top:140px; display:none;">

								<a onclick="expand_layer('sign_draw')"><img src="/img/test4.png" width=160px
										style="cursor:pointer"></a>
								<a onclick="expand_layer('stamp')"><img src="/img/test3.png" width=160px
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
										<img src="/img/sign_example.png" width=180px />
										<br><br><br>
									</div>

									<form action="/user/changesign" method="post" id="changingSign">

										<input type="file" style="display:none" name="uploadFile">
										<canvas id="sign" width="429" height="201"
											style="border: 1px solid #767676; border-radius: 30px;"></canvas><br>
										<br>
									</form>



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
								<input type="button" value="등록" onclick="saveSign()" class="button"
									style="height:45px; width:140px;">
								<input type="button" value="초기화" onclick="initSign()" class="button"
									style="height:45px; width:140px;">







								<script type="text/javascript">
									function saveSign() {
										var canvas1 = document.getElementById("sign");
										var imgDataUrl = canvas1.toDataURL('image/png');

										var blobBin = atob(imgDataUrl.split(',')[1]);	// base64 데이터 디코딩
										var array = [];
										for (var i = 0; i < blobBin.length; i++) {
											array.push(blobBin.charCodeAt(i));
										}
										var file = new Blob([new Uint8Array(array)], { type: 'image/png' });	// Blob 생성

										var formdata = new FormData();
										formdata.append("file", file);


										$.ajax({
											async: true,
											type: 'POST',
											url: '/user/changesign',
											data: formdata,
											dataType: "json",
											processData: false,	// data 파라미터 강제 string 변환 방지!!
											contentType: false,	// application/x-www-form-urlencoded; 방지!!
											success: function (result) {
												if (result == 0) {
													document.getElementById("input_sign").src = "/img/sign_off.svg";
													document.getElementById("input_sign_ancher").onclick = null;
													document.getElementById("background_gray").style.display = "none";
													document.getElementById("black_div").style.display = "none";
													alert('서명 변경성공');
												}



											},
											error: function () {
												alert('서명 변경실패');
											}

										});


									}







									function initSign() {
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
										var valid = $('#is_valid_user').val();

										if (valid == -1) {
											alert('회원가입하지 않은 인원이 있거나\n회원 정보가 일치하지 않습니다.');

										}
										else
											{
											window.open("/popup_document", "popup_document", "width=700, height=450,left=30,top=30");
											}

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
									<div style="font: normal normal normal 16px/21px Noto Sans KR;">만들기를 누르시고 도장을
										클릭하시면
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
												default: alert("4자 이내로 입력해 주세요.");
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








						<div id="black_information_div" style="display:none;">
						</div>
						<script>
							document.getElementById("black_information_div").addEventListener("mousedown", function () {
								document.getElementById("black_information_div").style.display = "none";
							});
						</script>


						<div id="Root" style="height:100%">

							<div id="controller_background_gray">
								<div id="title_background">
									<br>
									<input id="temp_title" type="text" name="title" placeholder="계약서 제목을 입력해주세요."
										maxlength="20"
										style="font: normal normal bold 25px/15px Noto Sans KR;font-size:30px;text-align: center;border:none;width:800px;border-right:0px; border-top:0px; border-left:0px; border-bottom:0px;"
										size="20">
								</div>
								<div id="remote_2">


									<br>
									<div style="font: normal normal normal 16px/30px Noto Sans KR;margin-bottom:10px;">
										서명 인원 선택</div>
									<input id="btn1" type="button" onclick="getNum(1)" value="1명" class="button" disabled style="display:none">
									<input id="btn2" type="button" onclick="getNum(2)" value="2명" class="button">
									<input id="btn3" type="button" onclick="getNum(3)" value="3명" class="button"><br>
									<script type="text/javascript">
										//2명,3명의 button을 누르면 도장 이미지 추가
										function getNum(a) {
											Num = a;
											var btn1 = document.getElementById("btn1");
											var btn2 = document.getElementById("btn2");
											var btn3 = document.getElementById("btn3");

											document.getElementById("input").style.visibility = "visible";

											if (a == 1) {
												btn2.style.background = "#e8eaef";
												btn3.style.background = "#e8eaef";
												$('#sign_num_count').val(1);
											}
											else if (a == 2) {
												btn1.style.background = "#e8eaef";
												btn3.style.background = "#e8eaef";
												$('#sign_num_count').val(2);
											}
											else if (a == 3) {
												btn1.style.background = "#e8eaef";
												btn2.style.background = "#e8eaef";
												$('#sign_num_count').val(3);
											}
											btn1.disabled = 'disabled';
											btn2.disabled = 'disabled';
											btn3.disabled = 'disabled';
										}

										function show_init() {


											if (Num == 1) {
												document.getElementById("first_Sign_View").style.display = "block";
											}
											else if (Num == 2) {
												document.getElementById("first_Sign_View").style.display = "block";
												document.getElementById("second_Sign_View").style.display = "block";
												document.getElementById("plus2").style.visibility = "visible";

											}
											else if (Num == 3) {
												btn1.style.background = "#e8eaef";
												btn2.style.background = "#e8eaef";
												document.getElementById("first_Sign_View").style.display = "block";
												document.getElementById("second_Sign_View").style.display = "block";
												document.getElementById("third_Sign_View").style.display = "block";
												document.getElementById("plus2").style.visibility = "visible";
												document.getElementById("plus3").style.visibility = "visible";
											}
											document.getElementById("other_View").style.display = "block";
										}
									</script>
									<br>
									<div id="input" style="display:flex;justify-content: center;visibility:hidden">
										<input id="input_doc" type="image" src="/img/document_on.png"
											style="" onclick="click_inputfile(this)" />
										
									</div>


									<br>


									<script type="text/javascript">
										//문서를 이미지로 불러오고, img의 src가 img_source에 저장되고 fisrt canvas에 저장됨
										function click_inputfile(target) {
											var inputfile = document.getElementById("inputfile").click();
										}

										function FiletoImg(files) {
											max_index = files.length;
											for (var i = 0; i < files.length; i++) {
												imgs[i] = files[i]; //imgs에 file로 저장
												img_source[i] = new Image();
												save_src(imgs[i], i);
											}

											var file = files[0];
											if (!file.type.match(/image.*/) && !file.type.match(/application.pdf/)) {
												alert("not image of pdf file!");
											}
											else if (file.type.match(/image.*/)) {
												document.getElementById("input_doc").src = "/img/document_off.png";
												document.getElementById("input_doc").disabled = 'disabled';
												document.getElementById("init").style.display = "flex";

												show_init();
												document.getElementById("black_information_div").style.display = "block";
												var reader = new FileReader();
												reader.onload = function (e) {
													var img = new Image();
													img.onload = function () {
														var ctx0 = document.getElementById("first").getContext("2d");
														ctx0.drawImage(img, 0, 0, ctx0.canvas.width, ctx0.canvas.height);
													}
													img.src = e.target.result;
												}
												reader.readAsDataURL(file);
											}
											else if(file.type.match(/application.pdf/)){
												document.getElementById("input_doc").src = "/img/document_off.svg";
												document.getElementById("input_doc").disabled = 'disabled';
												document.getElementById("init").style.display = "flex";
											}
										}

										//FiletoImg에 필요함
										function save_src(image, i) {
											var reader = new FileReader();
											reader.readAsDataURL(image);
											reader.onload = function (e) {
												if (image.type.match(/image.*/)) {
													//if file is jpg
													console.log("file is jpg");
													img_source[i].src = e.target.result;
												}
												//if file is jpg end
												else if (image.type.match(/application.pdf/)) {
													//if file is pdf
													var canvas = document.getElementById('first');
													var ctx = canvas.getContext('2d');

													ctx.font = '60px';
													ctx.textAlign = 'center';
													ctx.fillText("로딩중입니다 잠시만 기다려 주세요", ctx.canvas.width / 2, 20);

													console.log("file is pdf");

													document.getElementById("input").disabled = 'disabled';

													pdf_url = e.target.result;
													get_pdf_pages_num();
												}
											}
										}

										async function get_pdf_pages_num() {
											// Loaded via <script> tag, create shortcut to access PDF.js exports.
											var pdfjsLib = window['pdfjs-dist/build/pdf'];

											// The workerSrc property shall be specified.
											pdfjsLib.GlobalWorkerOptions.workerSrc = '//mozilla.github.io/pdf.js/build/pdf.worker.js';

											// Asynchronous download of PDF
											var loadingTask = pdfjsLib.getDocument(pdf_url);
											loadingTask.promise.then(async function (pdf) {
												console.log('PDF numpages loaded');
												max_index = pdf.numPages;
												console.log(max_index);
												console.log("show_pdf start");
												var flag = 0;
												for (cur = 0; cur < max_index; cur++) {
													//show_pdf();
													if (flag == 1) {
														cur = 0;
														break;
													}
													img_source[cur] = new Image();
													var loadingTask = pdfjsLib.getDocument(pdf_url);
													loadingTask.promise.then(async function (pdf) {
														console.log(pdf);
														console.log("cur is");
														console.log(cur);
														console.log('PDF loaded');
														// Fetch the first page
														var pageNumber = cur + 1;
														console.log("pageNumber is");
														console.log(pageNumber);

														pdf.getPage(pageNumber).then(async function (page) {
															console.log('Page loaded');
															var scale = 1;
															var viewport = page.getViewport({ scale: scale });

															scale = 1122 / viewport.height;
															viewport = page.getViewport({ scale: scale });
															console.log(viewport);

															// Prepare canvas using PDF page dimensions
															document.getElementById("download_div").style.visibility = "visible";
															var canvas = document.getElementById('download_test');
															var context = canvas.getContext('2d');

															// Render PDF page into canvas context
															var renderContext = {
																canvasContext: context,
																viewport: viewport
															};
															var renderTask = page.render(renderContext);
															renderTask.promise.then(async function () {
																window.scroll(0, 0);
																console.log('Page rendered');
																html2canvas($("#download_div")[0], { width: document.getElementById("download_test").width, scale: 1 }).then(async function (canvas) {
																	var myImage = canvas.toDataURL("image/jpeg", 1.0);
																	console.log("page number is");
																	console.log(pageNumber);
																	console.log("page is");
																	console.log(page);
																	console.log("my Image is");
																	console.log(myImage);
																	saveloadURI(myImage);

																	if (cur >= max_index - 1) {
																		flag = 1;
																		cur = 0;
																		console.log("cur is end");
																		show_init();
																		document.getElementById("black_information_div").style.display = "block";
																		var canvas = document.getElementById('first');
																		var ctx = canvas.getContext('2d');
																		ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
																		// var file = img_source[0];
																		var img = new Image();
																		img.src = img_source[0].src;
																		console.log(img);
																		img.onload = function () {
																			var ctx0 = document.getElementById("first").getContext("2d");
																			ctx0.drawImage(img, 0, 0, ctx0.canvas.width, ctx0.canvas.height);
																		}
																	}

																});
															});
														});
													}, function (reason) {
														// PDF loading error
														console.error(reason);
													});
													await timer(1000);
												}
											});
										}
									</script>
									<br>

									<form action="/user/makeSign" method="post" id="submit_form"
										enctype="multipart/form-data">
										<div id="first_Sign_View"
											style="display:none;background-image:url(/img/참여자뒷배경.png);background-size:auto">
											<br>
											<div style="text-align:center"> 갑 </div>
											<br>
											
											<sec:authorize access="isAuthenticated()">
												<sec:authentication property="principal" var="principal" />
											<div class="input_row"><input type="text" id="name1" placeholder="이름" value="${principal.realname}" readonly
													style="background-image:url(/img/이름뒷배경.png);background-size:auto;border:none;border-right:0px; border-top:0px; border-left:0px; border-bottom:0px;"
													name="name1" size="20"></div>
											<div class="input_row"><input type="text" id="email1" value="${principal.username}" readonly
													style="background-image:url(/img/이메일뒷배경.png);background-size:auto;border:none;border-right:0px; border-top:0px; border-left:0px; border-bottom:0px;"
													placeholder="이메일" name="email1" size="20"></div>
											</sec:authorize>
											<br>
											
										</div>

										<div id="second_Sign_View"
											style="display:none;background-image:url(/img/참여자뒷배경.png);background-size:auto">
											<br>
											<div style="text-align:center">을</div>
											<br>
											<div class="input_row"><input type="text" id="name2" placeholder="이름"
													style="background-image:url(/img/이름뒷배경.png);background-size:auto;border:none;border-right:0px; border-top:0px; border-left:0px; border-bottom:0px;"
													name="name2" size="20"></div>
											<div class="input_row"><input type="text" id="email2"
													style="background-image:url(/img/이메일뒷배경.png);background-size:auto;border:none;border-right:0px; border-top:0px; border-left:0px; border-bottom:0px;"
													placeholder="이메일" name="email2" size="20"></div>
											<br>
										</div>


										<div id="third_Sign_View"
											style="display:none;background-image:url(/img/참여자뒷배경.png);background-size:auto">
											<br>
											<div style="text-align:center">병</div>
											<br>
											<div class="input_row"> <input type="text" id="name3"
													style="background-image:url(/img/이름뒷배경.png);background-size:auto;background-size:auto;border:none;border-right:0px; border-top:0px; border-left:0px; border-bottom:0px;"
													placeholder="이름" name="name3" size="20"></div>
											<div class="input_row"> <input type="text" id="email3"
													style="background-image:url(/img/이메일뒷배경.png);background-size:auto;background-size:auto;border:none;border-right:0px; border-top:0px; border-left:0px; border-bottom:0px;"
													placeholder="이메일" name="email3" size="20"></div>
											<br>
										</div><br>

										<div id="other_View" style="display:none">
											<p style="font: normal normal bold 15px/15px Noto Sans KR;">페이지 이동</p>
											<br>
											<input type="button" style="padding-left: 20px;padding-right: 20px;padding-top: 7px;padding-bottom: 7px;" value="<" onclick="prevImg()" class="button" />
											<input type="button" style="padding-left: 20px;padding-right: 20px;padding-top: 7px;padding-bottom: 7px;" value=">" onclick="nextImg()" class="button" /><br>
											<br>
											<input id="btnout" style="padding-left: 20px;padding-right: 20px;padding-top: 7px;padding-bottom: 7px;" type="button" onclick="location.href='/'" value="취소"
												class="button">
											<input id="btnin" style="padding-left: 20px;padding-right: 20px;padding-top: 7px;padding-bottom: 7px;" type="button" value="승인 요청" onclick="sub_btnin()"
												class="button">
											<input style="display:none;" multiple="multiple" type="file"
												name="uploadFile" id="inputfile" onchange="FiletoImg(this.files)"
												class="button">
											<input id="sign_num_count" type="hidden" name="signNum">
											<input id="sign_title" type="hidden" name="title">


										</div>
											<input type="hidden" id="p1_coordinate" name="per1[]">
											<input type="hidden" id="p2_coordinate" name="per2[]">
											<input type="hidden" id="p3_coordinate" name="per3[]">



										<script type="text/javascript">
											function sub_btnin() {

												if ($('#temp_title').val() == '') {
													alert('계약서 제목을 입력하십시오.');
													return false;
												}

												var n1 = document.getElementById('name1').value;
												var n2 = document.getElementById('name2').value;
												var n3 = document.getElementById('name3').value;




												var e1 = document.getElementById('email1').value;
												var e2 = document.getElementById('email2').value;
												var e3 = document.getElementById('email3').value;


												switch (Num) {
													case 1:
														if (n1 == '') {

															alert('빈칸에 이름을 입력하십시오.');
															return false;
														}
														break;
													case 2:
														if (!n1 || !n2) {
															alert('빈칸에 이름을 입력하십시오.');
															return false;
														}
														break;
													case 3:
														if (!n1 || !n2 || !n3) {
															alert('빈칸에 이름을 입력하십시오.');
															return false;
														}
												}

												switch (Num) {
													case 1:
														if (!e1) {
															alert('빈칸에 이메일을 입력하십시오.');
															return false;
														}
														break;
													case 2:
														if (!e1 || !e2) {
															alert('빈칸에 이메일을 입력하십시오.');
															return false;
														}
														break;
													case 3:
														if (!e1 || !e2 || !e3) {
															alert('빈칸에 이메일을 입력하십시오.');
															return false;
														}
												}



												if (Num == 2) {
													if (e1 == e2) {
														alert('이메일을 중복하여 사용할 수 없습니다.');
														return false;
													}
												}

												if (Num == 3) {
													if (e1 == e2) {
														alert('이메일을 중복하여 사용할 수 없습니다.');
														return false;
													}
													if (e1 == e3) {
														alert('이메일을 중복하여 사용할 수 없습니다.');
														return false;
													}
													if (e3 == e2) {
														alert('이메일을 중복하여 사용할 수 없습니다.');
														return false;
													}
												}
	
												var p1_result = document.getElementById("p1_coordinate").value;
												var p2_result = document.getElementById("p2_coordinate").value;
												var p3_result = document.getElementById("p3_coordinate").value;
												
												
												
												if(p1_result=='' || p1_result=='-1,-1')
													{
													alert("갑의 서명위치를 설정하십시오.");
													return false;
													}
												if(Num>=2 && (p2_result=='' || p2_result=='-1,-1'))
												{
												alert("을의 서명위치를 설정하십시오.");
												return false;
												}
												if(Num==3 && (p3_result=='' || p3_result=='-1,-1'))
												{
												alert("병의 서명위치를 설정하십시오.");
												return false;
												}
												
												alert('신청되었습니다.');

												$('#sign_title').val($('#temp_title').val());


												//server_file=document.getElementById("inputfile");
												$('#submit_form').submit();
											}



											function del_add_img_layer() {
												for (var i = 0; i < add_file; i++) {
													var test = document.getElementById(i + "add_img");
													test.remove();
													test = document.getElementById(i + "img");
													test.remove();
												}
												add_file = 0;
											}
											//button을 누르면 nextImg
											function nextImg() {
												del_add_img_layer();

												console.log(img_source);

												cur++;
												console.log(cur);
												if (cur >= max_index)
													cur = 0;

												var ctx0 = document.getElementById("first").getContext("2d");
												var img = new Image();
												img.src = img_source[cur].src;
												console.log(img.src);
												img.onload = function () {
													ctx0.drawImage(img, 0, 0, ctx0.canvas.width, ctx0.canvas.height);
												}
											}

											function prevImg() {
												//모든 도장 삭제
												del_add_img_layer();

												console.log(img_source);

												cur--;
												console.log(cur);
												if (cur <= -1)
													cur = max_index - 1;

												var ctx0 = document.getElementById("first").getContext("2d");
												var img = new Image();
												img.src = img_source[cur].src;
												console.log(img.src);
												img.onload = function () {
													ctx0.drawImage(img, 0, 0, ctx0.canvas.width, ctx0.canvas.height);
												}
											}
										</script>


									</form>
									<script>
										function drag_stamp(e) {
											var y = window.scrollY;
											console.log(e);
											var tmp = "<img id =\"" + add_file + "add_img" + "\" width=\"64\" style=\"image-rendering: auto; transform:scale(1); position:absolute; left:75px; top:" + y + "px; cursor:pointer; cursor:hand\" onmousedown=\"startDrag(event, this)\" border=\"0\">";
											console.log(tmp);
											$("#controller").append(tmp);
											tmp = "<input type=\"file\" id=\"" + add_file + "img" + "\" style=\"display: none\">";
											console.log(tmp);
											$("#add").append(tmp);

											var img_name = add_file + "add_img";
											console.log(img_name);
											document.getElementById(img_name).src = e.toDataURL();
											add_file++;
										}
									</script>

									<script>
										function load_stamp(e, num) {
											e.style.background = "#e8eaef";
											e.disabled = 'disabled';
											switch (num) {
												case 1: document.getElementById("inputfile1").click(); break;
												case 2: document.getElementById("inputfile2").click(); break;
												case 3: document.getElementById("inputfile3").click(); break;
											}
										}

										function SigntoImg(files, Num) {
											var file = files[0];
											if (!file.type.match(/image.*/)) {
												alert("not image file!");
											}
											var reader = new FileReader();
											reader.onload = function (e) {
												var img = new Image("image/jpeg", 1.0);
												img.onload = function () {
													var stamp
													if (Num == 1)
														stamp = document.getElementById("first_Sign").getContext("2d");
													if (Num == 2)
														stamp = document.getElementById("second_Sign").getContext("2d");
													if (Num == 3)
														stamp = document.getElementById("third_Sign").getContext("2d");

													stamp.drawImage(img, 0, 0, stamp.canvas.width, stamp.canvas.height);
												}
												img.src = e.target.result;
											}
											reader.readAsDataURL(file);
										}
									</script>
								</div>

								<div id="controller_background_white">
									<div id="capture_layer">
										<div id="controller"
											style="margin-left:20px;margin-top:20px;width:793px; height:1122px;">
											<canvas id="first" width="793px" height="1122px"></canvas>
											<script type="text/javascript">
												//first의 canvas 설정
												var $canvas = document.querySelector('#first');
												$canvas.globalCompositeOperation = "source-over"; // 덮어 씌우기 가능
											</script>
										</div>
									</div>
								</div>


								<div id="remote_1" style="display:flex;flex-direction:column;justify-content:center;">
									<div id="init" style="display:none;flex-direction:column;align-items: center;justify-content:center;">

										
										<br><input type="button" style="width:auto;padding-left: 20px;padding-right: 20px;padding-top: 7px;padding-bottom: 7px;" value="갑 서명 위치"
										onclick="add_img_layer('sign',0); this.onclick=null;"  class="button" /><br>
										<br><input type="button" id="plus2" style="width:auto;visibility: hidden;padding-left: 20px;padding-right: 20px;padding-top: 7px;padding-bottom: 7px;"
											value="을 서명 위치" onclick="add_img_layer('sign',1); this.onclick=null;"  class="button" /><br>
										<br><input type="button" id="plus3" style="width:auto;visibility: hidden;padding-left: 20px;padding-right: 20px;padding-top: 7px;padding-bottom: 7px;"
											value="병 서명 위치" onclick="add_img_layer('sign',2); this.onclick=null;"  class="button" /><br>

									</div>
								</div>



								<script type="text/javascript">
									//이미지 레이어 추가하기
									var stamp = [[400, 10], [530, 10], [660, 10]];
									var stamp_index = -1;
									function print_console() {
										for (var i = 0; i < 3; i++) {
											alert('(1은 갑 / 2는 을 / 3은 병) stamp' + (i + 1) + 'left = ' + stamp[i][0] + ' top = ' + stamp[i][1]);
										}
									}
									function add_img_layer(e, s_index) {
									
										stamp_index = s_index;
										var mysign; //들어갈 싸인
										switch(stamp_index) {
											case 0: //갑 싸인
												mysign = "/img/temp/참여자1사인.png";
												break; 
											case 1: //을 싸인
												mysign = "/img/temp/참여자2사인.png";
												break;
											case 2: //병 싸인
												mysign = "/img/temp/참여자3사인.png";
												break;
											default:
												alert("스탬프 개수 에러");
												break;
										}
										var y = stamp[stamp_index][1];
										console.log(e);
										if (e == 'stamp')
											var tmp = "<img id =\"" + add_file + "add_img" + "\" width=\"64\" style=\"image-rendering: auto; transform:scale(1); position:absolute; left:"+stamp[stamp_index][0]+"px; top:" + y + "px; cursor:pointer; cursor:hand\" onmousedown=\"startDrag(event, this)\" border=\"0\">";
										else
											var tmp = "<img id =\"" + add_file + "add_img" + "\" width=\"128\" style=\"image-rendering: auto; transform:scale(1); position:absolute; left:"+stamp[stamp_index][0]+"px; top:" + y + "px; cursor:pointer; cursor:hand\" onmousedown=\"startDrag(event, this)\" border=\"0\">";
										console.log(tmp);
										$("#controller").append(tmp);
										tmp = "<input type=\"image\" id=\"" + add_file + "img" + "\" src= " + mysign + " >";
																				
										var img = new Image();
										var name = add_file + "add_img";

										var imageDiv = document.getElementById("controller");
										var _transform = imageDiv.style.transform;
										imageDiv.style.setProperty("transform", "none");
										var target_img = document.getElementById(name);
										target_img.src = mysign;
										target_img.index = stamp_index;
										img.src = mysign;

										console.log(tmp);
										$("#add").append(tmp);
										document.getElementById(add_file + "img").click();
										add_file++;
										
										switch(Num)
										{
										case 3:
										document.getElementById("p3_coordinate").value=stamp[2];
										case 2:
										document.getElementById("p2_coordinate").value=stamp[1];

										case 1:
										document.getElementById("p1_coordinate").value=stamp[0];

										console.log(document.getElementById("p1_coordinate").value);
										}
									}
								</script>
								<script type="text/javascript">
									//이미지 레이어 추가하고 움직이기
									var img_L = 0;
									var img_T = 0;
									var targetObj;
									

									function getLeft(o) {
										return parseInt(o.style.left.replace('px', ''));
									}

									function getTop(o) {
										return parseInt(o.style.top.replace('px', ''));
									}

									// 이미지 움직이기
									function moveDrag(e) {
										var e_obj = window.event ? window.event : e;
										var dmvx = parseInt(e_obj.clientX + img_L);
										var dmvy = parseInt(e_obj.clientY + img_T);
										if(dmvx >= 774 || dmvy >= 1159 || dmvx <= -1 || dmvy <= -1) {
											targetObj.style.left = "30px";
											targetObj.style.top = "30px";
										}
										else {
											targetObj.style.left = dmvx + "px";
											targetObj.style.top = dmvy + "px";
										}
										return false;
									}

									// 드래그 시작
									function startDrag(e, obj) {

										targetObj = obj;
										var e_obj = window.event ? window.event : e;
										img_L = getLeft(obj) - e_obj.clientX;
										img_T = getTop(obj) - e_obj.clientY;

										document.onmousemove = moveDrag;
										document.onmouseup = stopDrag;
										if (e_obj.preventDefault) e_obj.preventDefault();
									}

									// 드래그 멈추기
									function stopDrag() {
										document.onmousemove = null;
										document.onmouseup = null;
										if(targetObj.style.left.indexOf('-') != -1 || targetObj.style.top.indexOf('-') != -1) { //DB에 -1, -1인 경우는 안들어가게 설정 필요										
											stamp[targetObj.index][0] = -1;
											stamp[targetObj.index][1] = -1;
										}		
										else { //정상적인 좌표를 받으면 출력
											stamp[targetObj.index][0] = targetObj.style.left;
											stamp[targetObj.index][1] = targetObj.style.top;
										}
										
										
										switch(stamp_index)
										{
										case 2:
										document.getElementById("p3_coordinate").value=stamp[stamp_index];
										break;
										
										case 1:
										document.getElementById("p2_coordinate").value=stamp[stamp_index];
										break;
										
										case 0:
										document.getElementById("p1_coordinate").value=stamp[stamp_index];

										console.log(document.getElementById("p1_coordinate").value);
										}
										//alert("드래그 멈추기");
									}

								</script>

					<script type="text/javascript">
					//controller에 있는 first canvas위의 정보를 저장함
					function saveImg(){
						var y = window.scrollY;
						console.log(y);
						window.scrollTo(0,0);
						html2canvas($("#controller")[0], {width:document.getElementById("first").width, scale:1}).then(function(canvas){
							var myImage = canvas.toDataURL("image/jpeg", 1.0);
							console.log(myImage);
							saveloadURI(myImage);
						});
						window.scrollTo(0,y);
					}
	
					function saveloadURI(uri){
                        if(cur <= -1)
							cur = max_index-1;
                        if(cur >= max_index)
							cur = 0;
						img_source[cur].src = uri;
					}
					</script>




							</div>
						</div>
					</div>
					
				<div id ="download_div" style = "position:absolute; z-index : 1; top:0; left:50vw; transform: translate(-50%, 20%); ">
					<canvas id = "download_test" width="793px" height="1122px"></canvas>
				</div>
				
				<script>
					document.getElementById("download_div").style.visibility = "hidden";
				</script>
				<div id = "add" style="display:none;"></div>
				</body>

	</html>