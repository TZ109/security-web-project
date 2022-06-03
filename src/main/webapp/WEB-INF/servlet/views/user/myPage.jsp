<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
		<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
			<%@ page import="org.springframework.security.core.Authentication" %>
				<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   

				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="utf-8">
					<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
					<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
					<link rel="stylesheet" type="text/css" href="/css/style.css">
					<link rel="stylesheet" type="text/css" href="/css/style_myPage.css">
					<link rel="stylesheet" type="text/css" href="/css/style_signpage.css?ver=4">
					<link rel="stylesheet" type="text/css" href="/css/style_stamppage.css?ver=4">
					<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
					<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
									<li> 
									</li>
									<li> <a onclick="location.href='/board'" class="btn5" style="cursor: pointer;white-space: nowrap;"> 자료실
										</a> </li>
									<li> <a onclick="location.href='/customerCenter'" class="btn5" style="cursor: pointer;white-space: nowrap;"> 고객센터
										</a> </li>

									<sec:authorize access="isAnonymous()">
										<script>
											function announce() {
												window.open("/popup", "popup", "width=700, height=450,left=30,top=30");
											}
											announce();
										</script>
										<li> <a href="/joinForm" class="btn7"
												style="cursor: pointer; text-decoration:none;white-space: nowrap;"> 회원가입 </a> </li>
										<li> <a href="/loginForm" class="btn6"
												style="cursor: pointer; text-decoration:none;white-space: nowrap;"> 로그인 </a> </li>
									</sec:authorize>

									<sec:authorize access="isAuthenticated()">
										<li style="margin-left:14px; margin-right:6px;"><a href="/user/myPage" class="btn5" style="cursor: pointer;white-space: nowrap;text-decoration: none;">마이페이지</a></li>
										<li>
											<form action="/logout" method="POST">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
												<a class="btn6"><button type="submit" class="btn6_sub"
														style="cursor: pointer; text-decoration:none;white-space: nowrap;">로그아웃</button>
												</a>
											</form>
										</li>
									</sec:authorize>



								</ul>
							</nav>
						</div>


					<!-- 상단 부 -->
					<div style="width:90%; position:relative; top:150px; margin-left: auto; margin-right:auto">
					<div style="display:  flex; justify-content: space-between;">
						<div style="display:  flex; align-items: center;">
						<div style="width:240px;text-align: left;font: normal normal bold 48px/64px Noto Sans KR;letter-spacing: -1.2px;color: #191919;opacity: 1;">
						마이페이지</div>
						<!-- 관리자 추가 버튼 -->
						<sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal" var="principal" />
                  
					<c:if test="${principal.role eq 'ROLE_ADMIN'}">
							  
							<a onclick="make_admin()" class="btn6" style="height:20px;"><button class="btn6_sub">관리자 추가</button></a>	
                            
                            
                            <script>
                            function make_admin()
                            {
                            	var target = prompt("관리자로 변경할 유저의 이메일을 입력하십시오.","");
                            	
                            	if(target=='' || target==undefined)
                            		{
                            		alert('공백입니다')
                            		return false;
                            		}
                            	
                            	$.ajax({
                            		async:true,
                            		url:'/user/makeAdmin',
                            		type: 'get',
	                        		dataType: "json",
	                        		data: {'target': target},
	                        		success: function(result)
	                        		{
	                        			if(result==1)
	                        				{
	                        				alert('해당 유저를 관리자로 변경하였습니다.');
	                        				}
	                        			else if(result == 0)
	                        				alert('유저를 찾을 수 없습니다.');
	                        		},
	                        		error: function()
	                        		{
	                        			alert('err');
	                        		}
                            		
                            	});
                            }
                            
                            
                            </script>
                            
					</c:if>
					</sec:authorize>
					
						</div>	
						<div style="display: flex;align-items: center;">
						<div class="btn6" style="height:20px;margin-right: 10px;"><button class="btn6_sub" onclick="test()">서명 확인</button></div>	
						<div class="btn6" style="height:20px;margin-right: 10px;"><button class="btn6_sub" onclick="test2();">서명 변경</button></div>
						
						
							
						<div
							style="position: relative;width:80px;margin-right: 15px;text-align: left;font: normal normal bold 15px/23px Noto Sans KR;letter-spacing: -0.38px;color: #245AE3;">
							${name} <span style="color: #6E6E6E;">님</span>
						</div>
						<div
							style="position: relative;text-align: left;font: normal normal normal 17px/23px Noto Sans KR;letter-spacing: -0.42px;color: #000000;opacity: 1;">
							${email} </div>
						</div>	
						
					</div>	
					<div style="position:relative;width:100%">
						<hr style="height: 5px;width: 100%;border-radius: 10px; background-color: #245AE3;">
					</div>
					<!-- 현재 진행중인 계약서 파트 -->

					<div style="width:90%; margin-top: 100px;margin-left: auto;margin-right: auto;">
						<div
							style="width:100%;text-align: left;font: normal normal bold 23px/23px Noto Sans KR;color: #245AE3;">
							현재 진행중인 계약서
						</div>
						<div style="display: flex;margin-top:15px;">
							<div 
								style="width:50%;margin-left: 10%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;color: #191919;">
								제목</div>
							<div 
								style="width:26%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;color: #191919;">
								생성날짜</div>
							<div 
								style="width:12%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;opacity: 1;">
								진행중
							</div>
							<div 
								style="width:12%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;opacity: 1;">
								다운로드
							</div>
						</div>
					</div>
					<div>
						<hr style="width: 90%; margin-top:20px;margin-left: auto;margin-right: auto;height:1px;background-color: #245AE3;">

						<!-- 여기서 부터는 쿼리에 따른 입력. top을 +60씩 하면서 적용하면 됩니다.-->
						<c:set var="total" value="22"/>
						<c:set var="totalbar" value="60"/>
						<c:set var="number" value="1"/>
						<c:forEach items="${ongoing}" var="data">
						
							<div style="display: flex; width:90%;margin-left: auto;margin-right: auto;">
							<div id="centry1" style="width:10%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
								${number}
							</div>
							<div id="centry2" style="width:50%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
								${data.orig_papername}
							</div>
							<div id="centry5_ongoing_${number}" style="width:26%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
									${data.createDate}
							</div>
							<script>
									document.getElementById('centry5_ongoing_'+`${number}`).innerText = `${data.createDate}`.substring(0,10);
								</script>	
							<div id="centry3" style="width:12%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #AAAAAA;">
								${data.sign_count}/${data.people_size}
							</div>
							<div id="centry4" style="width:12%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
								
							
								<form action="/user/signedDownload" method="post" id="ongoing_submit">
									<button style="background-color: #245AE3;color:white;padding:5px 10px;text-align: center;text-decoration: none;border:none;border-radius: 10px;cursor:pointer">Download</button>
									<input type="hidden" name="title" value="${data.papername}">
									<input type="hidden" name="create_time" value="${data.createDate}">
								</form>
								
							</div>
						</div>
							<c:set var="total" value="${total + 60}"/>
							<hr id="bar" style="width:90%;height:1px;background-color: #245AE3;">
							<c:set var="totalbar" value="${totalbar + 60}"/>
							<c:set var="number" value="${number + 1}"/>
					
						</c:forEach>
						
						

					<!-- 완료된 계약서 파트 위의 마지막 바(ex.<hr class="my_page_bar" style="top:180px;">) 기준 +64px -->

					<div style="width:90%; margin-top: 60px;margin-left: auto;margin-right: auto;">
						<div
							style="width:100%;text-align: left;font: normal normal bold 23px/23px Noto Sans KR;color: #245AE3;">
							완료된 계약서
						</div>
						<div style="display: flex;margin-top:15px;">
							<div 
								style="width:50%;margin-left: 10%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;color: #191919;">
								제목</div>
							<div 
								style="width:26%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;color: #191919;">
								생성날짜</div>
							<div 
								style="width:12%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;opacity: 1;">
								완료
							</div>
							<div 
								style="width:12%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;opacity: 1;">
								확인 페이지
							</div>
						</div>
					</div>
					<!-- 아래는 위의 기준 <div style="position: absolute;top: 244px;"> 기준 +92px -->
					<div>
						<hr style="width: 90%; margin-top:20px;margin-left: auto;margin-right: auto;height:1px;background-color: #245AE3;">

						<!-- 여기서 부터는 쿼리에 따른 입력. top을 +60씩 하면서 적용하면 됩니다.-->
						<c:set var="total" value="22"/>
						<c:set var="totalbar" value="60"/>
						<c:set var="number" value="1"/>
						<c:forEach items="${completed}" var="data">
						
							<div style="display: flex; width:90%;margin-left: auto;margin-right: auto;">
								<div id="centry1" style="width:10%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
									${number}
								</div>
								<div id="centry2" style="width:50%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
									${data.orig_papername}
								</div>
								<div id="centry5_com1_${number}" style="width:26%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">

								</div>
								<script>
									document.getElementById('centry5_com1_'+`${number}`).innerText = `${data.createDate}`.substring(0,10);
								</script>
								<div id="centry3" style="width:12%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #AAAAAA;">
									${data.sign_count}/${data.people_size}
									
								</div>
							
								<div id="centry4" style="width:12%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
								
									<form action="/user/Documentcomplete" method="post" id="completed_submit">
										<button style="font-weight: bold;background-color: #245AE3;color:white;border:none;padding:5px 20px;text-align: center;text-decoration: none;border-radius: 10px;cursor:pointer">확인</button>
										<input type="hidden" name="title" value="${data.papername}">
										<input type="hidden" name="create_time" value="${data.createDate}">
									</form>
									<!--  
									<form action="/user/completesignedDownload" method="post" id="completed_submit">
										<button>Download</button>
										<input type="hidden" name="title" value="${data.papername}">
										<input type="hidden" name="create_time" value="${data.createDate}">
									</form>
									-->
								
								</div>
							</div>
							<c:set var="total" value="${total + 60}"/>
							<hr id="bar" style="width:90%;height:1px;background-color: #245AE3;">
							<c:set var="totalbar" value="${totalbar + 60}"/>
							<c:set var="number" value="${number + 1}"/>
					
						</c:forEach>

						
						
					
						
						<div style="width:90%; margin-top: 60px;margin-left: auto;margin-right: auto;">
						<div
							style="width:100%;text-align: left;font: normal normal bold 23px/23px Noto Sans KR;color: #245AE3;">
							등록한 문서
						</div>
						<div style="display: flex;text-align: center;">
						<div 
							style="width:50%;margin-left: 10%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;color: #191919;">
							제목</div>
						<div 
							style="width:26%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;color: #191919;">
							생성날짜</div>
						<div
							style="width:12%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;opacity: 1;">
							완료
						</div>
						<div 
							style="width:12%;text-align: center;font:bold normal normal 17px/23px Noto Sans KR;opacity: 1;">
							확인 페이지
						</div>
						</div>
					</div>
					<!-- 아래는 위의 기준 <div style="position: absolute;top: 244px;"> 기준 +92px -->
					<div>
						<hr style="width: 90%; margin-top:20px;margin-left: auto;margin-right: auto;height:1px;background-color: #245AE3;">

						<!-- 여기서 부터는 쿼리에 따른 입력. top을 +60씩 하면서 적용하면 됩니다.-->
						<c:set var="total" value="22"/>
						<c:set var="totalbar" value="60"/>
						<c:set var="number" value="1"/>
						<c:forEach items="${completed2}" var="data">
						
							<div style="display: flex; width:90%;margin-left: auto;margin-right: auto;">
								<div id="centry1" style="width:10%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
									${number}
								</div>
								<div id="centry2" style="width:50%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
									${data.orig_papername}
								</div>
								<div id="centry5_com2_${number}" style="width:26%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
								</div>
								<script>
									document.getElementById('centry5_com2_'+`${number}`).innerText = `${data.createDate}`.substring(0,10);
								</script>
								
								<div id="centry3" style="width:12%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #AAAAAA;">
									${data.sign_count}/${data.people_size}
									
								</div>
								<div id="centry4" style="width:12%;text-align: center;font:normal normal normal 17px/23px Noto Sans KR;color: #191919;">
								
									<form action="/user/copyrightcomplete" method="post" id="completed_submit">
										<button style="font-weight: bold;background-color: #245AE3;color:white;border: none;border-radius: 10px;padding:5px 20px;cursor:pointer">확인</button>
										<input type="hidden" name="serialnum" value="${data.uniquenum}">
										
									</form>
									<!--  
									<form action="/user/completesignedDownload" method="post" id="completed_submit">
										<button>Download</button>
										<input type="hidden" name="title" value="${data.papername}">
										<input type="hidden" name="create_time" value="${data.createDate}">
									</form>
									-->
								
								</div>
							</div>
							<c:set var="total" value="${total + 60}"/>
							<hr id="bar" style="width:90%;height:1px;background-color: #245AE3;">
							<c:set var="totalbar" value="${totalbar + 60}"/>
							<c:set var="number" value="${number + 1}"/>
					
						</c:forEach>

						
						<br/>
						<br/>
						<br/>
						<br/>
						<br/>
						<br/>
						<br/>

					</div>
						

					</div>
						
						

					</div>
					
					

					</div>
					</div>
					
					
					
					
					

					</div>
					
								<script>
								function test() {
									document.getElementById("background_gray").style.display = "inline-block";
									document.getElementById("background_gray").style.position = "fixed";
									document.getElementById("second_layer").style.display = "none";
									document.getElementById("show_sign_layer").style.display = "inline-block";
									var tmp = "<img id ='show_sign' width='500' height='300' style='image-rendering: auto;object-fit:contain;' src='<spring:url value='/showsignbysession'/>'>";
									$('#show_sign_layer').append(tmp);
									document.getElementById('sign_Layer').style.display = "none";
									document.getElementById('stamp_Layer').style.display = "none";
									document.getElementById("black_div").style.display = "block";
								}
									function test2() {
										document.getElementById("background_gray").style.display = "inline-block";
										document.getElementById("background_gray").style.position = "fixed";
										document.getElementById("second_layer").style.display = "inline-block";
										document.getElementById("show_sign_layer").style.display = "none";
										document.getElementById('sign_Layer').style.display = "none";
										document.getElementById('stamp_Layer').style.display = "none";
										document.getElementById("black_div").style.display = "block";
									}
								</script>
								
								<div id="black_div"
								style="display:none; position:fixed; left:0px; top:0px; background:rgba(28, 31, 38, 0.5); z-index:99; width:100%; height:100%;">
							</div>
							
							
							<!--  
							<div id="imgControll_div" style="display:none">
								 <img  id="imgControll" name="imgControll" src="<spring:url value='/showsign/${signname}'/>" decoding="async" width="429px" height="201px" style="margin-top:90px">
                            	<a onclick="close_img()" style="position:absolute; top:30px; right:30px"><img
										src="/img/close.png" width=20px height=20px style="cursor:pointer" /></a>
                            
                            </div>
                            -->
                            
                            <script>
                            function close_img()
                            {
                            	document.getElementById("imgControll_div").style.display = "none";
								document.getElementById("black_div").style.display = "none";
                            }
                            
                            
                            </script>
                            
							<div id="background_gray" style="display:none">
								<a onclick="close_div()" style="position:absolute; top:30px; right:30px"><img
										src="/img/close.png" width=20px height=20px style="cursor:pointer" /></a>
								<a onclick="prev_div()" style="position:absolute; top:30px; left:30px"><img
										src="/img/next.png" width=11.48px height=20px style="cursor:pointer" /></a>

								<script>
									function close_div() {
										document.getElementById("background_gray").style.display = "none";
										document.getElementById("black_div").style.display = "none";
										var temp = document.getElementById("show_sign");
										if(temp!=undefined)
											temp.remove();
									}

									function prev_div() {
										if (document.getElementById("second_layer").style.display == "none") {
											document.getElementById("second_layer").style.display = "inline-block";
											document.getElementById('sign_Layer').style.display = "none";
											document.getElementById('stamp_Layer').style.display = "none";
										}

									}
								</script>

								<div id="show_sign_layer" style="margin-top:140px; display:none;">
								</div>

								<div id="second_layer" style="margin-top:140px; display:none;">

									<a onclick="expand_layer('sign_draw')"><img src="/img/test4.png" width=160px
											style="cursor:pointer"></a>
									<a onclick="signfile_upload()"><img src="/img/test7.png" width=160px
											style="cursor:pointer"></a>
									<a onclick="expand_layer('stamp')"><img src="/img/test3.png" width=160px
											style="cursor:pointer"></a>

									<input type="file" style="display:none" id="signupfile" onchange="upload_sign2(this.files)">
									
									<script>
										function signfile_upload()
										{
											document.getElementById('signupfile').click();
										}
										
										function upload_sign2(files){
												
												
											    var file = files[0];	// Blob 생성
				
											    var formdata = new FormData();
											    formdata.append("file", file);
											    formdata.append("title",`${paper_name}`);
											    formdata.append("create_time",`${create_date}`);
											    
											    if(file!=undefined)
											    {
											    	$.ajax({
												    	async : true, 
												        type : 'POST',
												        url : '/user/changesign',
												        data : formdata,
												        dataType: "json",
												        processData : false,	// data 파라미터 강제 string 변환 방지!!
												      	contentType : false,	// application/x-www-form-urlencoded; 방지!!
												        success : function (result) {
												           if(result==0)
												        	{
												        	   document.getElementById("background_gray").style.display = "none";
																document.getElementById("black_div").style.display = "none";
																var temp = document.getElementById("show_sign");
																if(temp!=undefined)
																	temp.remove();
												        	   
																alert('서명 등록성공');
												        	}
												        },
												        error : function()
												        {
												        	alert('서명 등록실패');
												        }
												        
													});
											    }
											    
											
										}
									</script>

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
									    var file = new Blob([new Uint8Array(array)], {type: 'image/png'});	// Blob 생성

									    var formdata = new FormData();
									    formdata.append("file", file);
									    formdata.append("title",`${paper_name}`);
									    formdata.append("create_time",`${create_date}`);
									    
									    $.ajax({
									    	async : true, 
									        type : 'POST',
									        url : '/user/changesign',
									        data : formdata,
									        dataType: "json",
									        processData : false,	// data 파라미터 강제 string 변환 방지!!
									      	contentType : false,	// application/x-www-form-urlencoded; 방지!!
									        success : function (result) {
									           if(result==0)
									        	{
									        	  // document.getElementById("input_sign").src= "/img/sign_off.svg";
													//document.getElementById("input_sign_ancher").onclick = null;
													document.getElementById("background_gray").style.display = "none";
													document.getElementById("black_div").style.display = "none";
													var temp = document.getElementById("show_sign");
													if(temp!=undefined)
														temp.remove();
													
													alert('서명 둥록성공');
									        	}
									        },
									        error : function()
									        {
									        	alert('서명 등록실패');
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
					
					
							<div class="myPage_btn" style="text-align: end; display:flex; position: absolute; top:100px; left:1130px">
                                <a onclick="test()" id="input_sign_ancher"><img src="/img/sign_on.svg" width=100px
													style="display:none;cursor:pointer;object-fit:contain" id="input_sign"></a>

											<br>
                            </div>
                            
                            
                           
                            <script type="text/javascript">
							
							 function fnImgPop(){
								 document.getElementById("imgControll_div").style.display = "inline-block";
								 document.getElementById("imgControll_div").style.position = "fixed";
								
								 
								document.getElementById("black_div").style.display = "block";
								
								
								
							
							 }
							
							</script>
                            
                            
                            <!--  
                            <div class="myPage_btn" style="text-align: end; display:flex; position: absolute; top:100px; left:1135px">
                                <div onclick="fnImgPop()" style="width:100px;height:53px;border-radius:20px;background-color:black;text-align: center;padding-top:30px" type="submit" >
                                <span style="color:white;">사인 확인</span></div>
                            </div>
							-->



				</body>

				</html>