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
					
					<link rel="stylesheet" type="text/css" href="/css/style.css">
					<link rel="stylesheet" type="text/css" href="/css/style_myPage.css">
					<link rel="stylesheet" type="text/css" href="/css/style_signpage.css?ver=4">
					<link rel="stylesheet" type="text/css" href="/css/style_stamppage.css?ver=4">
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



								</ul>
							</nav>
						</div>


					<!-- 상단 부 -->

					<div
						style="position:absolute;top: 102px;left: 320px;text-align: left;font: normal normal bold 48px/64px Noto Sans KR;letter-spacing: -1.2px;color: #191919;opacity: 1;">
						마이페이지</div>
					<div
						style="position: absolute;top: 149px;left: 1280px;text-align: left;font: normal normal bold 15px/23px Noto Sans KR;letter-spacing: -0.38px;color: #245AE3;">
						${name} <span style="color: #6E6E6E;">님</span>
					</div>
					<div
						style="position: absolute;top: 147px;left: 1386px;text-align: left;font: normal normal normal 17px/23px Noto Sans KR;letter-spacing: -0.42px;color: #000000;opacity: 1;">
						${email} </div>
					<div style="position: absolute;top: 182px;left: 320px;">
						<hr style="height: 5px;width: 1280px;border-radius: 10px; background-color: #245AE3;">
					</div>

					<!-- 현재 진행중인 계약서 파트 -->

					<div style="position: absolute;top: 271px;left:440px">
						<div
							style="position:absolute;width:300px;font: normal normal bold 23px/23px Noto Sans KR;color: #245AE3;">
							현재 진행중인 계약서
						</div>
						<div class="my_page_data"
							style="top:51px;left:337px;width:100px;font-weight: bold;color: #191919;">
							제목</div>
						<div class="my_page_data"
							style="top:51px;left:688px;width:100px;font-weight: bold;color: #191919;opacity: 1;">
							진행중
						</div>
						<div class="my_page_data"
							style="top:51px;left:941px;width:100px;font-weight: bold;color: #191919;opacity: 1;">
							다운로드
						</div>
					</div>
					<div style="position: absolute;top: 367px;left: 440px;">
						<hr style="position: absolute;width: 1040px;height:1px;background-color: #245AE3;">

						<!-- 여기서 부터는 쿼리에 따른 입력. top을 +60씩 하면서 적용하면 됩니다.-->
						<c:set var="total" value="22"/>
						<c:set var="totalbar" value="60"/>
						<c:set var="number" value="1"/>
						<c:forEach items="${ongoing}" var="data">
						
							
							<div id="centry1" class="my_page_data" style="top:${total}px;left:50px;">
								${number}
							</div>
							<div id="centry2" class="my_page_data" style="text-align:center;top:${total}px;left:206px;width:300px;">
								${data.orig_papername}
							</div>
							<div id="centry3" class="my_page_data" style="top:${total}px;left:700px;color: #AAAAAA;">
								${data.sign_count}/${data.people_size}
							</div>
							<div id="centry4" class="my_page_data" style="top:${total}px;left:956px;font-weight: bold;">
								
							
								<form action="/user/signedDownload" method="post" id="ongoing_submit">
									<button>Download</button>
									<input type="hidden" name="title" value="${data.papername}">
									<input type="hidden" name="create_time" value="${data.createDate}">
								</form>
								
							</div>
							<c:set var="total" value="${total + 60}"/>
							<hr id="bar" class="my_page_bar" style="top:${totalbar}px;">
							<c:set var="totalbar" value="${totalbar + 60}"/>
							<c:set var="number" value="${number + 1}"/>
					
						</c:forEach>
						
						

					<!-- 완료된 계약서 파트 위의 마지막 바(ex.<hr class="my_page_bar" style="top:180px;">) 기준 +64px -->

					<div style="position: absolute;top: ${totalbar+64}px;">
						<div
							style="position:absolute;width:300px;font: normal normal bold 23px/23px Noto Sans KR;color: #245AE3;">
							완료된 계약서
						</div>
						<div class="my_page_data"
							style="top:51px;left:337px;width:100px;font-weight: bold;color: #191919;">
							제목</div>
						<div class="my_page_data"
							style="top:51px;left:688px;width:100px;font-weight: bold;color: #191919;opacity: 1;">
							완료
						</div>
						<div class="my_page_data"
							style="top:51px;left:941px;width:100px;font-weight: bold;color: #191919;opacity: 1;">
							다운로드
						</div>
					</div>
					<!-- 아래는 위의 기준 <div style="position: absolute;top: 244px;"> 기준 +92px -->
					<div style="position: absolute;top: ${totalbar+92+64}px;">
						<hr style="position: absolute;width: 1040px;height:1px;background-color: #245AE3;">

						<!-- 여기서 부터는 쿼리에 따른 입력. top을 +60씩 하면서 적용하면 됩니다.-->
						<c:set var="total" value="22"/>
						<c:set var="totalbar" value="60"/>
						<c:set var="number" value="1"/>
						<c:forEach items="${completed}" var="data">
						
							
							<div id="centry1" class="my_page_data" style="top:${total}px;left:50px;">
								${number}
							</div>
							<div id="centry2" class="my_page_data" style="text-align:center;top:${total}px;left:206px;width:300px;">
								${data.orig_papername}
							</div>
							<div id="centry3" class="my_page_data" style="top:${total}px;width:100px;left:688px;font-weight: bold;color: #245AE3;">
								<form action="/user/Documentcomplete" method="post" id="completed_submit">
									<button style="font-weight: bold;color: #245AE3;">확인</button>
									<input type="hidden" name="title" value="${data.papername}">
									<input type="hidden" name="create_time" value="${data.createDate}">
								</form>
							</div>
							<div id="centry4" class="my_page_data" style="top:${total}px;left:956px;font-weight: bold;">
							
								<form action="/user/completesignedDownload" method="post" id="completed_submit">
									<button>Download</button>
									<input type="hidden" name="title" value="${data.papername}">
									<input type="hidden" name="create_time" value="${data.createDate}">
								</form>
								
							
							</div>
							<c:set var="total" value="${total + 60}"/>
							<hr id="bar" class="my_page_bar" style="top:${totalbar}px;">
							<c:set var="totalbar" value="${totalbar + 60}"/>
							<c:set var="number" value="${number + 1}"/>
					
						</c:forEach>

						

					</div>


					</div>

					</div>




				</body>

				</html>