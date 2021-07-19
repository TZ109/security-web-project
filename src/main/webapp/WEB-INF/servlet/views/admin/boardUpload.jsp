<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
	<meta name="copyright" content="Copyright (c) 2021 VANE company All rights reserved">
	<meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=no;shrink-to-fit=no" name="viewport" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<title>Baronarin(Beta)</title>
</head>
<body>
<div id = "Controll_Layer">
		<nav class="navbar" style="display: flex;justify-content: space-between;align-items: center;padding: 8px 12px;max-height:100px;
		min-height:80px;">
		<a href="/">
									<img src="/img/google.png" style="height:80px" />
								</a>

								<ul class="button_layer" style="display: flex;list-style : none; padding-left : 0;">
							
									
									<li> <a onclick="location.href='/board'" class="btn5" style="cursor: pointer"> 자료실
										</a> </li>
									<li> <a onclick="location.href='/user/customerCenter'" class="btn5" style="cursor: pointer"> 고객센터
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
				</ul>

			</nav>
		</div>
		<div style="margin-top:300px;margin-left:500px;font:normal normal normal 18px/27px Noto Sans KR;">
	<form action="/boardUp" method="post" enctype="multipart/form-data">
			<div style="margin-bottom:15px">
			<select name="postType">
			<option value="근로">근로</option>
			<option value="구매">구매</option>
			<option value="가맹">가맹</option>
			 <option value="보험">보험</option>
			 <option value="금융">금융</option>
			 <option value="렌탈">렌탈</option>
			 <option value="기타">기타</option>
			 </select>
			 </div>
		<div style="margin-bottom:15px"><input name="special" type="text" placeholder="새부 항목"></div>	 
		<div style="margin-bottom:15px"><input name="title" type="text" placeholder="문서 이름"></div>
		<div style="margin-bottom:15px"><input name="hwp_file" type="file"></div>
		<div style="margin-bottom:15px"><input name="pdf_file" type="file"></div>
		 
		<div style="margin-bottom:15px"><button>제출</button></div>
	</form>
</div>
</body>
</html>