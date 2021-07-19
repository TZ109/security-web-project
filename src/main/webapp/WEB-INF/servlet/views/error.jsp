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
        <meta charset="utf-8">
        <title>error</title>
        <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" type="text/css" href="/css/style_login2.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css?ver=1">
    <link rel="stylesheet" type="text/css" href="/css/style_signpage.css?ver=4">
    <link rel="stylesheet" type="text/css" href="/css/style_stamppage.css?ver=4">
     <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="/css/webHome.css">
    </head>

    <body>
    <div id="Page" style="width: 100%;">
     <div id = "Controll_Layer">
        <nav class="navbar" style="display: flex;justify-content: space-between;align-items: center;padding: 8px 12px;max-height:80px;
		min-height:80px;">
		<a href="/">
			<img src = "/img/google.png" style="height:80px"/>
		</a>
		
		<ul class="button_layer" style="display: flex;list-style : none; padding-left : 0;">
			<li> <a class="btn5" onclick="test()" style="cursor:pointer"> 도장 / 계약서 만들기 </a> </li>
			<li> <a onclick="location.href='/board'" class="btn5" style="cursor: pointer"> 자료실 </a> </li> 
			<li> <a onclick="location.href='/customerCenter'" class="btn5" style="cursor: pointer"> 고객센터 </a> </li>
			
				<sec:authorize access="isAnonymous()">
					<li> <a href="/joinForm" class="btn7" style="cursor: pointer; text-decoration:none"> 회원가입 </a> </li>
					<li> <a href="/loginForm" class="btn6" style="cursor: pointer; text-decoration:none"> 로그인 </a> </li>
				</sec:authorize>
			
				<sec:authorize access="isAuthenticated()">
					<li style="margin-left:14px; margin-right:6px;"><a href="/user/myPage" class="btn5" style="cursor: pointer">마이페이지</a></li>
					<li><form action="/logout" method="POST">
				        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				        <a class="btn6"><button type="submit" class="btn6_sub" style="cursor: pointer; text-decoration:none;">로그아웃</button>
					</a></form></li>
				</sec:authorize>
			
	

			
			


			
		</ul>
		</nav>
     </div>
   </div>
    
        <div data-layer="040e6dbb-5eca-455a-a767-ad8b636aaa94" class="webHome">
       

        
        
        
        
        404
        
        <div data-layer="7e788d09-2a3f-4d4b-9e39-f4127029073e" class="x430"></div>
        <div data-layer="9b7902ff-9af1-4a1e-b6fa-3b795034884a" class="xacfe3495">자료실</div>
        <div data-layer="b6604973-32cd-4f33-9eb8-2b3d82230d0f" class="x6361aad4">도장 / 계약서 만들기</div>
        <div data-layer="fee7f22a-c5b5-43ca-832f-c87cf4c20e51" class="x898"></div>
       	
        <a target="_blank" href="/joinForm" data-layer="f8fa6806-f31f-4f45-abe2-86ff4fdc3801" class="x897"></a>
     
        
        
        <div data-layer="e7702ca8-2af3-4179-be3c-fc8e0a9ccfbd" class="bi08"></div>
        <div data-layer="15de70d3-d21e-44f1-a9a2-237c1549fbe5" class="x584c696d">고객센터</div>

        <svg data-layer="5738def0-2ba9-42b0-96a8-a47382ed2549" preserveAspectRatio="none" viewBox="-0.5 0 1 15" class="x79"><path d="M 0 0 L 0 15"  /></svg>
</div>


    
    </body>
    </html>
            