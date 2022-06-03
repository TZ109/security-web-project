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
	<!-- <meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=no;shrink-to-fit=no" name="viewport" /> -->
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
							
									
									<li> <a onclick="location.href='/board'" class="btn5" style="cursor: pointer;white-space: nowrap;"> 자료실
										</a> </li>
									<li> <a onclick="location.href='/user/customerCenter'" class="btn5" style="cursor: pointer;white-space: nowrap;"> 고객센터
										</a> </li>

									<sec:authorize access="isAnonymous()">
										
										<li> <a href="/joinForm" class="btn7"
												style="cursor: pointer; text-decoration:none;white-space: nowrap;"> 회원가입 </a> </li>
										<li> <a href="/loginForm" class="btn6"
												style="cursor: pointer; text-decoration:none;white-space: nowrap;"> 로그인 </a> </li>
									</sec:authorize>

									<sec:authorize access="isAuthenticated()">
										<li style="margin-left:14px; margin-right:6px;"><a href="/user/myPage" class="btn5" style="cursor: pointer;white-space: nowrap;">마이페이지</a></li>
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
		<div style="position:absolute;top:130px;left:100px;width: 600px;border-radius: 25px;border: 1px solid black;padding:10px;">
			<p style="font-size: 40px;font-family: Noto Sans KR; font-family: bold;color:#245AE3;text-align: center;">자료실 문서 업로드</p>
					
					<form action="/boardUp" method="post" enctype="multipart/form-data" id="boardform">
						<div style="position: relative;left:50px;">
							<div style="margin-bottom:15px;">
							<span style="font-size: 16px;font-family:Noto Sans KR">종류 : &nbsp;</span>
							<select style="font-size: 16px;padding:7px 15px;font-family:Noto Sans KR" name="postType">
							<option value="근로">근로</option>
							<option value="구매">구매</option>
							<option value="가맹">가맹</option>
							<option value="보험">보험</option>
							<option value="금융">금융</option>
							<option value="렌탈">렌탈</option>
							<option value="기타">기타</option>
							</select>
							</div>
						<div style="margin-bottom:15px"><span style="font-size: 16px;font-family:Noto Sans KR;">세부 항목 : &nbsp</span><input  style="font-size: 16px;font-family:Noto Sans KR;padding:7px 15px;" maxlength="20" name="special" type="text" placeholder="입력"></div>	 
						<div style="margin-bottom:15px"><span style="font-size: 16px;font-family:Noto Sans KR;">문서 이름 : &nbsp</span><input  style="font-size: 16px;font-family:Noto Sans KR;padding:7px 15px;" maxlength="30" name="title" type="text" placeholder="입력"></div>
						<div style="margin-bottom:15px"><span style="font-size: 16px;font-family:Noto Sans KR;">한글 문서 업로드 : &nbsp</span><input  style="font-size: 16px;font-family:Noto Sans KR;padding:7px 15px;" name="hwp_file" type="file" id="hwpfile"></div>
						<div style="margin-bottom:15px"><span style="font-size: 16px;font-family:Noto Sans KR;">pdf 문서 업로드 : &nbsp</span><input  style="font-size: 16px;font-family:Noto Sans KR;padding:7px 15px;" name="pdf_file" type="file" id="pdffile"></div>
						
					</div>
						<div style="width:100%;text-align: center;margin-bottom:15px"><div style="position:relative;margin-left:auto;margin-right:auto;width:80px;font-size: 16px;font-family: Noto Sans KR;border:none;padding:7px 15px;background-color: #245AE3;color:white;border-radius: 15px;cursor: pointer;" onclick="submit()">제출</div></div>
					</form>
				
</div>
						<script>
							function submit()
							{
								var hwp = document.getElementById('hwpfile').files[0];
								var pdf = document.getElementById('pdffile').files[0];
								if(hwp!=undefined && pdf!=undefined)
									$('#boardform').submit();
								else
								{
									alert('빈파일은 등록할 수 없습니다.');
								}
								
							}
						</script>

</body>
</html>