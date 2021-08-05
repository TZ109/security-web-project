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
        <title>Web home - 로그인</title>
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
			<img src = "img/google.png" style="height:80px"/>
		</a>
		
		<ul class="button_layer" style="display: flex;list-style : none; padding-left : 0;">
			
			<li> <a onclick="location.href='/board'" class="btn5" style="cursor: pointer"> 자료실 </a> </li> 
			<li> <a onclick="location.href='/customerCenter'" class="btn5" style="cursor: pointer"> 고객센터 </a> </li>
			
				<sec:authorize access="isAnonymous()">
					<li> <a href="/joinForm" class="btn7" style="cursor: pointer; text-decoration:none"> 회원가입 </a> </li>
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
   </div>
    
        <div data-layer="040e6dbb-5eca-455a-a767-ad8b636aaa94" class="webHome">
        <div data-layer="99430d75-61ac-4740-807b-558926fb5dc2" class="bibetakr"></div>
        <div data-layer="121a22bf-88a5-485e-9d07-9a4c89a0784b" class="x859"></div>
        
        
        <div data-layer="019915b4-ef6b-4bb6-a687-78532a61cb45" class="xa417f398">비밀번호 찾기</div>
        <div data-layer="ede9add1-b3ac-432e-a73c-db382fd74360" class="x16edde1d">아이디  찾기</div>
        
       
        
        <div data-layer="80b12cf2-ae3d-4583-acfc-a5ea5081f0f5" class="x4562262a9f6"></div>
        
        
        
        <form action="/login"method='POST' class="loginForm">
        
         <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">

        <div data-layer="1d22a581-66be-4fe5-ba69-c560f0084902" class="x5cc6bb60">가입하지 않은 아이디 또는 잘못된 패스워드입니다. 다시 확인해주세요.</div>
        
        <c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
        </c:if>
        
        <div class="x1bd70d98" style="padding-top: 5px;"><input type="text" maxlength="30" name="username" style="position:absolute; width:350px;padding-top: 5px; border:none;border-right:0px; border-top:0px; border-left:0px; border-bottom:0px;text-align:left;font-size:20px;" size="30" placeholder="아이디"/></div>
        <div data-layer="d600c7c9-aaa5-4d75-8952-6a26e175c380" class="x456451d2b53"></div>
        <div class="xb6bbaf1e" style="padding-top: 5px;"><input type="password" maxlength="20" name="password" style="position:absolute; width:330px;padding-top: 5px; border:none;border-right:0px; border-top:0px; border-left:0px; border-bottom:0px;text-align:left;font-size:20px;" size="30" placeholder="비밀번호"/><br/></div>
        
        <button>
        <div data-layer="f5429a5c-4a6b-40b5-9da1-857ca33d2b2b" class="x909"></div>
        </button>
        
        </form>
        
        <div data-layer="7e788d09-2a3f-4d4b-9e39-f4127029073e" class="x430"></div>
        <div data-layer="9b7902ff-9af1-4a1e-b6fa-3b795034884a" class="xacfe3495">자료실</div>
        <div data-layer="b6604973-32cd-4f33-9eb8-2b3d82230d0f" class="x6361aad4">도장 / 계약서 만들기</div>
        <div data-layer="fee7f22a-c5b5-43ca-832f-c87cf4c20e51" class="x898"></div>
       	
        <a target="_blank" href="/joinForm" data-layer="f8fa6806-f31f-4f45-abe2-86ff4fdc3801" class="x897"></a>
     
        
        
        <div data-layer="e7702ca8-2af3-4179-be3c-fc8e0a9ccfbd" class="bi08"></div>
        <div data-layer="15de70d3-d21e-44f1-a9a2-237c1549fbe5" class="x584c696d">고객센터</div>
        <div data-layer="b9310510-a28c-488f-862b-b2178a41653a" class="x966"></div>
        <div data-layer="3c0eb85a-5772-4214-9c18-598bca1c7f1d" class="x965"></div>
        <div data-layer="03dffb51-2ce1-41e8-949e-3cfe69417308" class="x959"></div>
        <svg data-layer="5738def0-2ba9-42b0-96a8-a47382ed2549" preserveAspectRatio="none" viewBox="-0.5 0 1 15" class="x79"><path d="M 0 0 L 0 15"  /></svg>
</div>


    
    </body>
    </html>
            